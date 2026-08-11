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

        booleanParam(
            name: 'RUN_TESTS',
            defaultValue: false,
            description: 'Ejecutar pruebas'
        )

        booleanParam(
            name: 'DEPLOY_PRD',
            defaultValue: false,
            description: 'Desplegar en PROD'
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

        stage ('Tests'){
            when {
                expression { return params.RUN_TESTS }
            }
            steps{
                script {
                    bat 'dotnet test --configuration Release'
                }
            }
        }        

        stage ('Deploy DEV'){
            steps{
                echo 'Despliegue DEV'
            }
        } 

        stage ('Deploy PROD'){
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
