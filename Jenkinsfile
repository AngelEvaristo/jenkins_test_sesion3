pipeline {
    
    agent any

    parameters {
        string(
            name: 'BRANCH_NAME',
            defaultValue: 'makefile',
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

        choice(
            name: 'ENVIRONMENT',
            choices: ['DEV', 'QA', 'PROD'],
            description: 'Selecciona el entorno de despliegue'
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

        stage ('Validar Makefile'){
            steps{
                script {
                    bat 'make --version'
                }
            }
        }
        
        stage ('Restore'){
            steps{
                script {
                    bat 'make restore'
                }
            }
        }

        stage ('build'){
            when {
                expression { return params.COMPILE }
            }
            steps{
                script {
                    bat 'make build'
                }
            }
        }

        stage ('Tests'){
            when {
                expression { return params.RUN_TESTS }
            }
            steps{
                script {
                    bat 'make test'
                }
            }
        }  

        stage ('Publish'){
            when {
                expression { return params.COMPILE }
            }
            steps{
                script {
                    bat 'make publish'
                }
            }
        }               

        stage ('Deploy DEV'){
            when {
                expression { return params.ENVIRONMENT == 'DEV' }
            }
            steps{
                echo 'Despliegue DEV'
            }
        } 

        stage ('Deploy PROD'){
            when {
                expression { return params.ENVIRONMENT == 'PROD' && params.DEPLOY_PRD }
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
