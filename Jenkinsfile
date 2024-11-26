pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
metadata:
  name: kaniko
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    imagePullPolicy: Always
    command:
    - /busybox/cat
    tty: true
    volumeMounts:
      - name: jenkins-docker-cfg
        mountPath: /kaniko/.docker
  volumes:
  - name: jenkins-docker-cfg
    projected:
      sources:
      - secret:
          name: docker-secret
          items:
            - key: .dockerconfigjson
              path: config.json
            """
        }
    }
    environment {
	container="docker"
	MY_PASSWORD=credentials('mycode-password')
        IMAGE_PUSH_DESTINATION="taehyeok02/mycode-server:${env.BUILD_ID}"
	IMAGE_PUSH_DESTINATION2="taehyeok02/mycode-server:latest"
    }
	stages {
		stage('git clone') {
			steps() {
				git 'https://github.com/Kim-Taehyeong/hs-mycode.git'
			}
		}
		stage('Push Image to Docker Hub') {
			steps() {
				container(name : 'kaniko', shell: '/busybox/sh') {
					sh 'executor --context `pwd` --destination $IMAGE_PUSH_DESTINATION --destination $IMAGE_PUSH_DESTINATION2 --build-arg PASSWORD=${MY_PASSWORD}'
				}
			}
		}
	}
}
