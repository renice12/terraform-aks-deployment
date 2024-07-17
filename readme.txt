#read me
#pour deployer tout ca sur aks d abord
az login
az aks get-credentials -g rgcergiaks -n cergiaks
#ensuite faire le deployment en 
touch deployment.yml 
code
ou nano deployment.yml
puis
kubectl apply -f deployment.yml
copier le script de deployment sur tout ensuite entendre la creation du pods
kubectl get pods
kubectl get service
kubectl get deployment
kubectl describe service service
pour aller sur le powershell de l app on fait 
kubectl exec -it faq-7fdcdb5bd-dk6sz -- cmd.exe
netstat -ano
kubectl logs <POD_NAME>
ensuite ller sur un navigateur et taper 
http://13.91.56.178/pages/connexion
Pour automatiser vos déploiements AKS avec Terraform, vous pouvez intégrer une pipeline CI/CD. Cela garantira que votre infrastructure et vos applications sont déployées automatiquement à chaque changement. Voici un aperçu de la mise en place :