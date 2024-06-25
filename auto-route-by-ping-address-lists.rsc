# This script will check the ping from a list of addresses and add it to new list with interface name and auto prefix: like `auto-vpn-1`
# The list of addresses must be named "AUTO-ROUTE"

# Define the main interface
:local mainInterface "pppoe-main"

# Define the table to check
# The first one is the main internet connection (default)
:local interfaces {
    "vpn-sing";
    "vpn-wrap";
    "vpn-viettel"
}

:local addressList [/ip firewall address-list find list=AUTO-ROUTE]
:log info "Starting the check-ping script"

:foreach i in=$addressList do={
    :local address [/ip firewall address-list get $i address]
    :if ([:typeof [:toip $address]] = "ip") do={
        :local name [/ip firewall address-list get $i comment]
        :local tagComment ("auto-" . $name)
        :local existTagged [/ip firewall address-list find comment=$tagComment]

        :local picked ($mainInterface)
        :local bestPing 0

        # Checking main first to set default bestPing
        :local mPing [/ping $address count=3 interface=$mainInterface as-value]
        :foreach try in=$mPing do={:set bestPing ($bestPing + ($try->"time"))}
        :set bestPing ($bestPing / [:len $mPing])

        # Compare with other interfaces
        :foreach interface in=$interfaces do={
            :local ping [/ping $address count=3 interface=$interface as-value]
            :local avg 0

            :foreach try in=$ping do={:set avg ($avg + ($try->"time"))}
            :set avg ($avg / [:len $ping])

            :if ($avg < $bestPing) do={
                :set bestPing $avg
                :set picked $interface
            }
        }
        :log info ("Setting route for " . $address . " to " . $picked . " with ping " . $bestPing)

        :if ([:len $existTagged] = 0) do={
            # If picked is main, no need to mark-routing
            :if ($picked != $mainInterface) do={
                /ip firewall address-list add address=$address list=$picked comment=$tagComment
            }   
        } else={
            # If picked is main, remove the mark-routing
            :if ($picked = $mainInterface) do={
                /ip firewall address-list remove $existTagged
            } else={
                /ip firewall address-list set $existTagged list=$picked
            }
        }
    }
}
:log info "Finished the check-ping script"
