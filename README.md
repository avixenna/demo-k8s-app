
# setup runner sekali saja
```
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64.tar.gz -L https://github.com/actions/runner/releases/latest/download/actions-runner-linux-x64.tar.gz
tar xzf actions-runner-linux-x64.tar.gz

./config.sh --url https://github.com/USERNAME/REPO --token TOKEN_DARI_GITHUB
./run.sh
```


# Langkah setup docker registry di luar cluster
```bash
docker run -d -p 5000:5000 --name registry registry:2
```

# edit /etc/rancher/rke2/registries.yaml di server master(node1) dan worker (node2)
```bash
mirrors:
  docker.io:
    endpoint:
      - "https://registry-1.docker.io"
  registry.k8s.io:
    endpoint:
      - "https://registry.k8s.io"
  "192.168.59.1:5000":
    endpoint:
      - "http://192.168.59.1:5000"

configs:
  "192.168.59.1:5000":
    tls:
      insecure_skip_verify: true

```

# restart service
```bash
# node 1
systemctl restart rke2-server

# node 2
systemctl restart rke2-agent
```
# test get image dari docker image local
# aktifkan ctr
```bash
ln -s /var/lib/rancher/rke2/data/*/bin/ctr /usr/local/bin/ctr
ln -s /var/lib/rancher/rke2/data/*/bin/crictl /usr/local/bin/crictl
sudo ctr --address /run/k3s/containerd/containerd.sock images ls
```