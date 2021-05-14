## Prerequisites

- Kubernetes 1.16+
- Helm 3+

## Description
Helm chart for the OptScale Kubernetes Collector project, which is created to collect Kubernetes resources information and share it with OptScale FinOps project - https://hystax.com/optscale/.

## Install configurations
### 1. NodePort example (recommended for virtual machines based clusters):
`helm install --namespace optscale --create-namespace 
--set nginx.service.type=NodePort 
--set nginx.service.enabledExternalPort=true 
--set nginx.service.externalPort=31222 
--set nginx.passwd=$(htpasswd -nbm "optscale" "<SOME_PASSWORD>") 
monitoring .`

### 2. LoadBalancer example (recommended for cloud based clusters):
`helm install --namespace optscale --create-namespace 
--set nginx.service.internalPort=4433 
--set nginx.passwd=$(htpasswd -nbm "optscale" "LxY83mXr") 
monitoring .`

### 3. Kubernetes YAML (LoadBalancer based configuration)
While Helm is the recommended install path, these resources can also be deployed with the following single command:

`kubectl apply -f https://github.com/hystax/optscale-k8s-collector-helm-chart/optscale-agent.yaml`

## Helm chart parameters
The following table lists the commonly used configurable parameters of the Helm chart and their default values.

Parameter | Description | Default
--------- | ------------------------------------------------ | -------
nginx.enabled | if `false`, use another way to expose the Prometheus port | `true`
nginx.service.type | `NodePort` or `LoadBalancer` | `LoadBalancer`
nginx.service.internalPort | Internal NGINX Server Port Number | `4433`
nginx.passwd | MD5 hash of the username and password to login to the Agent metrics | `optscale:$apr1$VELgzrP7$YYedDiHsEmoQ/xcUhWkrO0` -> `optscale:LxY83mXr`
nginx.service.enabledExternalPort | use `true` for `NodePort` and `false` - `LoadBalancer`| `false`
nginx.service.externalPort | Agent external Node port number | `31222`
