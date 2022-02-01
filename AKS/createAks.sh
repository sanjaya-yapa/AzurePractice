$mrg="aksdemo"
$cluster="akscluster"

az group create -l australiaeast -n $mrg

az aks create -g $mrg /
-n $cluster /
--node-count 1 /
--generate-ssh-keys /
--enable-addons monitoring

az aks get-credentials /
-g $mrg /
-n $cluster

kubectl get nodes

kubectl apply -f azure-vote.yaml

kubectl get service azure-vote-front /
--watch
