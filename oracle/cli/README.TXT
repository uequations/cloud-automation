======================================
README for the Oracle Public Cloud CLI
======================================

-------------------
SUPPORTED PLATFORMS
-------------------
Ensure that the system on which you want to install the Oracle Public Cloud CLI tool is on one of the following supported platforms:
* Oracle Linux 6.6, 6.7, and 7.1
* OSX 10.12.6
* RedHat Enteprise Linux 6.7 and 7.1
* Ubuntu 16 and 17
* CentOS 7
* Windows Server 2008 R2 and 2012 R2

INSTALLING THE CLI CLIENT
1) Download the CLI installation bundle from OTN (http://www.oracle.com/technetwork/topics/cloud/downloads/opc-cli-3096036.html)
2) Unzip the CLI installation bundle:
	> unzip opc-cli-RELEASE.zip 
3) Go to the directory in which you extracted the ZIP file. The CLI is distributed as static binary files and as a Linux RPM package.  
5) You can install the CLI in one of the following ways.
   * By copying the binary file to an appropriate location.
        * On Oracle Linux, RedHat Enteprise Linux, Ubuntu, CentOS systems:
          > sudo cp ./linux/opc /usr/bin
        * On Mac OSX systems:
          > sudo cp ./darwin/opc /usr/bin
        * On Windows systems, update the value of the existing PATH environment variable to point to the location where the windows/opc.exe file is available on your system. For information about updating environment variables on a Windows system, refer to your Windows documentation.
   * By installing the RPM file on Oracle Linux, RedHat Enterprise Linux, and CentOS systems.
	1. Run the following command:
           > sudo yum -y install ./opc-cli-RELEASE.rpm
        2. When prompted, enter y.
           Wait till you see the Complete! message. The Oracle Compute Cloud Service CLI is installed.

After installing the CLI, create a profile to store your credentials and environment details.

--------------------
SETTING UP A PROFILE
--------------------
You can create a profile to store your authentication information and common settings. A sample_profile file is included in this distribution bundle.

The sample commands provided in this section are for the Bash shell. Based on your Linux shell, the commands you should use may vary.

1) Note down the REST API endpoint URL of your Oracle Compute Cloud Service site. To find out the REST API endpoint URL of your site, follow the instructions at http://www.oracle.com/pls/topic/lookup?ctx=cloud&id=compute-api-sendrequests.
2) Note your two-part user name (/Compute-identity_domain/user).  The account creation email from Oracle would contain the identity domain name, user name, and password for your Oracle Compute Cloud Service instance.
3) Store your password in a plain-text file of your choice (for example, in  ~/.opc/password).
4) Ensure that the file containing the password isn't world-readable, by changing the permission to 600:
	> chmod 600 ~/.opc/password
5) Create a directory where you want to save your profile file. For example, ~/.opc/profiles.
6) Create a new file in this folder. In this example, let’s create a profile with the file name default.

	> vi default

	
	{
	  "global": {
	    "format": "text",
	    "debug-requests": false
	  },
	  "compute": {
	    "user": "/Compute-IDENTITY_DOMAIN/USERNAME",
	    "password-file": "~/.opc/password",
	    "endpoint": "compute.us-0.oraclecloud.com"
	  }
	}

   Replace the values for user, password-file, and endpoint with information that is specific to your environment.

7) Ensure that the profile file isn't world-readable, by changing the permission to 600:
	> chmod 600 ~/.opc/profiles/default
8) The default profile file is 'default'.  You can override the default profile by setting the OPC_PROFILE_FILE environment variable:
	> export OPC_PROFILE_FILE="name-of-profile-file"
9) The default profile directory is ~/.opc/profiles  You can override the default profile directory by setting the OPC_PROFILE_DIRECTORY environment variable:
	> export OPC_PROFILE_DIRECTORY="/full/path/of/profile-directory"

Tip:
To make the environment variables persist across login sessions, add the export commands described earlier to your .bash_profile or .bashrc file.

--------------------------------
GETTING HELP AT THE COMMAND LINE
--------------------------------

While executing a command, you can access context-sensitive help at the command line.  For example:

	> opc compute --help
  returns the general syntax to use the CLI, the command-line options, and lists all the Oracle Compute Cloud Service resources that you can manage using the CLI tool.

	> opc compute security-lists add --help
  returns the command syntax to create a security list and descriptions for the required and optional arguments.

-------------------------- 
CHANGING THE OUTPUT FORMAT
-------------------------- 

You can view the output in one of the following formats:
	text - Plain-text format without any table borders. This is the default option.
	table - Formatted table with separators.
	json - JSON formated output

While using the -f table or -f text option, you can use the -F or -fields option to filter the attributes displayed in the table. The list of attributes that you can specify depends on the resource. For example, the SSH key resource has the attributes name, enabled, and key. You can use this option to filter the output to show only the attributes that you want to see, particularly for objects that have numerous attributes.

Example
	> opc -f table -F name,ram compute shapes list
	+------------+--------+
	     NAME    |  RAM
	+------------+--------+
	  oc3        |   7680
	  oc5        |  30720
	  oc4        |  15360
	  oc6        |  61440
	+------------+--------+
