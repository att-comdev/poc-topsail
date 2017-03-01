#SaltState for Deploying Other Kube Masters

#include:
#  - deploy_bootkube
#    require:
#      - sls: kube_bootstrap 
