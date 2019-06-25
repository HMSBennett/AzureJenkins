az group create --resource-group JenkinsGroup

az network vnet create --resource-group JenkinsGroup --name JenkinsNetwork --address-prefixes 10.0.0.0/16 --subnet-name JenkinsSubnet --subnet-prefix 10.0.0.0/24

az network vnet subnet create --resource-group JenkinsGroup --vnet-name JenkinsNetwork --name JenkinsSubnetHost --address-prefixes 10.0.10.21/24

az network vnet subnet create --resource-group JenkinsGroup --vnet-name JenkinsNetwork --name JenkinsSubnetSlave --address-prefixes 10.0.10.31/24

az network vnet subnet create --resource-group JenkinsGroup --vnet-name JenkinsNetwork --name JenkinsSubnetPython --address-prefizes 10.0.10.41/24

az network nsg create --resource-group JenkinsGroup --name JenkinsNSG

#az network nsg rule create --resource-group JenkinsGroup --name HTTP --priority 500 --nsg-name JenkinsNSG

az network nsg rule create --resource-group JenkinsGroup --name SSH --destination-port-ranges 22 --nsg-name JenkinsNSG --priority 400

az network public-ip create --resource-group JenkinsGroup --name JenkinsIP --dns-name bazzatron3000 --allocation-method Static

az network nic create --resource-group JenkinsGroup --name JenkinsNICHost --vnet-name JenkinsNetwork --subnet JenkinsSubnetHost --network-security-group JenkinsNSG

az network nic create --resource-group JenkinsGroup --name JenkinsNICSlave --vnet-name JenkinsNetwork --subnet JenkinsSubnetSlave --network-security-group JenkinsNSG

az network nic create --resource-group JenkinsGroup --name JenkinsNICPython --vnet-name JenkinsNetwork --subnet JenkinsSubnetPython --network-security-group JenkinsNSG

az vm create --resource-group JenkinsGroup --name JenkinsHostVM --image UbuntuLTS --nics JenkinsNIC

az vm create --resource-group JenkinsGroup --name JenkinsSlaveVM --image UbuntuLTS --nics JenkinsNIC

az vm create --resource-group JenkinsGroup --name PythonServerVM --image UbuntuLTS --nics JenkinsNIC
