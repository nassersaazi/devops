module Secretable
  extend ActiveSupport::Concern

  require 'random_name_generator'

  private
  
  def generate_secrets
    self.upstream_secret = generate_random_secret
    self.monitor_secret = generate_random_secret
    self.switchboard_secret = generate_random_secret
  end

  def generate_test_user
    rng = RandomNameGenerator.new(RandomNameGenerator::ROMAN)
    self.test_user = rng.compose(3).downcase
    self.test_password = generate_random_secret
  end

  def generate_random_secret
    SecureRandom.hex(12)
  end

end