
<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
    * [Built With](#built-with)
* [Getting Started](#getting-started)
    * [Prerequisites](#prerequisites)
    * [Installation](#installation)
* [Usage](#usage)
* [Changelog](#Changelog)
* [Roadmap](#roadmap)
* [License](#license)
* [Contact](#contact)
* [Acknowledgements](#acknowledgements)



<!-- ABOUT THE PROJECT -->
## About The Project
The idea began when I was introduced to my companys IPAM, which was GestióIP.
I quickly realized this would be a perfect chance to try and create something that would eliminate tiresome efforts to manually enter new information into the system.
PSGestioIP took shape.


### Built With

* [Powershell](https://docs.microsoft.com/en-us/powershell/)
* [VSCode](https://code.visualstudio.com/)
* [GestióIP](https://www.gestioip.net/)



<!-- GETTING STARTED -->
## Getting Started

You will need to manually edit the settings file under .\Settings with your information.
The module will keep refering to the settings file when reloaded.

### Prerequisites

* Powershell 5.1
* Licensed version of GestióIP to get access to the API.
* At least version 3.5.48 of the Gestió API

### Installation
 
1. Clone the repo
```sh
git clone https://github.com/th3d00rw4y/PSGestioIP.git
```
2. Edit the settings file with your information.

3. Upon first import of the module, you will be prompted to supply a password for the GestióIP user you provided in the settings.csv.
This password will be stored in $env:TEMP as a encrypted secure string only readable by the user who created it and only on the machine it was executed on.

## Changelog

`PSGestioIP` is currently only maintained by me. I will try to add as many features as possible.
- 0.0.6 -2021.04.07
  - [x] Rewrote most of the public functions to work better.
  - [x] Added support to be able to retrieve the network category list from GestióIP API in `Sync-GestioCategory` and `Get-DynamicParameter`
      - [x] Thank you [Marc Uebel](https://github.com/muebel) for updating the API in like 15 minutes after I asked the question! 😊
  - [x] Changed name on:
      - [x] `Get-GestioSettings` -> `Get-GestioCategory`
      - [x] `Sync-GestioSettings` -> `Sync-GestioCategory`
  - [x] Wrote help sections for all functions.
- 0.0.5 - 2021.04.06
  - [x] Added support for dynamic parameters to be able to use validation sets based on settings files.
  - [x] Reworked how categories and sites settings will be handled.
  - [x] New public functions:
      - [x] `Sync-GestioSettings`.
          - [x] Synchronizes either Host or Site categories. Or both of them.
          - [x] Categories will be stored in .txt files in $env:TEMP
          - [x] The categories will be used to populate category validation sets in the modules functions.
      - [x] `Get-GestioHostList`
          - [x] Utilizing the request type "listHosts", this function will retrieve a list of hosts matching the search critera entered in the different parameters.
          - [x] Parameters: `[string]`Hostname, `[string]`Comment, `[string]`Description, `[string]`Category, `[string]`Site, `[string]`Wildcard
              - [x] The wildcard parameter is kinda cool. It will allow you to search for one of the five strings with only a partial string.
      - [x] `Get-GestioNetworkList`
          - [x] Utilizing the request type "listNetworks", this function will retrieve a list of networks matching the search critera entered in the different parameters.
          - [x] Parameters: `[string]`Comment, `[string]`Description, `[string]`Category, `[string]`Site, `[string]`Wildcard
  - [x] New private functions:
      - [x] `Get-GestioSettings`
          - [x] This function will read the category and site categories from the API and store the sets in .txt files under $env:TEMP
      - [x] `Get-DynamicParameter`
          - [x] Builds parameters with validation sets based on the categories from the host and site files.
- 0.0.4 - 2021.04.04
  - [x] New public functions:
      - [x] `Add-GestioHost`
          - [x] Utilizing the request type 'createHost', this function will create a host on the supplied Ip togehter with information from other parameters used.
          - [x] Parameters: `[string]`Ip, `[string]`Hostname, `[string]`Description, `[string]`Category, `[string]`, `[string]`Site, `[switch]`int_Admin, `[string]`Comment
      - [x] `Remove-GestioHost`
          - [x] Utilizing the request type "deleteHost", this function will based on either Ip or Hostname remove a host entry in GestióIP.
          - [x] Parameters: `[string]`Ip, `[string]`Hostname
          - [x] Note from the API documentation: 
              - [i] IP addresses are unique. Hostnames may not be unique.
              - [i] If there are more than one host with the same hostname found in the database, the first found host will deleted."
              - [x] Conclusion: Use Ip when removing hosts.
  - [x] New private functions:
      - [x] `Test-GestioCredential`
          - [x] Upon first import of the module, this function kicks in when the password is entered to ensure that it is the correct password.
      - [x] `Format-UsedParameters`
          - [x] Formats strings passed in parameters to match the API call structure.
- 0.0.3 - 2021.04.03
  - [x] Changed namne of some files and various fixes.
  - [x] Added this changelog.
  - [x] New public functions:
      - [x] `Get-GestioFirstFreeNetworkAddress`
          - [x] Utilizing the request type "firstFreeNetworkAddress". This function will based on the Ip address provided retrieve the first free Ip address.
          - [x] Parameters: `[string]`Ip
      - [x] `Get-GestioFreeNetworkAddresses`
          - [x] Utilizing the request type "freeNetworkAddresses", This function will retrieve all the free addresses from supplied network address.
          - [x] Parameters: `[string]`Ip
  - [x] New private function:
      - [x] `Format-GestioResponse`
          - [x] Sees that you only get what you actually want from the API call.
- 0.0.2 - 2021.04.02
  - [x] Reworked how default parameter vaules are populated. Cleaner way of getting data from settings.csv.
- 0.0.1 - 2021.04.01
  - [x] First commit.
  - [x] Available but not finished public functions:
      - [x] `Get-GestioHost`
          - [x] Utilizing the request type "readHost", this function will retrieve a host based on either Ip address or hostname.
          - [x] Parameters: `[string]`Ip, `[string]`Hostname
      - [x] `Get-GestioNetwork`
          - [x] Utilizing the request type "readNetwork", this function will retrieve information on the network of the Ip address provided.
          - [x] Parameters: `[string]`Ip
  - [x] Available and kinda finished private functions:
      - [x] `Invoke-GestioIP`
          - [x] Sort of the heart of it all. Every public function calls this one with it's formatted request string.
      - [x] `Save-GestioCredential`
          - [x] Upon first import of the module you'll be prompted to enter the password for the user you've supplied in Settings.csv.
          - [x] The secure string will be saved using `Export-CliXML` in $env:TEMP, readable only by the user importing the module and only on the machine that it was executed on.
      - [x] `Get-GestioCredential`
          - [x] Retrieves the encrypted secure string previously stored in $env:TEMP
      - [x] `Get-PlainText`
          - [x] Converts the secure string to plaintext to be able to pass it into the API call. `The password will never be written out in plaintext!`
      - [x] `Get-AuthenticationToken`
          - [x] Generates the token for the API call.
  - [-] Trying to learn how github works.

<!-- USAGE EXAMPLES -->
## Usage

Get-Help `Function-Name` -Full


<!-- ROADMAP -->
## Roadmap

 - [x] Adding compability for handling VLANs

 - [x] Adding compability for handling Networks

 - [x] Adding compability for handling users


<!-- CONTACT -->
## Contact

Mail me: [Simon Mellergård](mailto:simon.mellergardh@gmail.com)


<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements
Marc Uebel who created [GestióIP](https://gestioip.net)