#!groovy
pipeline {
    agent any
    options {
        buildDiscarder(logRotator(numToKeepStr:'10'))
    }
    environment { 
        CHEF_HOME='/opt/chefdk/bin/'
        CHEF_RUBY='/opt/chefdk/embedded/bin/'
        HOME=${env.HOME}
        KITCHEN_LOCAL_YAML='.kitchen.dokken.yml'
        KITCHEN_YAML='.kitchen.yml'
    }
    stages {
        stage('lint check') {
            steps {
                // on Build agent , do bundle install; and use Rake style/lint, unit and integration as different steps 
                sh 'PATH=$CHEF_HOME:$CHEF_RUBY:$PATH; chef exec rake style:chef'
            }
        }
        stage('style check') {
            steps {
                sh 'PATH=$CHEF_HOME:$CHEF_RUBY:$PATH; chef exec rake style:ruby'
            }
        }
        stage('unit tests') {
            steps {
                sh 'PATH=$CHEF_HOME:$CHEF_RUBY:$PATH; chef exec rake unit'
            }
        }
        stage('integration tests') {
            steps {
                sh 'PATH=$CHEF_HOME:$CHEF_RUBY:$PATH; kitchen verify'
            }
        }
    }
  post {
    always {
      echo "Result: ${currentBuild.result}"
    }
  }
}
