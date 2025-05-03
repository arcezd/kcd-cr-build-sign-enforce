## Steps for the demo

### Install the dependencies

```bash
# install cosign
brew install cosign

# install helm
brew install helm
```

### Install Kyverno
```bash
# add the kyverno helm repo
# and update the repo
helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update

# install kyverno
helm upgrade --install kyverno kyverno/kyverno \
  -n kyverno --create-namespace \
  -f kyverno/values.yaml

# verify the installation
kubectl get deploy -n kyverno && \
  kubectl get pods -n kyverno

# install harbor
helm repo add harbor https://helm.goharbor.io
helm repo update

# harbor
helm upgrade --install harbor harbor/harbor \
  --namespace harbor --create-namespace \
  -f harbor/values.yaml
```