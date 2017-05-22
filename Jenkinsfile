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
        stage('check style') {
            steps {
                // on Build agent , do bundle install; and use Rake style/lint, unit and integration as different steps 
                sh 'PATH=$CHEF_HOME:$CHEF_RUBY:$PATH; chef exec rake style'
            }
        }
        stage('test') {
            steps {
                // on Build agent , do bundle install; and use Rake style/lint, unit and integration as different steps 
                sh 'PATH=$CHEF_HOME:$CHEF_RUBY:$PATH; kitchen verify'
            }
        }
    }
}
