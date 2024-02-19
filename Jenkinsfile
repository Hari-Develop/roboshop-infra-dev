pipeline{
    agent {
        label "Jenkins_agent"
    }
    parameters {
        choice( name: 'action', choices: ['apply', 'destroy'], description: 'select action' )
    }
    options {
        ansiColor('xterm')
    }
    stages {
        stage("01-vpc") {
            steps {
                sh """
                    cd 01-vpc
                    terraform init
                    terraform plan
                    terraform ${params.action} -auto-approve
                """
            }
        }
        stage("02-sg") {
            steps {
                sh """
                    cd 02-sg
                    terraform init
                    terraform plan
                    terraform ${params.action} -auto-approve
                """
            }
        }
        stage('VPN') {
            steps {
                sh """
                    cd 03-vpn
                    terraform init -reconfigure
                    terraform ${params.action} -auto-approve
                """
            }
        }
        stage('DB ALB') {
            parallel {
                stage('04-databases') {
                    steps {
                        sh """
                        cd 04-databases
                        terraform init -reconfigure
                        terraform ${params.action} -auto-approve
                    """
                    }
                }
                stage('05-app-alb') {
                    steps {
                        sh """
                        cd 05-app-alb
                        terraform init -reconfigure
                        terraform ${params.action} -auto-approve
                    """
                    }
                }
            }
        }
    }
    post{
        success{
            echo "pipeline is success"
        }
        failure{
            echo "pipline is failure"
        }
    }
}
