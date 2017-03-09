# self-hosted kubernetes cluster with bootkube and ansible
This is an ansible installer which brings up full kubernetes cluster with the help of bootkube. 
## how to use

Edit `hosts` and fill in the desired instances. Run the following to bring up all at once:

```
ansible-playbook -i hosts site.yml
```

If you want to target specific group of instances, read on

### bootstrap master

```
ansible-playbook -i hosts site.yml -l bootstrap
```

### join instances to control-plane

```
ansible-playbook -i hosts site.yml -l master
```

### join worker nodes
```
ansible-playbook -i hosts site.yml -l workers
```

### connect with kubectl
the bootstrap playbook will copy a kubeconfig to your ansible folder: `roles/kubelet/templates/kubeconfig`. You can use it to connect to the cluster:
```
kubectl --kubeconfig=roles/kubelet/templates/kubeconfig cluster-info
```

### scale etcd
kubectl apply doesn't work for TPR at the moment. See https://github.com/kubernetes/kubernetes/issues/29542. As a workaround, we use cURL to resize the cluster.

```
kubectl --kubeconfig=roles/kubelet/templates/kubeconfig --namespace=kube-system get cluster.etcd kube-etcd -o json > etcd.json && \
vim etcd.json && \
curl -H 'Content-Type: application/json' -X PUT --data @etcd.json http://127.0.0.1:8080/apis/etcd.coreos.com/v1beta1/namespaces/kube-system/clusters/kube-etcd
```

## cleanup
```
sudo systemctl stop kubelet
sudo systemctl stop bootkube
sudo rm -rf /tmp/bootkube
sudo rm -rf /usr/bin/kubelet
sudo rm -rf /etc/kubernetes 
sudo rm -rf /etc/systemd/system/{bootkube,kubelet}.service
sudo su -
docker rm -f $(docker ps -a -q)
exit
```