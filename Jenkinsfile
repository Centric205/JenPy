def img

pipeline {
    environment {
        registry = "theoexpleo/jenkins-cicd"
        registryCredential = 'DOCKERHUB'
        githubCredential = 'GITHUB'
        dockerImage = ''
    }
    agent any
    stages {
        stage ('checkout'){
            steps {
                git branch: 'main',
                credentialsId: githubCredential,
                url: 'https://github.com/Centric205/JenPy.git'
            }
        } 
        
        stage ('Build Image'){
            steps {
                script {
                    img = registry + ":${env.BUILD_ID}"
                    println ("${img}")
                    dockerImage = docker.build("${img}")
                }
            }
        }

        stage ('Push To DockerHub'){
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage ('Deploy') {
            steps {
                sh label: '', script: "docker run -d --name ${JOB_NAME} -p 5000:5000 ${img}"
            }
        }
        stage ('Test'){
            steps{
                sh "source /venv/bin/activate"
                sh "pytest testRoutes.py"
            }
        }

        stage ('Clean Up'){
            steps{
                sh returnStatus: true, script: 'docker stop $(docker ps -a | grep ${JOB_NAME} | awk \'{print $1}\')'
                // This will delete all images
                sh returnStatus: true, script: 'docker rmi $(docker images | grep ${registry} | awk \'{print $3}\') --force' 
                sh returnStatus: true, script: 'docker rm ${JOB_NAME}'
            }
        }

    }

}