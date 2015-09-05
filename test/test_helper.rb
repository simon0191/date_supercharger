require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"
require "logger"
require "byebug"

# for debugging
# ActiveRecord::Base.logger = Logger.new(STDOUT)

# migrations
def establish_connection
  ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

  ActiveRecord::Migration.create_table :visits do |t|
    t.string :city
    t.datetime :visit_date
  end
end

class Visit < ActiveRecord::Base
end
