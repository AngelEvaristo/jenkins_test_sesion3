@Library('shared-library-2026@main') _

pipeline {
    agent any

    parameters {
        choice(name: 'DEPLOY_TARGET', choices: ['appservice', 'lambda'], description: 'Destino de despliegue')
    }

    environment {
        APP_SERVICE_RESOURCE_GROUP = 'test-jenkins-deploy'
        APP_SERVICE_NAME = 'dotnet-test-deploy'
        AWS_REGION = 'us-east-1'
        AWS_LAMBDA_FUNCTION_NAME = 'my-minimal-api-function'
    }

    stages {
        stage('Restore Dependencies') {
            steps {
                dotnetrestore solution: 'MyMinimalApi.sln'
            }
        }
        stage('Build') {
            steps {
                dotnetbuild solution: 'MyMinimalApi.sln', configuration: 'Release'
            }
        }
        stage('Test') {
            steps {
                dotnettest solution: 'MyMinimalApi.sln', configuration: 'Release'
            }
        }
        stage('Publish') {
            steps {
                dotnetpublish solution: 'MyMinimalApi.sln', configuration: 'Release', outputdir: 'publish'
                archiveArtifacts artifacts: 'publish/**', fingerprint: true
            }
        }

        stage('Package Artifact') {
            steps {
                bat 'if exist publish.zip del /f /q publish.zip'
                bat 'powershell Compress-Archive -Path publish/* -DestinationPath publish.zip'
            }
        }

        stage('Deploy to App Service') {
            when {
                expression { params.DEPLOY_TARGET == 'appservice' }
            }
            steps {
                withCredentials([azureServicePrincipal('SPN-test')]) {
                    bat 'az login --service-principal -u %AZURE_CLIENT_ID% -p %AZURE_CLIENT_SECRET% --tenant %AZURE_TENANT_ID%'
                    bat 'az webapp deployment source config-zip --resource-group %APP_SERVICE_RESOURCE_GROUP% --name %APP_SERVICE_NAME% --src publish.zip'
                }
            }
        }

        stage('Deploy to AWS Lambda') {
            when {
                expression { params.DEPLOY_TARGET == 'lambda' }
            }
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-jenkins-creds']]) {
                    bat 'aws sts get-caller-identity'
                    bat 'aws lambda update-function-code --function-name %AWS_LAMBDA_FUNCTION_NAME% --zip-file fileb://publish.zip --region %AWS_REGION%'
                }
            }
        }
    }




    // stages {
    //     stage('Load remote pipeline') {
    //         steps {
    //             script {
    //                 dir('jenkins_test_sesion3_remote') {
    //                 checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/AngelEvaristo/jenkins_test_sesion3_remote.git', credentialsId: 'github_repo']]])
    //                 }
    //                 def buildAndTest = load 'jenkins_test_sesion3_remote/pipelines/buildandtest.groovy'
    //                 buildAndTest.call('jenkins_test_sesion3')                
    //             }

    //         }
    //     }
    // }
}