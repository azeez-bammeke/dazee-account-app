def customImage

pipeline {
	agent any
	environment {
                    SPRING_PROFILES_ACTIVE = 'dev'
                }
	    tools {
	        maven 'maven'
	            jdk 'JDK21'
	    }
    stages {
            stage('Build Maven') {
                steps {
                       sh 'pwd'
                       sh 'mvn clean install package'
                }
            }
            stage('Running Test') {
                        steps {
                            sh 'mvn test'
                        }
            }
            stage('Copy Artifact') {
                steps {
                       sh 'pwd'
                       sh 'cp -r target/*.jar docker'
                }
            }

            stage('Build docker image') {
                            steps {
                                    script {
                                            customImage = docker.build("abammeke/dazee-account-app:${BUILD_NUMBER}")
                                    }
                            }
            }

            stage('Push to Docker Hub') {
                        steps {
                            script {
                                docker.withRegistry('https://registry.hub.docker.com', 'dockerHubCredentials') {
                                    customImage.push('latest')
                                }
                            }
                        }
            }

            stage('Deploy to K8') {
                                    steps {
                                        script {
                                            def imageName = "abammeke/dazee-account-app:${BUILD_NUMBER}"
                                            sh "kubectl apply -f k8s/deployment.yaml"
                                            sh "kubectl apply -f k8s/service.yaml"
                                        }
                                    }
                             }
             }

            post {
                    cleanup {
                        sh "docker rmi abammeke/dazee-account-app:${BUILD_NUMBER}"
                        sh "docker rmi registry.hub.docker.com/abammeke/dazee-account-app"
                    }
                }
}
