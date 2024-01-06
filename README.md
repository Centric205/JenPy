I will edit it later.

   docker container run -d --name jendock_con -p 9090:8080 -p 50000:50000 --restart=on-failure -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock  docker_in_jenkins