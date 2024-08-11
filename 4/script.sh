#setup enviroment

#Install terraform from Yandex
wget https://hashicorp-releases.yandexcloud.net/terraform/1.9.4/terraform_1.9.4_linux_amd64.zip
mkdir /home/alex/terraform/
mv terraform_1.9.4_linux_amd64.zip /home/alex/terraform/
cd /home/alex/terraform/
unzip terraform_1.9.4_linux_amd64.zip  
export PATH=$PATH:/home/alex/terraform/
terraform --version

#Install YC

curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash

#config yc
#token: y0_AgAEA7qgo00AAATuwQAAAAEFQq7mAAAbxJ70ltdF1bB5zfA33V-WsBZmhg

yc init
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

yc resource-manager folder add-access-binding b1gbldqcbvmq6hh0agh0 --role editor --subject serviceAccount:aje41l40qup5drmeutt

yc iam key create \
  --service-account-id aje41l40qup5drmeuttj \
  --folder-name default \
  --output key.json

  yc config profile create netology-terraform


yc config set service-account-key key.json
yc config set cloud-id b1g1li51c4ebgmu7e9s6
yc config set folder-id b1gbldqcbvmq6hh0agh0

nano ~/.terraformrc 
#paste ->
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
#<-

# terraform.tf paste->

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-a"
}
# <-

#before: export PATH=$PATH:/home/alex/terraform/
terraform providers lock -net-mirror=https://terraform-mirror.yandexcloud.net -platform=linux_amd64 yandex-cloud/yandex

ssh-keygen -t ed25519

terraform init

#before:
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

# after 
terraform plan

sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt update
sudo apt install ansible

ansible-config init --disabled -t all > ansible.cfg

terraform apply


chmod 700 /root/.ssh




