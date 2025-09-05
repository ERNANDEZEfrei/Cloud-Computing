```
az group create --location francecentral --name TP1.2
az vm create -g TP1.2 -n VMTP1.2 --image Ubuntu2204 --admin-username azureuser --ssh-key-values ~/.ssh/cloud_tp1.pub
```