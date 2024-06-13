# cloudnative-pg

### Upgrade


Scale deployments

```
kubectl scale deployment -n default authelia --replicas 0
kubectl scale deployment -n monitoring grafana --replicas 0
kubectl scale deployment -n home home-assistant --replicas 0
kubectl scale deployment -n default lldap --replicas 0
kubectl scale deployment -n default prowlarr --replicas 0
kubectl scale deployment -n default radarr --replicas 0
kubectl scale deployment -n default sonarr --replicas 0
```

Add new pg v16 cluster with restore from v15

```
  externalClusters:
    - name: cluster-pg15
      connectionParameters:
        host: postgres-ro.database.svc.cluster.local
        user: postgres
        dbname: postgres
        sslmode: require
      password:
        name: cloudnative-pg-secret
        key: password

  bootstrap:
    initdb:
      import:
        type: monolith
        databases:
          - "*"
        roles:
          - "*"
        source:
          externalCluster: cluster-pg15
```

```
apiVersion: postgresql.cnpg.io/v1
kind: Backup
metadata:
  name: postgres16
  namespace: database
spec:
  cluster:
    name: postgres16
```


Remove cluster "postgres"

Add v16 cluster named "postgres" and restore from v16 backup


Scale deployments back up
```
kubectl scale deployment -n default authelia --replicas 2
kubectl scale deployment -n default lldap --replicas 2
kubectl scale deployment -n default prowlarr --replicas 1
kubectl scale deployment -n default radarr --replicas 1
kubectl scale deployment -n default sonarr --replicas 1
kubectl scale deployment -n home home-assistant --replicas 1
kubectl scale deployment -n monitoring grafana --replicas 1
```