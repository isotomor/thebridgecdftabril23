# Operaciones básicas con Namespace

Obtener los distintos namespace
````bash
kubectl get namespace
````

Crear un namespace
````bash
kubectl create namespace miespacio
````

crearlo a partir de un yaml, puede encontrarlo [aquí](namespace.yml)

```bash
kubectl apply -f namespace.yml # Hay que ponerle el nombre que queramos. 
```

Creación de un pod en un namespace.  
````bash
kubectl run nginx --image=nginx --namespace=miespacio
kubectl get pods --namespace=miespacio
````

Para configurar un namespace por defecto.
````bash
kubectl config set-context --current --namespace=""
````

Validación de la configuración
````bash
kubectl config view --minify | grep namespace:
````

Borrar un espacio
````bash
kubectl delete namespace miespacio
````