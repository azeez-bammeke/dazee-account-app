def customImage

pipeline {
	agent any
	    tools {
	        maven 'maven'
	            jdk 'JDK17'
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
                                            customImage = docker.build("abammeke/currency-exchange:${BUILD_NUMBER}")
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
            }
            post {
                    cleanup {
                        sh "docker rmi abammeke/currency-exchange:${BUILD_NUMBER}"
                        sh "docker rmi registry.hub.docker.com/abammeke/currency-exchange"
                    }
                }
}
