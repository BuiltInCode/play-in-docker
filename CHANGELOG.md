# Play in Docker - Changelog
This documentation will contain high-level information regarding what has changed in each update revision.

Please keep in mind that this changelog contains release information for `Play in Docker`, **not** `Play Framework`. If 
you wish to see Play's changelog, please [click here](https://www.playframework.com/changelog).

## v2.8.0 (2020-02-05)
* Upgraded Play Framework version to use v2.8.0
* Upgraded Scala SBT version to use v1.3.5
* Upgraded `crossScalaVersions` to use the minimum Scala version v2.12.10

## v2.7.3 (2019-07-20)
* Re-wrote Dockerfile to use alpine-based images for better space conservation
* Implemented build arguments for faster upgrades/iterations in the future
* Implement CD/CI pipeline using CircleCI for instant builds of `Play in Docker`
* Upgraded Play Framework version to use v2.7.3
* Upgraded Java version to use OpenJDK 12 (alpine edition)
* Upgraded Scala version to use v2.13.0 (`Play Framework` was upgraded to use v2.13.0 in its 2.7.3 iteration)

## v2.7.2 (2019-06-03)
* Initial Release for `Play in Docker`
