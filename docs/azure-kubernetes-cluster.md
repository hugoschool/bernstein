# Azure Kubernetes Cluster

This guide is going to use the Azure Kubernetes Cluster as an example.

## Create your Kubernetes Cluster

> This is not an exact cluster configuration. You can add, modify or remove anything you want. This is only an example of what I setup for this project.

### Overview page

![Kubernetes Cluster Creation](./images/kubernetes-cluster-creation.png)

> If you're on Azure for Students, I recommend the "Belgium Central" region.
> It's usually the cheapest and the one that works the best for me.

### Node pools page

Delete the given (should be named `agentpool`) node pool and create a new one with these settings:

![Kubernetes Cluster Node Pool Creation](./images/kubernetes-cluster-node-pool-creation.png)

You're not obligated to follow the exact node pool, this is just an example for a cheap node pool that will do fine for this project.

### Integrations page

Select the container registry you created earlier.

---

You can now create your cluster.

## Connecting to the cluster

> K8s credentials are not available from the portal UI.
> ([Source](https://stackoverflow.com/questions/62027328/get-kubectl-credentials-in-azure))

Here's how I got the credentials for the cluster:

```sh
nix shell nixpkgs#azure-cli # Not needed if you don't use Nix, install it via your package manager
az login                    # Not needed if you are already logged in
az aks get-credentials --name "cluster-name" --resource-group "resource-group"
```

## Adding VPA (Vertical Pod Autoscaling)

The `deploy.sh` script should automatically add the Vertical Pod Autoscaling.

If it doesn't, or you don't use the `deploy.sh` script, run the following commands:
```sh
git clone --branch vertical-pod-autoscaler-1.8.0 --depth 1 https://github.com/kubernetes/autoscaler.git

cd autoscaler/vertical-pod-autoscaler
./hack/vpa-up.sh
```
