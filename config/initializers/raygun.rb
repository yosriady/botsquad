Raygun.setup do |config|
  config.api_key = "kjv82GbXbR3zqW65Q5AnyQ=="
  config.filter_parameters = Rails.application.config.filter_parameters

  # The default is Rails.env.production?
  # config.enable_reporting = !Rails.env.development? && !Rails.env.test?
end
