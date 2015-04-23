# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AgentType.create(name: "Uptime Agent", description: "Uptime Agents lets you check if a webpage is up and running.", sample_payload: JSON({url:'http://google.com'}), sample_response: JSON({url:'http://google.com',status:200}), job_type: "BaseJob", script_path: "/public/js/uptime.js")