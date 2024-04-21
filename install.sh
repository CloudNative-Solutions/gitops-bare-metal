#!/bin/bash

ARGOCD_NS=argocd
ARGO_CHART=argo-cd

create_kind_cluster() {
    kind create cluster
    kubectl cluster-info --context kind-kind
}

install_argocd() {
    # Install ArgoCD with sync-waves enabled
    helm repo add argo-cd https://argoproj.github.io/argo-helm
    helm repo update
    helm upgrade --install ${ARGO_CHART} --create-namespace --namespace ${ARGOCD_NS} -f bootstrap/argo-cd.yaml argo-cd/argo-cd
    echo "Waiting for ArgoCD deployment to be ready"
    until kubectl wait deployment -n ${ARGOCD_NS} ${ARGO_CHART}-argocd-server --for condition=Available=True --timeout=90s; do sleep 1; done
    until kubectl wait deployment -n ${ARGOCD_NS} ${ARGO_CHART}-argocd-applicationset-controller --for condition=Available=True --timeout=90s; do sleep 1; done
    until kubectl wait deployment -n ${ARGOCD_NS} ${ARGO_CHART}-argocd-repo-server --for condition=Available=True --timeout=90s; do sleep 1; done
}

apply_secrets() {
    kubectl apply -f ./secrets
}

create_argo_apps() {
    kubectl apply -f ./bootstrap/argo-apps.yaml
    until kubectl wait application -n ${ARGOCD_NS} argo-apps --for jsonpath='{.status.sync.status}'=Synced; do sleep 1; done
}

argo_ui() {
    ARGO_PASS=$(kubectl get secret argocd-initial-admin-secret -n ${ARGOCD_NS} -o jsonpath='{.data.password}' | base64 -d )
    echo ArgoCD credentials:
    echo   User: admin
    echo   Password: ${ARGO_PASS}
    echo   Url: https://localhost:8080
    echo Starting port forward:
    kubectl port-forward svc/${ARGO_CHART}-argocd-server -n ${ARGOCD_NS} 8080:443
}

create_kind_cluster
install_argocd
apply_secrets
create_argo_apps
argo_ui


