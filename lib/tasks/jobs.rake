namespace :jobs do
  desc "Clear all jobs from all Sidekiq queues"
  task clear: :environment do
    queues = ::Sidekiq::Stats.new.queues.keys.map { |name| ::Sidekiq::Queue.new(name) }
    queues.each { |q| q.clear }
    p "Jobs cleared!"
  end
end
