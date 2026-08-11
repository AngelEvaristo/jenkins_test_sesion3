@Library('shared-library-2026@main') _

pipeline {
    agent any

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