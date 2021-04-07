
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
Hence, PSGestioIP was born.


### Built With

* [Powershell](https://docs.microsoft.com/en-us/powershell/)
* [VSCode](https://code.visualstudio.com/)
* [GestióIP](https://www.gestioip.net/)



<!-- GETTING STARTED -->
## Getting Started

You will need to manually the settings file under .\Settings with your information.
The module will keep refering to the settings file when reloaded.

### Prerequisites

* Powershell 5.1
* Licensed version of GestióIP to get access to the API.

### Installation
 
1. Clone the repo
```sh
git clone https://github.com/th3d00rw4y/PSGestioIP.git
```
2. Edit the settings file with your information.

3. Upon first import of the module, you will be prompted to supply a password for the GestióIP user you provided in the settings.csv.
This password will be stored in $env:TEMP as a encrypted secure string only readable by the user who created it and only on the machine it was executed on.

## Changelog

`PSGestioIP` is currently only maintained by me. I try to add as many features as possible, but family life has a higher priority for me right now.
- 0.0.10 -2021.04.07
  - [x] Rebuilt most of the functions to work better. 
  - [x] Added support to be able to retrieve the network category list.
  - [x] Wrote help sections for all CMDlets.
- 0.0.9 - 2021.04.03
  - [x] Changed namne of some files, further work on Get-DynamicParameter. Various fixes.
  - [x] Added this changelog.
- 0.0.8 - 2021.04.02
  - [x] Added support for dynamic parameters to be able to use validate set based on settings files.
  - [x] Reworked how default parameter vaules are populated. Cleaner way of getting data from settings.csv.
  - [x] Reworked how categories and sites settings will be handled. New private function: Get-GestioSettings. New public function: Sync-GestioSettings.
- 0.0.7 - 2021.04.01
  - [x] First initial upload.

<!-- USAGE EXAMPLES -->
## Usage

Get-Help PSGestioIp -Full


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