# What does the deploy script do

### At first it creates the kubernetes secret that is used to pull from the docker registry

```sh
kubectl create secret docker-registry registry-key \
    --docker-server=ffbernstein-dwffekbygbane5d9.azurecr.io \
    --docker-username=$DOCKER_USERNAME \
    --docker-password=$DOCKER_PASSWORD
```
