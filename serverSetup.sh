az configure --defaults location=uksouth

az configure --defaults group=JenkinsGroup

az group create --resource-group JenkinsGroup --location uksouth

#az network vnet create --resource-group JenkinsGroup --name JenkinsNetwork --address-prefixes 10.0.0.0/16 --subnet-name JenkinsSubnet --subnet-prefix 10.0.0.0/24

az network vnet subnet create --resource-group JenkinsGroup --vnet-name JenkinsNetwork --name JenkinsSubnet --address-prefixes 10.0.0.0/16 --subnet-name JenkinsSubnet --subnet-prefixes 10.0.0.0/24

az network nsg create --resource-group JenkinsGroup --name JenkinsNSG

#az network nsg rule create --resource-group JenkinsGroup --name HTTP --priority 500 --nsg-name JenkinsNSG

az network nsg rule create --resource-group JenkinsGroup --name SSH --destination-port-ranges 22 --nsg-name JenkinsNSG --priority 400

az network public-ip create --resource-group JenkinsGroup --name JenkinsIP --dns-name bazzatron3000 --allocation-method Static

az network nic create --resource-group JenkinsGroup --name JenkinsNIC --vnet-name JenkinsNetwork --subnet JenkinsSubnet --network-security-group JenkinsNSG --public-ip-address JenkinsIP

az vm create --resource-group JenkinsGroup --name JenkinsHostVM --image UbuntuLTS --nics JenkinsNIC --size Standard_B1ls

#az vm create --resource-group JenkinsGroup --name JenkinsSlaveVM --image UbuntuLTS --nics JenkinsNIC --size Standard_B1ls

#az vm create --resource-group JenkinsGroup --name PythonServerVM --image UbuntuLTS --nics JenkinsNIC --size Standard_B1ls
