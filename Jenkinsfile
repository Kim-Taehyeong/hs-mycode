pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
    - name: kaniko
      image: gcr.io/kaniko-project/executor:debug
      volumeMounts:
        - name: docker-secret
          mountPath: /kaniko/.docker/
  volumes:
    - name: docker-secret
      secret:
        secretName: docker-secret
            """
        }
    }
	stages {
		stage('git clone') {
			steps() {
				git 'https://github.com/Kim-Taehyeong/hs-mycode.git'
			}
		}
		stage('Push Image to Docker Hub') {
			steps() {
				container('kaniko') {
					sh "executor --dockerfile=Dockerfile \
					--context=dir://${env.WORKSPACE} \
					--destination=taehyeok02/mycode-server:${env.BUILD_ID} \
					--destination=taehyeok02/mycode-server:latest"
				}
			}
		}
	}
}
