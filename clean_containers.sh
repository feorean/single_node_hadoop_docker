image=$1

if [ $image"a" = "a" ]
then
  image="hadoop"
fi

echo "Deleting" $image

docker ps -a| grep $image | awk '{system("docker stop " $1)}'
docker ps -a| grep $image | awk '{system("docker rm " $1)}'
docker images| grep $image | grep -v seq| awk '{system("docker rmi " $1":"$2)}'
