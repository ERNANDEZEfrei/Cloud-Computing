# TP1 : Azure first steps

## I. Prérequis
### A. Choix de l'algorithme de chiffrement
**Pourquoi ne pas utiliser RSA :**
https://www.veritas.com/fr/ca/information-center/rsa-encryption


**Quel algo utiliser :**
https://cyber.gouv.fr/sites/default/files/2014/01/NT_OpenSSH.pdf

### B. Génération de votre paire de clés
```
PS C:\Users\TERRA> ssh-keygen -t ecdsa -b 256
Generating public/private ecdsa key pair.
Enter file in which to save the key (C:\Users\TERRA/.ssh/id_ecdsa): cloud_tp1
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in cloud_tp1
Your public key has been saved in cloud_tp1.pub
The key fingerprint is:
SHA256:E5bydA0dSlAuQrRccVRJ85RmFdV42TiSNFLSAHJv5kE alexandre@PC-ALEX-TERRA
The key's randomart image is:
+---[ECDSA 256]---+
|     .+ **EOO+.*O|
|     o = B **=B.+|
|      = * O .+.o |
|       * B .     |
|        S .      |
|         .       |
|                 |
|                 |
|                 |
+----[SHA256]-----+
```
### C. Agent SSH
Activation de OpenSSH :
```powershell
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
```

Ajout de la clé ssh au client : 
```powershell
Get-Service ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent
Get-Service ssh-agent
ssh-add $env:USERPROFILE\.ssh\cloud_tp1
```

## II. Spawn des VMs

### 1. Depuis la WebUI

```bash
ssh azureuser@4.233.103.219
Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1031-azure x86_64)
``` 

### 2. *az* : a programmatic approach
```powershell
az vm create -g TP1.2 -n VMTP1.2 --image Ubuntu2204 --admin-username azureuser --ssh-key-values C:\Users\TERRA\.ssh\cloud_tp1.pub --size Standard_B1s --location francecentral
```

### 3. Terraforming planets infrastructures

