# Prerequisites
You will need to install the following applications onto your machine:

```
ansible 2.11.6
Packer v1.7.8
Terraform v1.0.8
aws-cli/2.2.40
```

Note: Packer is a prerequisite for admins but not for developers

# Step 1. Build the packer environment

Create the build vpc for creating the corda ami's
```
cd prerequisites
terraform init
terraform apply
```

# Step 2. Create your ami
Once you have installed the prereqs build your images using the following commands:


1. Create base ami
```
cd  packer
packer build -var-file="config/aws.json" corda_base_ami.json
```
2. Create Corda ami
```
cd packer (if you are not already in the directory)
packer build -var-file="config/aws.json" corda_ami.json
```
