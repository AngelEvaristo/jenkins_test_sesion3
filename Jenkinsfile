pipeline {
    
    agent any

    parameters {
        string(
            name: 'BRANCH_NAME',
            defaultValue: 'main',
            description: 'Nombre de la rama a compilar'
        )

        booleanParam(
            name: 'COMPILE',
            defaultValue: false,
            description: 'Compilar el proyecto'
        )
    }    

    environment {
        DN_VERSION= "9.0"
    }
    
    stages {
        stage ('Clonar desde Github'){
            steps {
                checkout scmGit(branches: [[name: "*/${params.BRANCH_NAME}"]], extensions: [], userRemoteConfigs: [[credentialsId: 'github_repo', url: 'https://github.com/AngelEvaristo/jenkins_test_sesion3.git']])
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
            when {
                expression { return params.COMPILE }
            }
            steps{
                script {
                    bat 'dotnet build --configuration Release'
                }
            }
        }

        stage ('Deploy DEV'){
            when {
             branch 'develop'
            }
            steps{
                echo 'Despliegue DEV'
            }
        } 

        stage ('Deploy PROD'){
            when {
             branch 'main'
            }
            steps{
                input message: '¿Autotiza la ejecucion?'
                echo 'Despliegue PROD'
            }
        }  
        
    }
    post {
        always {
            cleanWs()
        }
        success {
            echo "Compilacion correcta"
        }
        failure {
            echo "Error en compilacion"
        }
        
    }
    
}
