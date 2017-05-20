pipeline {
    agent any
    environment { 
        CHEF_HOME='/opt/chefdk/bin/'
        CHEF_RUBY='/opt/chefdk/embedded/bin/'
        HOME='/Users/raghav'
        KITCHEN_LOCAL_YAML='.kitchen.dokken.yml'
        KITCHEN_YAML='.kitchen.yml'
    }
    stages {
        stage('build') {
            steps {
                sh 'PATH=$CHEF_HOME:$CHEF_RUBY:$PATH; kitchen verify'
            }
        }
    }
}
