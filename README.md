### Ruby(Rails) project for operations management implemented with ActiveRecord, RSpec, Sphinx
### Dependencies:
- Ruby 2.2.1
- PostgreSQL
- Sphinx
- Redis
- ImageMagick

### Installation:
   - Clone poject
   - Run commands:
   
   ```shell
    $ cp config/database.yml.example config/database.yml
    $ bundle install
    S bundle exec rake db:setup
   ```
   - Run application: #(please use different terminal tabs for each comand)
   ```shell
    $ rails s -p 3000
    $ redis-server #(background jobs)
    $ sidekiq #(background jobs)
    $ rake ts:index ts:start #(indexes and starts the Sphinx)
   ```
   
   ##### Tests:

   To execute tests, run following commands:

   ```shell
    $ bundle exec rake db:migrate RAILS_ENV=test #(the first time only)
    $ bundle exec rspec
   ```

### License

The software is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).