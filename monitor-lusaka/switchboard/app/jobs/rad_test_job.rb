class RadTestJob < ApplicationJob
  queue_as :default

  after_perform do |job|
    # invoke another job at your time of choice 
    self.class.set(wait: 5.minutes).perform_later(job.arguments.first)
  end

  def perform(*args)
    # Do something later
  end
end
