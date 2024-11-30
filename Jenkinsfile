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
					sh 'executor --context `pwd` --destination $IMAGE_PUSH_DESTINATION --destination $IMAGE_PUSH_DESTINATION2 --build-arg PASSWORD=${MY_PASSWORD} --cleanup'
				}
			}
		}
    stage('Update Git Repo') {
      steps() {
        script {
            sh 'git config --global credential.helper cache'
            sh 'git config --global push.default simple'
            sh 'git config --global user.email "taehyeok02@gmail.com'
            sh 'git config --global user.name "Kim-Taehyeong'

            checkout([
                $class: 'GitSCM',
                branches: [[name: master]],
                extensions: [
                    [$class: 'CloneOption', noTags: true, reference: '', shallow: true]
                ],
                submoduleCfg: [],
                userRemoteConfigs: [
                    [ credentialsId: 'github', url: cloneUrl]
                ]
            ])
            sh "git checkout ${branch}"
            sh "sed -i 's|image: taehyeok02/mycode-server:.*|image: taehyeok02/mycode-server:${env.BUILD_ID}|' deployment.yaml"
            git add deployment.yaml
            git push origin master
      }
    }
    }
	}
}
