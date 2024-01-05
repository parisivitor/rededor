# Create cluster with kind
kind create cluster --name=rededor

# Restart kubectl
sudo systemctl restart kubelet

# Restart Docker (if using Docker as the container runtime)
sudo systemctl restart docker

# Kubenetes loogs
kubectl logs -n kube-system <api-server-pod-name>

# run folder
kubectl apply -f k8s/

# run files
kubectl apply -f service.yml
kubectl apply -f deployment.yml


# check run
kubectl get deploy
#rep:
NAME            READY   UP-TO-DATE   AVAILABLE   AGE
rededorserver   1/1     1            1           88s


kubectl get svc
#resp:
NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
kubernetes              ClusterIP   10.96.0.1       <none>        443/TCP    11m
rededorserver-service   ClusterIP   10.96.148.132   <none>        8000/TCP   79s

______________________________
# ArgoCD
https://argo-cd.readthedocs.io/en/stable/getting_started/?_gl=1*11minm7*_ga*MTE3NjQ5NzUyOC4xNzA0NDY1MjUy*_ga_5Z1VTPDL73*MTcwNDQ2NTI1Mi4xLjAuMTcwNDQ2NTI3My4wLjAuMA..

# Intall argoCD: Cria namespace e roda o manifesto do argo
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# intall argoCD CLI
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64


# get all
kubectl get all
kubectl get all -n argocd

# Pode usar como load balancer( cria um service e coloca como load balancer)
# Pode usar como Port Forwarding

# Login no argoCD
argocd admin initial-password -n argocd
first login password: PeBTqy08QTIY-SCd

# subir o argo como port forward
kubectl port-forward svc/argocd-server -n argocd 8080:443
