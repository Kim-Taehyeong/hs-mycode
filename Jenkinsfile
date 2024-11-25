pipeline {

	agent {
	    kubernetes {
	yaml '''
	apiVersion: v1
	kind: Pod
	spec:
	  containers:
	  - name: kaniko
	    iamge: gcr.io/kaniko-project/executor:debug
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
		stage('Docker Build') {
			steps() {
				script {
					dockerImage = docker.build repository + ":${env.BULID_ID}"
				}
			}
		}
		stage('Push Image to Docker Hub') {
			steps() {
				container('kaniko') {
					sh "executor --dockerfile=Dockerfile \
					--context=dir://${env.WORKSPACE} \
					--destination=${params.IMAGE_REGISTRY_ACCOUNT}/${params.IMAGE_NAME}:${env.BUILD_ID} \
					--destination=${params.IMAGE_REGISTRY_ACCOUNT}/${params.IMAGE_NAME}:latest"
				}
			}
		}
	}
}
