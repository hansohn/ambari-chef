# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased](unreleased)

- no new features in development at this time

## [1.1.1](https://github.com/hansohn/ambari-chef/compare/1.1.0...1.1.1) (Dec 18, 2019)

BUG FIXES:

- update ambari agent sudoers file

## [1.1.0](https://github.com/hansohn/ambari-chef/compare/1.0.2...1.1.0) (Dec 17, 2019)

FEATURES:

- update default ambari version to 2.7.4
- update default java version to jdk-8u232-linux-x64 

## [1.0.2](https://github.com/hansohn/ambari-chef/compare/1.0.0...1.0.2) (May 31, 2019)

BUG FIXES:

- update attrbitute types to fix recipe inclusion and attribute overrides

## [1.0.0](https://github.com/hansohn/ambari-chef/compare/0.5.0...1.0.0) (May 29, 2019)

FEATURES:

- update attrbiute structure

BUG FIXES:

- call ambari version attributes at runtime

## [0.5.0](https://github.com/hansohn/ambari-chef/compare/0.4.1...0.5.0) (May 26, 2019)

FEATURES:

- just amazon corretto for java
- bump amabari version to 2.7.3

## [0.4.1](https://github.com/hansohn/ambari-chef/compare/0.4.0...0.4.1) (Aug 20, 2018)

BUG FIXES:

- update ssl password file name from http.pass.txt to https.pass.txt
- remove http.pass.txt file from ldap integration

## [0.4.0](https://github.com/hansohn/ambari-chef/compare/0.3.2...0.4.0) (Jul 24, 2018)

FEATURES:

- support version 2.4.0

## [0.3.2](https://github.com/hansohn/ambari-chef/compare/0.3.1...0.3.2) (Jul 23, 2018)

BUG FIXES:

- resolve issue where ambari version attribute is not intrepreted correctly when defined externally.

## [0.3.1](https://github.com/hansohn/ambari-chef/compare/0.3.0...0.3.1) (Jul 19, 2018)

BUG FIXES:

- grant missing ambari-agent sudo commands

## [0.3.0](https://github.com/hansohn/ambari-chef/compare/0.2.0...0.3.0) (Jul 19, 2018)

FEATURES:

- update licenses
- add vdf file upload functionality to ambari_cluster recipe

## [0.2.0](https://github.com/hansohn/ambari-chef/compare/0.1.0...0.2.0) (Jul 18, 2018)

FEATURES:

- bump ambari version to 2.7.0
- bump java version to 1.8.0_181
- add boolean to python recipes to toggle install
- add gpl.license.accepted attribute

BUG FIXES:

- create password.dat file if defining db password

## [0.1.0](https://github.com/hansohn/ambari-chef/compare/0.1.0...0.1.0) (Jun 19, 2018)

FEATURES:

- split out of [hdp-chef](https://github.com/hansohn/hdp-chef)
