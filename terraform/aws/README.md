     Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently(terraform.io).  Terraform can be installed on a variety of platforms.  Refer to the documentation for installation instructions [1].  To verify, running 'terraform --version' should be sufficient. 

     Terraform uses the concept of providers having the capability to interact with the APIs of a growing number of XAAS services to expose instances.  In our example, we will be working with the "aws" provider. 

     Generally, before using a provider, you'll have to create your GO build environment and use make to build it.  Fortunately, the AWS provider is common enough Terraform can install it from Hashicorp automatically during installation (https://releases.hashicorp.com). Let's create a simple Terraform script to show this.  We'll aptly name it provider.tf: 
 
          provider.tf 
          provider "aws" {} 
 
     Now, just run the:

          terraform init  

     command and watch it work.  You'll probably get a recommendation to add a version constraint before it installs the provider. 

     We're, now, going to try some things.  Let me not fail to mention each time we try something new, we will be creating a new directory (i.e. mkdir 1, mkdir 2, ... etc.), and copying the files to it.  I'll leave it up to you to see if you can follow the recommendation and add a version constraint to the provider configuration.  Once you're done, you can use the 'terraform providers' command to verify.  We'll want to supply other values to our provider configuration as well.  For example, for the AWS provider, the AWS region is required. 

     There are a few ways to set this and other values like the Secret Access Key and Access Key Id.  We'll be using a shared credentials file for this.  You may have the AWS CLI installed and a read/write protected 'credentials' file in your $HOME/.aws/ folder already.  If not, I recommend verifying you have the AWS CLI installed (aws --version) and using 'aws configure' to do this.  Refer to the AWS Documentation for details [2][3]. 

     Your AWS CLI configuration can be verified with the 'aws configure list' command. 

    At this point, I think we're ready to configure our first resource.  An introduction to resources can be found on the Terraform site [4].  Given we're using Terraform with AWS, you can probably guess our first resource will be an Amazon EC2 instance.  The AWS provider identifies this as an "aws_instance" resource [5]. 
 
    We'll start with its two required arguments of 'ami' and 'instance_type."  In general, we'd like to benefit from the flexibility of variables, and so our example will reflect this. 

     Let's start with a fairly minimal variables.tf file: 
 
          variables.tf 
          variable "aws_ami" { 
          description = "The AMI to use for the instance" 
          default = "ami-6871a115" #Red Hat Enterprise Linux 7.5 (HVM), SSD Volume Type 
          } 
 
          variable "aws_instance_type" { 
          description = "The type of instance to start." 
          default = "t2.micro" #Free tier eligible 
          } 
 
          variable "aws_region" { 
          description = "The AWS region" 
          default = "us-east-1" 
          } 
 
     In the same directory, we also have our provider.tf and main.tf files: 
 
          provider.tf 
          provider "aws" { 
          region = "${var.aws_region}" 
          } 

          main.tf 
          resource "aws_instance" "resource name" { 
          ami = "${var.aws_ami}" 
          instance_type = "${var.aws_instance_type}" 
          } 

     Assuming you have already run 'terraform init' in this directory, we should be ready to run:

          terraform plan 

     As the name suggests, this creates an execution plan that can be later applied.  Generally, we'd add an '-out' flag to tell Terraform where to save the plan file.  Let's leave this out, for now, until we talk about how to encrypt it.  When the command is executed, you may be prompted to enter the region.  If you're satisfied with the default, just press enter. 

     From there, you can run: 

          terraform apply

     This will look a whole lot like 'terraform plan' with the exception of the last step where you have to type 'yes' to approve the actions listed in the plan.  When the process is complete, you should get a green confirmation message: 

          Apply complete! Resources: 1 added, 0 changed, 0 destroyed. 
    
     If you're still not convinced, you can use the: 
  
          aws ec2 describe-instances 

command to see info on the newly created and running instance. 

     You can see in this example, we've used a ton of defaults.  In the real world, you'd want to do more customization.  It is very possible the necessary level of customization may get to the point where we use something called a module instead of just a resource.  This is outside the scope, so, for now, we'll just marvel at our handiwork.  When you're done doing so,  

          terraform destroy 

should tear everything down.  

     Finally, instead of accepting the default values of your variables, you can certainly, as with any variable, pass in different values. 

     Let's say we wanted an Ubuntu instance instead of a Red Hat one.  We can just create a *.tfvars file to pass in its AMI id. 
 
          ubuntu_aws_instance.tfvars 
          aws_ami = "ami-43a15f3e" #Ubuntu Server 16.04 LTS (HVM), SSD Volume Type 
 
     Now, after the 'terraform plan' step, we add a '-var-file' flag to the 'terraform apply' command to make the change: 
   
          terraform apply -var-file="ubuntu_aws_instance.tfvars" 
   
     Patiently wait for the instance to be created.  You're done :-). 
   
     See where you can go from here.  Feel free to refer to the source on Github [7].

References: 

[1]  "Introduction to Terraform." [Online].  Available: https://www.terraform.io/intro/index.html 

[2]  "Install Terraform." [Online].  Available: https://www.terraform.io/intro/getting-started/install.html 

[3]  "Installing the AWS Command Line Interface." [Online]. Available: https://docs.aws.amazon.com/cli/latest/userguide/awscli-install-linux.html 

[4]  "Configuring the AWS CLI." [Online]. Available: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html 

[5]  "Resource Configuration." [Online]. Available: https://www.terraform.io/docs/configuration/resources.html 

[6]  "AWS Provider." [Online].  Available: https://www.terraform.io/docs/providers/aws/index.html 

[7]  "Terraform AWS Demo Source on Github." [Online].  Available: https://github.com/uequations/cloud-automation/tree/master/terraform/aws/demo
