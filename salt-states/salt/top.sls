#Top File To Deploy Self-Hosted Kubernetes

base:

  #Boot strap node is a master node with the grain: kube_bootstrap = true. This value needs to be set on a single node using:  grains.set 'kube_bootstrap:true'
  "G@kube_bootstrap:true":
    - kube_bootstrap

  "*master*":
    - kube_deploy_master

  "*worker*":
    - kube_deploy_worker
