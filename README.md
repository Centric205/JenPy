# A Python CI/CD project using Jenkins

  The purpose of this project was to understand the workflow and how **Continuous Integration** and **Continuous Delivery/Deployement** work. The objectives were:
    
    1. Set up Jenkins
    2. Build a simple web application using Flask
    3. Containerize the application using Docker
    4. Set-up a Jenkins pipeline with the following stages:
        - Checkout
        - Build
        - Push image to Registry
        - Test
        - Clean-up


The following highlights my experiences while performing these tasks.

## 1. Set up Jenkins

   In my quest to setup Jenkins on my host machine, there issues with the dpkg files, and due to time constraints, had to find an alternative.

   The alternative was using a Jenkins docker container, and it was set up as follows:

    1. Build an Image using Dockerfile

       $ docker build -t jenkins_img .

    2. Create and run a container using the built image

       $ docker run -d --name jenkins_container -p 9090:8080 -p 50000:50000 --restart=on-failure -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins_img

    3. Open Jenkins in browser and login/register


Even after including the appropriate instructions inside the dockerfile, docker commands could not be run inside the container. Typing the following commands helped:

    $ sudo chmod 666 /var/run/docker.sock

    $ sudo chown root:docker /var/run/docker.sock


## 2. Build a simple web application using Flask

The following files were used to build flask application:

 > **requirements.txt**
    includes all the dependencies required

 > **app.py**
    includes source code to launch app      

## 3. Containerize the application using Docker

Containerizing my application consisted of the following sequence of steps:

    1. Include the required instructions in the Dockerfile

**NOTE:** The the image building and container running will be handled in the Jenkins pipeline. 

## 4. Set-up a Jenkins pipeline. 

Inside the Jenkinsfile, instructions about the different stages and steps required for the application were included. These instructions help build the pipeline the way I desired, and it is divided into the follwing stages:

     1. Checkout

        Logs into github and access the code repo

     2. Build

        Builds a docker image from the dockerfile located in the code repo

     3. Push Image

        The built image is then pushed to the docker image registry

     4. Deploy
   
        Creates and runs the docker container. The application can be accessed the browser using a url.

     5. Test

        In this stage, pytest was supposed to be used to check whether the application is running by testing the routes, but because there was no python instance installed in the container, I decided to remove the stage.

        **NOTE** Return to fix this.

     6. Clean Up

        Stops the container and removes the build image to restore resources
   

## Conclusion

I learnt that it was possible to run a container inside a container, learnt to set up Jenkins and create a pipeline

