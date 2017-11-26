#Single node HADOOP on docker container


##This Dockerfile builds Hadoop Docker image using Ubuntu image and OpenJDK jvm on single node.


NOTE: I have not included hadoop instalation file as it big (too big for image rebuilds). But you can download it from [Apache web site](http://hadoop.apache.org/releases.html).
Dowload and save hadoop to the same folder (e.g. hadoop-2.8.2.tar.gz). 
I am using 2.8.2 version but feel free to download the other version and don't forget to update Dockerfile respectevely.


For connectivity and web interface access I am using here MACVLAN virtualisation so it allows me to set my local network IP to the container and allows access to Hadoop web interfaces easily. 

You can build image  with following command:

```
sudo docker build -t hadoop:0.3 .
```

create MACVLAN network/interface

```
sudo docker network create -d macvlan     --subnet=192.168.1.0/24     --gateway=192.168.1.1      -o parent=eth0 pub_net
```

and run it with specific IP
```
docker run -it --net=pub_net --ip=192.168.1.5 hadoop:0.3
```

Then you can access NameNode info on

```
http://192.168.1.5:50070
```

And Yarn (Resource Manager) on

```
http://192.168.1.5:8088/cluster/cluster
```


Please note that above URLs will only work if you try to access it from different host. i.e. not from host machine where docker runs!
See notes on  MACVLAN documentation on [docker docs](https://docs.docker.com/engine/userguide/networking/get-started-macvlan/#macvlan-bridge-mode-example-usage)
But you can fix it using suggested solution on that page. But there is a small issue on that example. I have already submitted [pull request to fix it on official documentation](https://github.com/docker/docker.github.io/pull/5394).

Enjoy!
