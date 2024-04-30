pipeline {
    agent any

    environment {
        // Set up your environment variables
        AWS_DEFAULT_REGION = 'us-east-1'
        ECR_REGISTRY = '093276084297.dkr.ecr.us-east-1.amazonaws.com'
        REPO_NAME = 'lucid-repo'
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    //  Dockerfile need to be in the Jenkins workspace
                    sh "docker build -t ${ECR_REGISTRY}/${REPO_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Push Image to ECR') {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                        sh("aws ecr get-login-password --region $AWS_DEFAULT_REGION | docker login --username AWS --password-stdin ${ECR_REGISTRY}")
                        sh "docker push ${ECR_REGISTRY}/${REPO_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }

        stage('Deploy to AWS using Terraform') {
            steps {
                script {
                    // Assuming Terraform files are ready in the workspace
                    sh "terraform init"
                    sh "terraform apply -auto-approve -var 'image_tag=${IMAGE_TAG}'"
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
