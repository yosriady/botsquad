# Base job class
class BaseJob < ActiveJob::Base
  queue_as :default

  before_enqueue do |job|
    # Validate arguments
    p job
  end

  around_perform do |job, block|
    # Create Run instance before perform
    p job
    block.call
    # Set Run status depending on call success/error
  end

  def perform(*args)
    p "#{self.class.name}: I'm performing my job with arguments: #{args.inspect}"

    require 'phantomjs'
    p Phantomjs.path
    Phantomjs.run(script_path) { |line| puts line }
  end

  # Methods below may be overriden by subclasses
  def script_path
    'public/js/pageload.js'
  end

  def default_args
    '{}'
  end
end
