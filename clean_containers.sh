docker ps -a| grep "hadoop:"| awk '{system("docker rm " $1)}'
docker images| grep "hadoop"| grep -v seq| awk '{system("docker rmi " $1":"$2)}'
