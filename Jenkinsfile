pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-terraform-creds',
                     accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                     secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']
                ]) {
                    dir('terraform') {
                        sh '''
                            export AWS_DEFAULT_REGION="$AWS_REGION"
                            terraform init
                        '''
                    }
                }
            }
        }

        stage('Terraform Format Check') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-terraform-creds',
                     accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                     secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']
                ]) {
                    dir('terraform') {
                        sh '''
                            export AWS_DEFAULT_REGION="$AWS_REGION"
                            terraform fmt -check -diff
                        '''
                    }
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-terraform-creds',
                     accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                     secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']
                ]) {
                    dir('terraform') {
                        sh '''
                            export AWS_DEFAULT_REGION="$AWS_REGION"
                            terraform validate
                        '''
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-terraform-creds',
                     accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                     secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']
                ]) {
                    dir('terraform') {
                        sh '''
                            export AWS_DEFAULT_REGION="$AWS_REGION"
                            terraform plan -out=tfplan
                        '''
                    }
                }
            }
        }

        stage('Approval') {
            steps {
                input message: 'Approve Terraform Apply?'
            }
        }

        stage('Terraform Apply') {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'aws-terraform-creds',
                     accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                     secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']
                ]) {
                    dir('terraform') {
                        sh '''
                            export AWS_DEFAULT_REGION="$AWS_REGION"
                            terraform apply -auto-approve tfplan
                        '''
                    }
                }
            }
        }
    }
}
