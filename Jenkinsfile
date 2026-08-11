@Library('shared-library-2026@main') _

pipeline {
    agent any

    stages {
        stage('Restore Dependencies') {
            steps {
                dotnetrestore solution: 'MyMinimalApi.sln'
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