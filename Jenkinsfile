pipeline {
    
    agent { label 'windows' }
    
    environment {
        DN_VERSION= "9.0"
    }
    
    stages {
        stage ('Clonar desde Github'){
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github_repo', url: 'https://github.com/AngelEvaristo/jenkins_test_sesion3.git']])
            }
        }
        
        stage ('Resturar dependencias'){
            steps{
                script {
                    bat 'dotnet restore'
                }
            }
        }

        stage ('Compilar'){
            steps{
                script {
                    bat 'dotnet build --configuration Release'
                }
            }
        }
        
    }
}
