# NFS

  ## Creating Folder /mysql & /html and added this to /etc/exports

    ➜  k8s-wordpress-myql-project git:(master) cd nfs-installation
    ➜  nfs-installation git:(master) chmod +x nfs-installation.sh
    ➜  nfs-installation git:(master) sudo ./nfs-installation.sh 


# k8s-manifest

  ## Creating a persistent volumes for Wordpress & MySQL

    ➜  k8s-wordpress-myql-project git:(master) cd k8s-manifest

    ➜  k8s-manifest git:(master) vim 00-wordpress-mysql-pv.yml 

        replace "server: *******" with NFS IP

    ➜  k8s-manifest git:(master) kubectl create -f 00-wordpress-mysql-pv.yml


  Verify a persistent volumes for Wordpress & MySQL

    ➜  k8s-manifest git:(master) kubectl get pv --show-labels

    NAME                           CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS     CLAIM  STORAGECLASS   REASON    AGE       LABELS
      mysql-persistent-storage       1Gi       RWX            Retain           Available                                 43m       app=wordpress,tier=mysql
      wordpress-persistent-storage   1Gi       RWX            Retain           Available                                 43m       app=wordpress,tier=frontend


  ## Creating a persistent volume Claim MySQL

    ➜  k8s-manifest git:(master) kubectl create -f 01-mysql-pvc.yml    

  ## Creating a persistent volume Claim for Wordpress

    ➜  k8s-manifest git:(master) kubectl create -f 02-wordpress-pvc.yml

   Verfiy a persistent volume Claim for Wordpress &MySQL

    ➜  k8s-manifest git:(master) kubectl get pvc --show-labels

    NAME                           STATUS    VOLUME                         CAPACITY   ACCESS MODES   STORAGECLASS   AGE       LABELS
    mysql-persistent-storage       Bound     mysql-persistent-storage       10Gi       RWX                           42m       app=wordpress
    wordpress-persistent-storage   Bound     wordpress-persistent-storage   10Gi       RWX                           42m       app=wordpress

    ➜  k8s-manifest git:(master) kubectl get pv --show-labels

    NAME                           CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS    CLAIM                                  STORAGECLASS   REASON    AGE       LABELS
    mysql-persistent-storage       10Gi       RWX            Retain           Bound     default/mysql-persistent-storage                                53m       app=wordpress,tier=mysql
    wordpress-persistent-storage   10Gi       RWX            Retain           Bound     default/wordpress-persistent-storage                            53m       app=wordpress,tier=frontend


  ## Creating Secret which used to our MySQL

     ➜  k8s-manifest git:(master) echo -n 'admin' | base64  

     ➜  k8s-manifest git:(master) kubectl create -f  03-secret.yml

  ## verify Secret which used to our MySQL

     ➜  k8s-manifest git:(master) kubectl get secret

        NAME                        TYPE                                  DATA      AGE
        mysql-pass                  Opaque                                1         19s


  ## Deploy MySQL with it's service "ClusterIP"

    ➜  k8s-manifest git:(master) kubectl create -f 04-mysql-deploy.yml

  Verfiy MySQL Service "wordpress-mysql", Port "3306", label "app=wordpress"

    ➜  k8s-manifest git:(master) kubectl get svc --show-labels

    NAME              TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)    AGE       LABELS
    wordpress-mysql   ClusterIP   None         <none>        3306/TCP   1m        app=wordpress

  Verify MySQL Deployment "mysql", desired "1", current "1"

    ➜  k8s-manifest git:(master) kubectl get deployment --show-labels

    NAME        DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       LABELS
    mysql       1         1         1            1           45m       app=wordpress

  Verify MySQL pod with label "app=wordpress,tier=mysql"

    ➜  k8s-manifest git:(master) kubectl get pods --selector=app=wordpress,tier=mysql

    NAME                     READY     STATUS    RESTARTS   AGE
    mysql-6d468bfbf7-g7hhh   1/1       Running   1          20m

  Verify the MySQL store the data on NFS

    ➜  k8s-manifest git:(master) ls -lh /mysql


  ## Deploy Wordpress with it's service "NodePort", image "mohamedayman/wordpress"

      ➜  k8s-manifest git:(master) kubectl create -f 05-wordpress-deploy.yml

  Verfiy Wordpress Service "wordpress", Port "80", NodePort "32323", label "app=wordpress"

      ➜  k8s-manifest git:(master) kubectl get svc --show-labels

      NAME              TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE       LABELS
      wordpress         NodePort    10.43.71.69   <none>        80:32323/TCP   21s       app=wordpress

  Verify Wordpress Deployment "wordpress", desired "2", current "2"

      ➜  k8s-manifest git:(master) kubectl get deployment --show-labels

      NAME        DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       LABELS
      wordpress   2         2         2            2           2m        app=wordpress

  Verify wordpress pod with label "app=wordpress,tier=frontend"

      ➜  k8s-manifest git:(master) kubectl get pods --selector=app=wordpress,tier=frontend

      NAME                         READY     STATUS    RESTARTS   AGE
      wordpress-5f85d888df-8s5tw   1/1       Running   0          11m
      wordpress-5f85d888df-l882q   1/1       Running   0          11m

  Verify the Wordpress store the data on NFS
  
      ➜  k8s-manifest git:(master) ls -lh /html

      
