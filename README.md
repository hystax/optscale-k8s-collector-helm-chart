#  (obsolete) OptScale Kubernetes Cost Metrics Collector

> This approach of k8s cost metrict collection for OptScale is obsolete due to multiple architectural flaws. Reworked implementation can be found here - https://github.com/hystax/helm-charts/tree/main/charts/kube-cost-metrics-collector

Ready-to-deploy setup of components necessary for kubernetes cost management and FinOps in Hystax OptScale.

Components
- Prometheus
- Prometheus node-exporter module
- kube-state-metrics
- nginx (optional, for setting up authentication)
## Prerequisites

- Kubernetes 1.16+

## Description
Helm chart for the OptScale Kubernetes Collector project, which is created to collect Kubernetes resources information and share it with OptScale FinOps project - https://hystax.com/optscale/.

## Kubernetes YAML (LoadBalancer based configuration)
These resources can be deployed with the following single command:

`kubectl apply -f https://raw.githubusercontent.com/hystax/optscale-k8s-collector-helm-chart/master/optscale-agent.yaml`

## Helm install configurations

### Helm Prerequisites

- Helm 3+

### NodePort example (recommended for virtual machines based clusters):
`helm install --namespace optscale --create-namespace 
--set nginx.service.type=NodePort 
--set nginx.service.enabledExternalPort=true 
--set nginx.service.externalPort=31222 
--set nginx.passwd=$(htpasswd -nbm "optscale" "<SOME_PASSWORD>") 
monitoring .`

### LoadBalancer example (recommended for cloud based clusters):
`helm install --namespace optscale --create-namespace 
--set nginx.service.internalPort=4433 
--set nginx.passwd=$(htpasswd -nbm "optscale" "<SOME_PASSWORD>") 
monitoring .`

## Helm chart parameters
The following table lists the commonly used configurable parameters of the Helm chart and their default values.

Parameter | Description | Default
--------- | ------------------------------------------------ | -------
nginx.enabled | if `false`, use another way to expose the Prometheus port | `true`
nginx.service.type | `NodePort` or `LoadBalancer` | `LoadBalancer`
nginx.service.internalPort | Internal NGINX Server Port Number | `4433`
nginx.passwd | MD5 hash of the username and password to login to the Agent metrics | `optscale:<SOME_MD5_PASSWORD>`
nginx.service.enabledExternalPort | use `true` for `NodePort` and `false` - `LoadBalancer`| `false`
nginx.service.externalPort | Agent external Node port number | `31222`
