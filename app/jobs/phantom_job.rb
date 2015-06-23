# Base job class
class PhantomJob < ActiveJob::Base
  queue_as :default

  # Possible Errors
  class ExecutionError < StandardError; end
  class ValidationError < StandardError; end

  # Error Handling
  rescue_from ExecutionError, with: :execution_error
  rescue_from ValidationError, with: :validation_error

  def perform(*args)
    p "#{self.class.name}: I'm performing my job with arguments: #{args.inspect}"
    params = args[0]
    output = []

    p "Creating run for agent id: #{params[:agent_id]}"
    run = Run.create(agent_id: params[:agent_id])
    p "Created run with id: #{run.id}"

    Phantomjs.run(params[:script_path],
                  params[:payload].to_json) { |line| output << line }

    # TODO: add validation for phantomjs.run failures,
    # populate Run status appropriately

    run = Run.find(run.id)
    run.status = Run.statuses[:successful]
    run.response = JSON(output[0])
    run.save

    p "Updated run with id: #{run.id}"
  end

  after_perform do |job|
     p "Enqueueing next recurring job after job #{job.id}"
     params = job.args[0]
     job_params = {
       agent_id: params.agent_id,
       payload: params.payload,
       script_path: params.agent_type.script_path
     }
     binding.pry
     self.class.set(wait: interval.minutes).perform_later(job_params)
   end

  protected

  def execution_error
    p "Execution Error!"
    binding.pry
    # retry_job wait: 5.minutes, queue: :low_priority
    # TODO
  end

  def validation_error
    p "Validation Error!"
    binding.pry
    # TODO
  end
end
