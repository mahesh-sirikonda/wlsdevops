# Disclaimer
**Disclaimer: The information presented in this article is for educational/general information purposes only. Any scripts or examples are presented where-is, as-is, and are unsupported by Oracle Support and Development. Always refer to the official oracle documentation and other necessary documentation for offical steps.**

1. Please refer to offical documentation for proper steps.
2. The scripts provided are just a reference/educational.


# Purpose
1. A simple demo on how oci devops work for weblogic server
2. Some steps are not explain in detail.
3. Rather than use oke, an agent (Compute Instance Run Command) will install on the compute and devops will use that agent to run your wlst or via wls rest mgmt api tools to deploy etc. The concept of CI still in place to do mvaen build etc. But for CD since it is vm based it can then make use of your weblogic tooling such as wlst, wls rest api or wdt (weblogic deployment tooling). The concept is the same as your current jenkins CI/CD for weblogic.
4. In here we are using wlst. It can change to any tool such as weblogic deploy tooling which make use of yaml file. https://oracle.github.io/weblogic-deploy-tooling/

# Prereq
1. We are making use of compute instance to run webloigc, container artifacts, vaults, oci devops service as well as App Dependency Management to scan code.
2. The steps are quite similair to https://github.com/wenjian80/helloHelidonDevops. But this is for weblogic vm and not OKE based.

refer to https://docs.oracle.com/en-us/iaas/Content/devops/using/deploy_instancegroups.htm
 
# Step 1 (WLS)
1. Spin up a compute and install weblogic or use market place. In here we are use VM based to run weblogic and not wls oke based.
2. Edit the /etc/sudoers file and added the below
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/sudoer.JPG)

Refer to https://docs.oracle.com/en-us/iaas/Content/Compute/Tasks/runningcommands.htm#permissions

# Step 2 (ADM)
1. Go to Developer Services->App Dependency Management->Koweledge based
2. Create a knowlegde based and jot down the ocid. We are going to use it later.

Refer to https://docs.oracle.com/en-us/iaas/Content/application-dependency-management/home.htm

Refer to https://blogs.oracle.com/cloud-infrastructure/post/security-scanning-for-maven-now-available-in-oci-devops

# Step 3 (Valut)
1. Go Identity & Security->Valut
2. Create secret to store weblolgic user name and password and jot down the ocid. We are going to use it later.
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/vault.JPG)

refer to https://docs.oracle.com/en-us/iaas/Content/devops/using/build_specs.htm

# Step 4 (Policy)
1. Follow https://github.com/wenjian80/helloHelidonDevops#prereq on how the policy is created.
2. We are also going to create a dynamic group to include this wls vm so it can use the oci devops. Then a policy will be create to all ow this dynmaic group to read vault/artifacts etc. The policy are not fine grain, i just grant to tenancy. Below is the screen shot which is self explanatory. The policies are quite untidy, but it give you a feel what polices are needed. Refer to oracle doc for policies statement

Refer to https://docs.public.oneportal.content.oci.oraclecloud.com/en-us/iaas/Content/Compute/Tasks/runningcommands.htm#permissions

Refer to https://docs.oracle.com/en-us/iaas/Content/devops/using/devops_iampolicies.htm

![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/dg1.JPG)

![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/dg2.JPG)

![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/policy.JPG)

# Step 5 (Devops Project)
Follow the below steps to set up artifacts/environment/code repo as well as devops project.

https://github.com/wenjian80/helloHelidonDevops#step-4-create-artifcat-registry

https://github.com/wenjian80/helloHelidonDevops#step-5-create-devops-project

https://github.com/wenjian80/helloHelidonDevops#step-6-create-environment

https://github.com/wenjian80/helloHelidonDevops#step-7-create-code-repo

# Step 6 (Pipeline)
1. Below is a screen shot of how things will look like. it is self explanatory, i will find time to explain each screen shots.

Maven Build
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/maven_build.JPG)

Push artifcats
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/push_artifcats.JPG)

Deploy to wls which later will call wlst to deploy to weblogic.
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/deploy_wls.JPG)

parameters 
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/build_piple_parameters.JPG)

# Step 7 (build spec)
 it is self explanatory, i will find time to explain each screen shots for the build specs in https://github.com/wenjian80/wlsdevops/blob/main/build_spec.yaml

using vaults to store weblogic user name and password
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/wls_valut.JPG)

Install jdk
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/installjdk.JPG)

maven build
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/buildcode.JPG)

App Dependency Management scanning of the codes in pom file
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/adm.JPG)

Store those asset in artifcacts
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/storing%20artifcats.JPG)

# Step 8 (Deployment pipeline)
Deployment view
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/deployment1.JPG)

Details of the deployment
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/deployment2.JPG)

# Step 9 (Deployment Spec)
1. Refer to https://github.com/wenjian80/wlsdevops/blob/main/deployment_spec.yaml
2. in short what is trying to do is to use vault to replace the weblogic user name and password. It change the permission of the files and run /u01/devops/deployapp.sh. https://github.com/wenjian80/wlsdevops/blob/main/deployapp.sh  refer to oracle docs for more information.

![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/deplopymentspec.JPG)

![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/deploypassword.JPG)

# Step 10 (Run the pipeline which will also run the deployment)
Running the pipeline
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/run1.JPG)

See the deployment
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/run2.JPG)

Go to instance->compute (your wls compute)->Run command and see the command
![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/run3.JPG)

![enter image description here](https://github.com/wenjian80/wlsdevops/blob/main/image/run4.JPG)

# Step 11 ADM report to scan java pom file code
![enter image description here](https://github.com/wenjian80/helloHelidonDevopsScreenShots/blob/main/adm_report.JPG)
