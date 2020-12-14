# Linux Package Auto-installer

A fork of [https://www.lilite.co](https://www.lilite.co)

[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=flowalex_linux_package_installer&metric=sqale_rating)](https://sonarcloud.io/dashboard?id=flowalex_linux_package_installer)
[![Reliability Rating](https://sonarcloud.io/api/project_badges/measure?project=flowalex_linux_package_installer&metric=reliability_rating)](https://sonarcloud.io/dashboard?id=flowalex_linux_package_installer)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=flowalex_linux_package_installer&metric=security_rating)](https://sonarcloud.io/dashboard?id=flowalex_linux_package_installer)
[![Technical Debt](https://sonarcloud.io/api/project_badges/measure?project=flowalex_linux_package_installer&metric=sqale_index)](https://sonarcloud.io/dashboard?id=flowalex_linux_package_installer)
[![Bugs](https://sonarcloud.io/api/project_badges/measure?project=flowalex_linux_package_installer&metric=bugs)](https://sonarcloud.io/dashboard?id=flowalex_linux_package_installer)
[![Vulnerabilities](https://sonarcloud.io/api/project_badges/measure?project=flowalex_linux_package_installer&metric=vulnerabilities)](https://sonarcloud.io/dashboard?id=flowalex_linux_package_installer)
![Gitlab pipeline status](https://img.shields.io/gitlab/pipeline/flowalex/linux_package_installer/dev?label=Dev%20Build)
![Gitlab pipeline status](https://img.shields.io/gitlab/pipeline/flowalex/linux_package_installer/mainline?label=mainline%20Build)

## Versions
* Latest Release: ![Docker Image Version (latest semver)](https://img.shields.io/docker/v/flowalex/linux_package_installer?color=blue&sort=semver):
    * Size: ![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/flowalex/linux_package_installer?sort=semver)
* Latest Dev image: ![Docker Image Version (latest by date)](https://img.shields.io/docker/v/flowalex/linux_package_installer)
    * Size:![Docker Image Size (tag)](https://img.shields.io/docker/image-size/flowalex/linux_package_installer/latest)
## Supported Linux versions

- Ubuntu 20.04
- Ubuntu 18.04
- Ubuntu 16.04

If you're interested in building out support for another distro,
let me know! Some of the infra for distro-specific install methods is WIP.

## Contributing

To contribute, you just need to do two things:

1. Add the instructions on how to install a package
2. Add in the logo

Package definitions live in [packages/packages.json](https://github.com/cmoscardi/lilite/tree/master/packages). Logos live in [static/images](https://github.com/cmoscardi/lilite/tree/master/static/images)

### To add a new package

1. Make a new entry in `packages/packages.json`. There are three important fields:

    - `pre_install` : List of shell commands to run before installing the package.
    - `package_name` : Name of the package manager's package. This can be empty
                   if you're using a .deb file, for example.
    - `post_install` : List of shell commands to run after the package is installed
                   via package manager.

2. Add two copies of the logo - one "large" (i.e. original size) and one 48x48, PNG format - into static/images

### To test and debug locally

If you'd like to ensure everything is working before you send in a PR, then you can also set up a local environment to test.
1. `pip install -r requirements.txt` - This installs the required dependencies
2. Checkout the respective git branch
3. `python packages/seed_packages.py` - This will seed/prepare a local database
4. `python app.py` - will start the local server and you should see your package here
5. Select the linux version, select your package and click on install package. You'll see command to install it which looks somthing like this
`sudo apt-get install curl; curl 'http://127.0.0.1:5000/get_installer?version=ubuntu_16&packages=<PACKAGE_NAME>' | sudo bash`
6. Just run the curl command in your terminal and you'll see your script there. Ensure it's as intended.
7. Make a PR

[![SonarCloud](https://sonarcloud.io/images/project_badges/sonarcloud-black.svg)](https://sonarcloud.io/dashboard?id=flowalex_linux_package_installer)
