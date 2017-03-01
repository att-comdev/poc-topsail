#Install Self Hosted Kubernetes Dependencies

#Commenting out ETCD for now, working on self-hosted ETCD

# Download_ETCD_Tarball:
#   cmd.run:
#     - name: curl -L https://github.com/coreos/etcd/releases/download/{{ pillar['etcd_version'] }}/etcd-{{ pillar['etcd_version'] }}-linux-amd64.tar.gz -o /tmp/etcd-{{ pillar['etcd_version'] }}-linux-amd64.tar.gz
#     - creates: /tmp/etcd-{{ pillar['etcd_version'] }}-linux-amd64.tar.gz
#
# Extract_ETCD_Tarball:
#   archive.extracted:
#     - name: /tmp/etcd-{{ pillar['etcd_version'] }}-linux-amd64
#     - archive_format: tar
#     - options: --strip-components=1
#     - source: /tmp/etcd-{{ pillar['etcd_version'] }}-linux-amd64.tar.gz
#     - if_missing: /tmp/etcd-{{ pillar['etcd_version'] }}-linux-amd64
#     - enforce_toplevel: false

Download_BootKube:
  cmd.run:
    - name: curl -L https://github.com/kubernetes-incubator/bootkube/releases/download/{{ pillar['bootkube_version'] }}/bootkube.tar.gz -o /tmp/bootkube-{{ pillar['bootkube_version'] }}.tar.gz
    - creates: /tmp/bootkube-{{ pillar['bootkube_version'] }}.tar.gz

Extract_BootKube_Tarball:
  archive.extracted:
    - name: /tmp/bootkube-{{ pillar['bootkube_version'] }}
    - archive_format: tar
    - source: /tmp/bootkube-{{ pillar['bootkube_version'] }}.tar.gz
    - if_missing: /tmp/bootkube-{{ pillar['bootkube_version'] }}
    - enforce_toplevel: false

# Install_Etcd:
#   file.copy:
#     - name: /usr/bin/etcd
#     - source: /tmp/etcd-{{ pillar['etcd_version'] }}-linux-amd64/etcd
#
# Install_EtcdCTL:
#   file.copy:
#     - name: /usr/bin/etcdctl
#     - source: /tmp/etcd-{{ pillar['etcd_version'] }}-linux-amd64/etcdctl

Install_BootKube:
  file.copy:
    - name: /usr/bin/bootkube
    - source: /tmp/bootkube-{{ pillar['bootkube_version'] }}/bin/linux/bootkube
