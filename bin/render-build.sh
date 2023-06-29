set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
# bundle exec rake db:seed
# remove or comment out line 7 after initial build
# renderbuild