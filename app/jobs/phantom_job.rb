class PhantomJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
   p "#{self.class.name}: I'm performing my job with arguments: #{args.inspect}"

   require 'phantomjs'
   p Phantomjs.path
   Phantomjs.run('public/js/pageload.js') { |line| puts line }
  end
end
