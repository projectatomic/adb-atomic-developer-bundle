# Changelog

## Unreleased
- Fix-256: Add check for vagrant-registration plugin @budhrg
- Refactored code for checking required plugins for CentOS files @budhrg
- Update README for RHEL component @praveenkumar

## v1.8.0 Apr 5, 2016
- Update Vagrantfiles with RHEL files @LalatenduMohanty
- Update os-release to 1.8.0 @LalatenduMohanty
- Remove docker-registry from installed packages @praveenkumar
- Use copy rather than shell in ansible playbook for Mesos Vagrantfile @mscherer
- Adding fuse-sshfs to the ADB box @LalatenduMohanty

## v1.7.2 Mar 24, 2016
- Changes for release 1.7.2 @LalatenduMohanty
- OpenShift Vagrantfile mod to reflect new command @bexelbie

## v1.7.1 Mar 9, 2016
- Revert "Adding openshift2nulecule to ADB" @LalatenduMohanty
- Adding openshift2nulecule to ADB @LalatenduMohanty
- Update docs for Fedora libvirt @bexelbie
- Fixing minor typos @Preeticp
- Fixing a typo @Preeticp
- Adding vagrant-service-manager to the Vagrantfiles @LalatenduMohanty
- Removing the sed commands beacsue these are not required anymore @LalatenduMohanty
- Deleting unneeded landrush information @bexelbie
- Adding changelog for ADB 1.7.0 @LalatenduMohanty
- Bumping the Vagrant box version in the build script to 1.7 @LalatenduMohanty
- Support openstack provider in vagrantfiles @vrutkovs
- Set ip address for marathon and mesos-slave before installing packages. @kadel

## v1.7.0 Feb 17, 2016

- Adding link to older OpenShift Vagrantfile   @LalatenduMohanty
- Adding adb-utils, centos-release-adb    @LalatenduMohanty
- Updates usage docs with renamed plugin vagrant-service-manager   @navidshaikh
- Renames adbinfo with service-manager plugin in README    @navidshaikh
- Bumping the os-release version to 1.7.0  @LalatenduMohanty
- Fix #224 (Provision fails after rebooting the machine)  @praveenkumar
- Fix #226 (cert-gen script should be part of adb-utils package)  @praveenkumar
- Fix #222 httpd-tools package should be present in kickstart file  @praveenkumar
- Added IP Address info to conf files of mesos-slave and Marathon @dharmit
- Fixed a broken link   @containscafeine
- Provide more debug output  @voxik
- Fix #207 and #208    @praveenkumar
- Updates the quotes for box update documentation  @navidshaikh
- Updating MAINTAINERS for atlas.hashicorp.com info   @bexelbie
- Add a Changelog   @bexelbie
- Cleanup old ADB v1 files   @bexelbie

## v1.6.0 Jan 21, 2016


- Adds Praveen Kumar as maintainer for ADB @navidshaikh
- Update Docs for vagrant-libvirt bug @bexelbie
- Use projectatomic/adb as box for centos-openshift-setup @kadel
- Changed the state of packages installed via Ansible from latest to present @dharmit
- Updating Mesos Marathon use information @LalatenduMohanty
- Fix #183, added version info for ADB @praveenkumar
- Update README to be more readable in a text editor @bexelbie @tkdchen
- Vagrantfile for Mesos-Marathon setup @dharmit
- Fix #175 and #174, Add CI for spell and kickstart check @praveenkumar
- Fix and re-organize docs @tkdchen
- More minor doc fixes @bexelbie
- Fixing RST Format Typos @bexelbie
- Documentation Updates for Usage @bexelbie
- Update the OpenShift Vagrantfile's README @bexelbie
- Cleanup k8s Vagrantfile Readme and add network @bexelbie
- Update the base example Vagrantfile and README @bexelbie
- Updates Install for better libvirtd comments @bexelbie
- Changes atlas namespace to projectatomic/adb @LalatenduMohanty
- Updates docs with Eclipse integration notes @bexelbie

## v1.5.0 Dec 16, 2015

- Announcement: http://www.projectatomic.io/blog/2015/12/ADB-1-5/

## Prior Releases were unannounced and mostly project internal.
