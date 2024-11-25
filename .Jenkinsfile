node {
	stages('git clone') {
		steps() {
			git 'https://github.com/Kim-Taehyeong/hs-mycode.git'
		}
	}
	stages('Docker Build') {
		steps() {
			echo 'Docker Build...'
		}
	}
	stages('Push Image to Docker Hub') {
		steps() {
			echo 'Push Image to Docker Hub'
		}
	}
	stages('Deploy to Kubernetes') {
		steps() {
			echo 'Deploy to Kubernetes'
		}
	}
}
