# TP1 : Azure first steps

## I. Prérequis
### A. Choix de l'algorithme de chiffrement
**Pourquoi ne pas utiliser RSA :**
https://www.veritas.com/fr/ca/information-center/rsa-encryption

### B. Génération de votre paire de clés
```
PS C:\Users\TERRA> ssh-keygen.exe -t ed25519
Generating public/private ed25519 key pair.
Enter file in which to save the key (C:\Users\TERRA/.ssh/id_ed25519): cloud_tp1
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in cloud_tp1
Your public key has been saved in cloud_tp1.pub
The key fingerprint is:
SHA256:h+Ycxz+SHP0rqUIT9tDmWzo0BbXaDjH5m7r7JFRE7zE alexandre@PC-ALEX-TERRA
The key's randomart image is:
+--[ED25519 256]--+
|           o+    |
|          .o o   |
|         .+.o E  |
|        +ooO.. o |
|       .S*O.+ .  |
|       +o*=*.+   |
|       .oo==B..  |
|        . +=o. . |
|         .=*...  |
+----[SHA256]-----+
```
### C. Agent SSH

## II. Spawn des VMs
### 1. Depuis la WebUI
### 2. *az* : a programmatic approach
### 3. Terraforming planets infrastructures

