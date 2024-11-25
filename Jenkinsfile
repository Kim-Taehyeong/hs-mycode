pipeline {
	agent any

	stages {
		stage('git clone') {
			steps() {
				git 'https://github.com/Kim-Taehyeong/hs-mycode.git'
			}
		}
		stage('Docker Build') {
			steps() {
				echo 'Docker Build...'
				}
		}
		stage('Push Image to Docker Hub') {
			steps() {
				echo 'Push Image to Docker Hub'
			}
		}
		stage('Deploy to Kubernetes') {
			steps() {
				echo 'Deploy to Kubernetes'
			}
		}
	}
}
