pipeline {
    agent any

    environment {
        EC2_USER = 'ubuntu'
        EC2_IP = '34.237.74.175'
        REMOTE_PATH = '/home/ubuntu/node-healthcheck'
        SSH_KEY = credentials('ssh-key-ec2-qa')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'QA', url: 'https://github.com/esquincaae/JenkinsProject.git'
            }
        }

        stage('Build') {
            steps {
                sh 'rm -rf node_modules'
                sh 'npm ci'
            }
        }

        stage('Deploy') {
            steps {
                sh '''#!/bin/bash
                ssh -i $SSH_KEY -o StrictHostKeyChecking=no $EC2_USER@$EC2_IP << 'ENDSSH'
                    cd $REMOTE_PATH &&
                    git pull origin main &&
                    npm ci &&
                    pm2 restart health-api || pm2 start server.js --name health-api
                ENDSSH
                '''
            }
        }
    }
}