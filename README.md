# Build, Sign, Enforce: Securing Kubernetes from Source to Pod with Harbor & Kyverno

## Prerequisites
- [AWS Account](https://aws.amazon.com/free/)
- [K8s cluster](https://kubernetes.io/docs/setup/) (v1.24+)
- [kubectl](https://kubernetes.io/docs/tasks/tools/) (v1.24+)
- [Helm](https://helm.sh/docs/intro/install/) (v3.0+)

## Install Kyverno
```bash
helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update
helm install kyverno kyverno/kyverno -n kyverno --create-namespace
```

## Install Harbor
```bash
```

### Additional resources
- [Harbor webpage](https://goharbor.io/)
- [Harbor High Availability Guide](https://github.com/goharbor/harbor-helm/blob/main/docs/High%20Availability.md)
- [Kyverno webpage](https://kyverno.io/)
- [Install Kyverno using Helm](https://kyverno.io/docs/installation/methods/#install-kyverno-using-helm)
