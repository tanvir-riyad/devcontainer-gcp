image_name := python_image
tag:= v1.1
container_name:= web
build:
	@ docker build -t ${image_name}:${tag}

run:
	@ docker run --name ${container_name} -d -p 8080:80 ${image_name}:${tag}

b:
	@ chmod +x hello.sh
	@ ./hello.sh