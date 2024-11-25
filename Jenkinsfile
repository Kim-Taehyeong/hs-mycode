pipeline {
	environment {
		repository = "taehyeok02/mycode-server"
		DOCKERHUB_CREDENTIALS = credentials('docker-hub')
		dockerImage = ''
	}
	agent any

	stages {
		stage('git clone') {
			steps() {
				git 'https://github.com/Kim-Taehyeong/hs-mycode.git'
			}
		}
		stage('Docker Build') {
			steps() {
				dockerImage = docker.build repository + "$BULID_NUMBER"	
				}
		}
		stage('Docker Login') {
			steps() {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}
		stage('Push Image to Docker Hub') {
			steps() {
				sh 'docker push $repository:$BUILD_NUMBER'
			}
		}
		stage('Delete Docker Image') {
			steps() {
				sh 'docker rmi $repository:%BUILD_NUMBER'
			}
		}
	}
}
