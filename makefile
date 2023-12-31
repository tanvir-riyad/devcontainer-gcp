KEY_FILE := auth.json
PROJECT_ID := ######
greet:=hello tanvir
VPC_NAME := docker-devcontainer-class
SUBNET_NAME := devcontainer-subnet
REGION := us-east1
CIDR_BLOCK := 10.10.0.0/16
VM_NAME := devcontainer-1
COMPUTE_ZONE := us-east1-b
VM_TYPE := n1-standard-1
VM_IMAGE_FAMILY := debian-11
VM_IMAGE_PROJECT := debian-cloud
SSH_PUBLIC_KEY := #################################
INTERNAL_IP_RANGE := 31.43.23.23

echo:
	@ echo ${greet}

gcloud_login:
	@ gcloud auth activate-service-account --key-file=${KEY_FILE}

gcloud_set_project:
	@ gcloud config set project ${PROJECT_ID}

gcloud_list_networks:
	@ gcloud compute networks list

gcloud_describe_network:
	@ gcloud compute networks describe ${VPC_NAME}

create_vpc:
	@ gcloud compute networks create ${VPC_NAME} --subnet-mode=custom

create_subnets:
	@ gcloud compute networks subnets create ${SUBNET_NAME} --network=${VPC_NAME} --region=${REGION} --range=${CIDR_BLOCK}

gcloud_list_subnet:
	@ gcloud compute networks subnets list

gcloud_create_vm:
	@ gcloud compute instances create ${VM_NAME} \
        --zone=${COMPUTE_ZONE} \
        --machine-type=${VM_TYPE} \
        --image-family=${VM_IMAGE_FAMILY} \
        --image-project=${VM_IMAGE_PROJECT} \
        --boot-disk-size=20GB \
        --metadata=ssh-keys="$(SSH_PUBLIC_KEY)"

delete_vm:
	@ gcloud compute instances delete ${VM_NAME} --zone=${COMPUTE_ZONE} --quiet

create_firewall_internal:
	@ gcloud compute firewall-rules create allow-internal --network ${VPC_NAME} --allow tcp,udp,icmp --source-ranges ${INTERNAL_IP_RANGE}

create_firewall_allow_all:
	@ gcloud compute firewall-rules create allow-all-${VPC_NAME} --network ${VPC_NAME} --allow tcp,udp,icmp --source-ranges 0.0.0.0/0

gcloud_ssh:
	@ gcloud compute ssh ${VM_NAME} --project=${PROJECT_ID} --zone=${COMPUTE_ZONE} --ssh-key-file ./ssh_key_file
