# This script will check the ping from a list of addresses and set the route to the best interface
# The list of addresses must be named "AUTO-ROUTE"

# Define the interfaces to check
# The first one is the main internet connection (default)
:local interfaces {
    "pppoe-main";
    "l2tp-vultr-sing";
    "wireguard-wrap";
}

:local addressList [/ip firewall address-list find list=AUTO-ROUTE]
:log info "Starting the check-ping script"

:foreach i in=$addressList do={
    :local address [/ip firewall address-list get $i address]
    :local name [/ip firewall address-list get $i comment]
    :if ([:typeof [:toip $address]] = "ip") do={
        :local picked ($interfaces->0)
        :local bestPing 999999

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
        :local comment ("AUTO-ROUTE - " . $address . " - " . $name)
        :local routeExist [/ip route find where dst-address=$address]

        :if ([:len $routeExist] = 0) do={
            /ip route add dst-address=$address gateway=$picked distance=1 comment=$comment
        } else={
            /ip route set $routeExist gateway=$picked  comment=$comment
        }
    }
}
:log info "Finished the check-ping script"
