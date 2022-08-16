# Disclaimer
**Disclaimer: The information presented in this article is for educational/general information purposes only. Any scripts or examples are presented where-is, as-is, and are unsupported by Oracle Support and Development. Always refer to the official oracle documentation and other necessary documentation for offical steps.**


**TODO added Vulnerability Audit Step to scan codes whcih is not documented here**


1. Please refer to offical documentation for proper steps.
2. The scripts provided are just a reference/educational.


# Purpose
1. A simple demo on how oci devops work for weblogic server
2. Some steps are not explain in detail.

# Prereq
1. We are making use of compute instance to run webloigc, container artifacts, vaults, oci devops service
2. OKE is used to deploy our sample app.
3. Application is build devops services and the image is push to registry.
4.  Yaml files are stored in container artifacts.
5. Vaults are use to store some secret info.

sudoers for ocarun ALL=(ALL) NOPASSWD:ALL

py wlst script

shell script to dpeloy app

need dyanmic group

need policy

create folder in wls