require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'helpers/pundit'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical
  # order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers  

  def setup
    self.default_url_options = { locale: I18n.default_locale }
  end

end

