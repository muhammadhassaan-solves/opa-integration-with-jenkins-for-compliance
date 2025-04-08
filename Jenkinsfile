pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }
        stage('Compliance Check') {
            steps {
                script {
                    def complianceResult = sh(script: '''
curl -s -X POST http://localhost:8181/v1/data/jenkins/compliance/allow \
  -H "Content-Type: application/json" \
  -d '{"input": {"app": {"debug": true, "protocol": "http"}}}'
''', returnStdout: true).trim()

                    def complianceStatus = readJSON text: complianceResult
                    if (!complianceStatus.result) {
                        error "Compliance check failed: ${complianceResult}"
                    } else {
                        echo "Compliance check passed."
                    }
                }
            }
        }
        stage('Deploy') {
            when {
                expression { return currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                echo 'Deploying...'
            }
        }
    }
}
