# Set variables
mrg="aksdemo"
cluster="akscluster"

# Create resource group
az group create -l australiaeast -n mrg

# Create cluster
az aks create -g mrg \
-n cluster \
--node-count 1 \
--generate-ssh-keys \
--enable-addons monitoring

# Create credentials
az aks get-credentials \
-g mrg \
-n cluster

# Get cluster nodes
kubectl get nodes

# Apply application
kubectl apply -f azure-vote.yaml

# Wait for deployment
kubectl get service azure-vote-front /
--watch
