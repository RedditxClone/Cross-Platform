pipeline {
	agent any
	stages {
		stage('Docker') {
			environment {
				BASE_URL = credentials('BASE_URL')
    		}
			steps {
				sh  '''
					cd reddit
					docker-compose up --build -d
					'''
            }
		}
	}
}
