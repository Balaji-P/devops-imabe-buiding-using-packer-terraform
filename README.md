# Test task for DevOps position

## Requirements

* You must have [Packer](https://www.packer.io/) installed on your computer. Tested on v 1.4.2
* You must have [Terraform](https://www.terraform.io/) installed on your computer.  
**NB! Terraform version used 0.12.4**
* You must have a [Google Cloud Platform (GCP)](https://cloud.google.com/) account.
* You must have downloaded a Google Cloud Platform credentials file.
* You must have enabled the Google Compute Engine API.

## Before we start

Configure your Google Cloud access keys.

Set `GOOGLE_APPLICATION_CREDENTIALS` environment variable. The variable must contain the path to the credentials file.

```bash
cat <<EOT >> .env
export GOOGLE_APPLICATION_CREDENTIALS="<YOUR_PATH_TO_CREDS.json>"
EOT
```

Now we need to set extra variables we will use later in our project.

```bash
cat <<EOT >> .env
export ZONE=us-central1-a
export REGION=us-central-1
export IMAGE_ID=vliubko-test-task
export PROJECT_ID=$(gcloud config get-value project)
EOT
```

```bash
source .env
```

## Build Packer Image

```bash
./packer/run_packer.sh
```
Run this script to start building image with nginx.  

I'm using some variables in Packer to build image: getting current gcloud Project ID and latest Ubuntu base image.

## Terraform: Up and Running :)

I've used Terraform 0.12 for this task.  
Decided to make a little module for firewall rules.  
Terraform state stored only locally.

Run scripts to save TF variables and then use them in deploying infrastructure.

```bash
cd terraform
echo zone=\"$ZONE\" >> terraform.tfvars
echo region=\"$REGION\" >> terraform.tfvars
echo project_id=\"$PROJECT_ID\" >> terraform.tfvars
echo image=\"$IMAGE_ID\" >> terraform.tfvars
```

```bash
terraform init
terraform apply -var-file=terraform.tfvars
```

To check everything is OK, use command below.
```bash
curl $(terraform output nginx_public_ip)
```

## Deleting resources

Don't forget to delete your resources after running all staff above.

```bash
terraform destroy
gcloud compute images delete $IMAGE_ID
```
