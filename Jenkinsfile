pipeline {
    agent { label 'master' }
    triggers {pollSCM('* * * * *')}
    stages {
        stage ('clone from git repo'){
            steps{
                git 'https://github.com/fil-andr/jenkins_test_rep.git'
				sh 'yes | cp /var/lib/jenkins/workspace/${JOB_NAME}/get_row_from_db.py /docker_test/get_row_from_db/app/'
            }
		}
		stage ('stop and rm container and image') {
			steps{
				sh '/bin/bash /docker_test/get_row_from_db/app_dev/stop_container_get_row.sh'
				sh 'docker rm get_row_from_db_get_row_1'
				sh '/bin/bash /docker_test/get_row_from_db/app_dev/rm_img_if_exist.sh'
				}
		}
		stage ('build new image') {
			steps{
				sh 'cd /docker_test/get_row_from_db && docker build -t get_row -f dockerfile_get_row .'
			}
		}
		stage ('run conteiner'){
			steps{
				sh 'cd /docker_test/get_row_from_db && /usr/local/bin/docker-compose -f compose.yml  up -d'
			}
		}
    }
    post {
        success {
            script {
                withCredentials([string(credentialsId: 'TG_TOKEN', variable: 'TOKEN'),
                string(credentialsId: 'TG_GROUP_ID', variable: 'CHAT_ID')])
                {sh "curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d text=\"job ${env.JOB_NAME} build SUCCESS\""}
            }
        }
        failure {
            script {
                withCredentials([string(credentialsId: 'TG_TOKEN', variable: 'TOKEN'),
                string(credentialsId: 'TG_GROUP_ID', variable: 'CHAT_ID')])
                {sh "curl -s -X POST https://api.telegram.org/bot${TOKEN}/sendMessage -d chat_id=${CHAT_ID} -d text=\"job ${env.JOB_NAME} build FAIL\""}
            }
        }
    }
}
