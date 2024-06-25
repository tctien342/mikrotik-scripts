# MikroTik Script Collection

Welcome to the MikroTik Script Collection repository. This repository is a curated collection of scripts designed to enhance and automate various functionalities on MikroTik routers. These scripts are intended for network administrators, IT professionals, and anyone interested in optimizing their MikroTik router's performance and capabilities.

## About MikroTik Scripts

MikroTik scripts are written in MikroTik's scripting language, which allows for automation of tasks on MikroTik RouterOS. These scripts can be used to configure the router, manage networking functions, monitor system events, and much more.

## Repository Structure

This repository contains individual `.rsc` files, each implementing a specific functionality or automation task. Here is a brief overview of the current scripts available:

- **auto-route-by-ping.rsc**: Automatically sets the route to the best interface based on ping response times from a list of addresses.
- **auto-route-by-ping-address-lists.rsc**: Automatically sets the route to the best interface based on ping response times from a list of addresses stored in address lists.

## Getting Started

To use the scripts in this repository, follow these steps:

1. **Download the Script**: Choose the script you want to use and download it from this repository.
2. **Upload to MikroTik Router**: Use FTP, WinBox, or any other method to upload the script file to your MikroTik router.
3. **Run the Script**: Access your MikroTik router through WinBox or terminal. Navigate to the location of the script and run it using the MikroTik command line interface.

## Usage Example

For [`auto-route-by-ping.rsc`](command:_github.copilot.openRelativePath?%5B%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2Fhome%2Fsaintno%2Fsources%2Fmikrotik-scripts%2Fauto-route-by-ping.rsc%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%5D "/home/saintno/sources/mikrotik-scripts/auto-route-by-ping.rsc"):

1. Upload the script to your MikroTik router.
2. Open the terminal in WinBox or connect via SSH.
3. Run the script by typing `/import file-name=auto-route-by-ping.rsc`.

## Contributing

Contributions to this repository are welcome. If you have a useful MikroTik script that you'd like to share, please create a pull request with your script and a brief description of its functionality.

## Disclaimer

These scripts are provided "as is", without warranty of any kind. Use them at your own risk. Always test scripts in a controlled environment before deploying them in a production environment.
