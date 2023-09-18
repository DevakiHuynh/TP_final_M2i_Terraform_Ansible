# TP_final_M2i_Terraform_Ansible
Déploiement d'un cluster kubernetes avec Terraform et Ansible sur AWS (sans utiliser EKS)

terraform fmt sert à vérifier si les .tf sont bien identés
terraform validate sert à appliquer les modifications repérées par terraform fmt

Questions:
Problem key_pair:
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html#how-to-generate-your-own-key-and-import-it-to-aws
https://docs.oracle.com/en/cloud/paas/integration-cloud/ftp-adapter/generate-keys-pem-format.html#GUID-EFC78B40-AE89-4DAE-BCBA-740DEA39F7CB
ssh -i "k8s_key.pem" ec2-user@15.188.76.246