# Base job class
class BaseJob < ActiveJob::Base
  queue_as :default

  # Possible Errors
  class ExecutionError < StandardError; end
  class ValidationError < StandardError; end

  # Error Handling
  rescue_from ExecutionError, with: :execution_error
  rescue_from ValidationError, with: :validation_error

  def perform(*args)
    p "#{self.class.name}: I'm performing my job with arguments: #{args.inspect}"
    output = []

    require 'phantomjs'
    binding.pry
    Phantomjs.run(args[:script_path], args[:payload].to_json) { |line| output << line }
    # p output
    # p "triggered"
    Run.create(agent_id: args[:agent_id], response: JSON({result: output}))
  end

  def execution_error
    p "Execution Error!"
    # retry_job wait: 5.minutes, queue: :low_priority
    # TODO
  end

  def validation_error
    p "Validation Error!"
    # TODO
  end
end
