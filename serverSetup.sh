az configure --defaults location=uksouth

echo -1-----------------------------------------------------------------------

az configure --defaults group=JenkinsGroup

echo -2-----------------------------------------------------------------------

az group create --resource-group JenkinsGroup --location uksouth

echo -3-----------------------------------------------------------------------

az network vnet create --resource-group JenkinsGroup --name JenkinsNetwork --address-prefixes 10.0.0.0/16 --subnet-name JenkinsSubnet --subnet-prefix 10.0.0.0/24

echo -4-----------------------------------------------------------------------

az network vnet subnet create --resource-group JenkinsGroup --vnet-name JenkinsNetwork --name JenkinsSubnet --address-prefixes 10.0.0.0/24

echo -5-----------------------------------------------------------------------

az network nsg create --resource-group JenkinsGroup --name JenkinsNSG

echo -6-----------------------------------------------------------------------

#az network nsg rule create --resource-group JenkinsGroup --name HTTP --priority 500 --nsg-name JenkinsNSG

az network nsg rule create --resource-group JenkinsGroup --name SSH --destination-port-ranges 22 --nsg-name JenkinsNSG --priority 400

echo -7-----------------------------------------------------------------------

az network public-ip create --resource-group JenkinsGroup --name JenkinsIPHost --dns-name bazzatron3000 --allocation-method Static

echo -8-----------------------------------------------------------------------

az network public-ip create --resource-group JenkinsGroup --name JenkinsIPSlave --dns-name bazzatron3000 --allocation-method Static

echo -9-----------------------------------------------------------------------

#az network public-ip create --resource-group JenkinsGroup --name JenkinsIPPython --dns-name bazzatron3000 --allocation-method Static

echo -10----------------------------------------------------------------------

az network nic create --resource-group JenkinsGroup --name JenkinsNICHost --vnet-name JenkinsNetwork --subnet JenkinsSubnet --network-security-group JenkinsNSG --public-ip-address JenkinsIPHost

echo -11----------------------------------------------------------------------

az network nic create --resource-group JenkinsGroup --name JenkinsNICSlave --vnet-name JenkinsNetwork --subnet JenkinsSubnet --network-security-group JenkinsNSG --public-ip-address JenkinsIPSlave

echo -12----------------------------------------------------------------------

#az network nic create --resource-group JenkinsGroup --name JenkinsNICPython --vnet-name JenkinsNetwork --subnet JenkinsSubnet --network-security-group JenkinsNSG --public-ip-address JenkinsIPPython

echo -13----------------------------------------------------------------------

az vm create --resource-group JenkinsGroup --name JenkinsHostVM --image UbuntuLTS --nics JenkinsNICHost --size Standard_B1ls

echo -14----------------------------------------------------------------------

az vm create --resource-group JenkinsGroup --name JenkinsSlaveVM --image UbuntuLTS --nics JenkinsNICSlave --size Standard_B1ls

echo -15----------------------------------------------------------------------

#az vm create --resource-group JenkinsGroup --name PythonServerVM --image UbuntuLTS --nics JenkinsNICPython --size Standard_B1ls
