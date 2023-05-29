# Operaciones básicas con Pods

Para estos ejercicios se pueden usar varios pods, pero vamos a coger como referencia el siguiente: [00-pod.yml](00-pod.yml)

Crearlo a partir de un yaml de kubernetes

````bash
kubectl apply -f 00-pod.yml
````

Ver los pods

````bash
kubectl get pods                   # Lista todos los pods en el namespaces activo
kubectl get pods --all-namespaces  # Lista todos los pods en todos los namespace
kubectl get pods -o wide           # Lista todos los pods en el namespaces activo, con más detalle
````

Ver las etiquetas para todos los pods

````bash
kubectl get pods --show-labels
````

Información sobre un pod cualquiera. 

````bash
kubectl describe pods mipod
````

Obtiene todos los pods en ejecución

````bash
kubectl get pods --selector=app=cassandra -o jsonpath='{.items[*].metadata.labels.version}'
````

Borrar un pod
````bash
kubectl delete pods mipod
````

Lanza los logs en pantalla que lanza. 
````bash
kubectl logs mipod        # Los logs de salida del pod
kubectl logs -f mipod     # Los logs de salidad del pod en streaming. 
````

Equivalente al run y al exec
```bash
kubectl run -i --tty busybox --image=busybox -- sh  # Run pod as interactive shell
kubectl exec busybox -- ls /
```
