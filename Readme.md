<!--
repo name: PSGestioIP
description: Powershell module to integrate with the GestioIp API
github name:  th3d00rw4y
link: LINK
logo path: assets/logo.png
screenshot: assets/ss.png
twitter: -
email: simon.mellergar@varnamo.se
-->

<!-- PROJECT SHIELDS -->


<!-- PROJECT LOGO
<br />
<p align="center">
    <a href="LINK">
        <img src="assets/logo.png" alt="Logo" width="80" height="80">
    </a>
    <h3 align="center">LINK</h3>
    <p align="center">
        BEST-README
        <br />
        <a href="LINK"><strong>Explore the docs �</strong></a>
        <br />
        <br />
        <a href="//github.com/BEST-README/ oGranny">View Demo</a>
        �
        <a href="LINK/issues">Report Bug</a>
        �
        <a href="LINK/issues">Request Feature</a>
    </p>
</p>
-->


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
* [Contributing](#contributing)
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

You will need to manually edit all the files under .\Settings with your information.
The module will keep refering to the settings files when reloaded, so when adding for example a new site in GestióIP, add it to the corresponding settings file.

### Prerequisites

* Powershell 5.1
* Licensed version of GestióIP to get access to the API.

### Installation
 
1. Clone the repo
```sh
git clone https://github.com/th3d00rw4y/PSGestioIP.git
```
2. Edit all of the settings files with your companys information.

4. Upon first import of the module, you will be prompted to supply a password for the GestióIP user you provided in the settings.csv.
This password will be stored in $env:TEMP as a encrypted secure string only readable by the user who created it and only on the machine it was executed on.

## Changelog

`PSGestioIP` is currently only maintained by me. I try to add as many features as possible, but family life has a higher priority for me right now.

- 0.0.1.1 - 2021.04.03
  - [x] Changed namne of some files, further work on Get-DynamicParameter. Various fixes.
  - [x] Added this changelog.
- 0.0.1.1 - 2021.04.02
  - [x] Added support for dynamic parameters to be able to use validate set based on settings files.
  - [x] Reworked how default parameter vaules are populated. Cleaner way of getting data from settings.csv.
  - [x] Reworked how categories and sites settings will be handled. New private function: Get-GestioSettings. New public function: Sync-GestioSettings.
- 0.0.1.0 - 2021.04.01
  - [x] First initial upload.

<!-- USAGE EXAMPLES -->
## Usage

Get-Help PSGestioIp -Full


<!-- ROADMAP -->
## Roadmap

Adding compability for handling VLANs 
Adding compability for handling Networks
Adding compability for handling users



<!-- CONTRIBUTING --
## Contributing


<!-- LICENSE --
## License


<!-- CONTACT -->
## Contact

Your Name - [u/th3d00rw4y](https://www.reddit.com/user/th3d00rw4y)