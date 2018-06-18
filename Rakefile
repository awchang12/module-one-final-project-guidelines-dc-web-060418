require_relative 'config/environment'
require 'sinatra/activerecord/rake'

task :environment do
  require_relative './config/environment.rb'
end

desc 'starts a console'
task :console => :environment do
  Pry.start
end

