$rgName = "batch"
$stgActName = "sanj2501batchsa"
$location = "australiaeast"
$batchActName = "sanj2501batchact"
$poolName = "myPool"

az group create -l $location -n $rgName

az storage account create -g $rgName -n $stgActName -l $location --sku Standard_LRS

az batch account create -n $batchActName --storage-account $stgActName -g $rgName -l $location

az batch account login -n $batchActName -g $rgName --shared-key-auth

# The following Powershell and CLI creates a new pool, creates a job and submit
# four tasks to the jpb
# (and one statement to show details of the new pool)
az batch pool create --id mypool `
--vm-size Standard_A1_v2 `
--target-dedicated-nodes 2 `
--image Canonical:UbuntuServer:18.04-LTS `
--node-agent-sku-id "batch.node.ubuntu 18.04"

az batch pool show `
--pool-id $poolName `
--query "allocationState"

az batch job create `
--id myjob `
--pool-id $poolName

for($i=0; $i -lt 4; $i++){
    az batch task create `
    --task-id mytask$i `
    --job-id myjob `
    --command-line "/bin/bash -c 'printenv | grep AZ_BATCH; sleep 90s'" 
}

# Details of the jobs created
az batch task show `
--job-id myjob `
--task-id mytask1

az batch task file list `
--job-id myjob `
--task-id mytask1 `
--output table

az batch task file download `
--job-id myjob `
--task-id mytask1 `
--file-path stdout.txt `
--destination ./stdout.txt

az batch pool delete -n $poolName
az group delete -n $rgName