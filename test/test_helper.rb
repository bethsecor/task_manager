ENV['RACK_ENV'] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'

Capybara.app = TaskManagerApp

class Minitest::Test
  def teardown
    TaskManager.delete_all
  end
end

class FeatureTest < Minitest::Test
  include Capybara::DSL # domain specific language
end
