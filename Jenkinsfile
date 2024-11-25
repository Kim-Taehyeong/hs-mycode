pipeline {
	agent {
		kubernetes {
			yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    command: ['sleep']
    args: ['infinity']
  volumeMounts:
  - name: registry-credentials
    mountPath: /kaniko/.docker
  volumes:
  - name: registry-credentials
    secret:
      secretName: regcred
      items: 
      - key: .dockerconfigjson
        path: config.json
'''
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
