@Env = ENV["RACK_ENV"] || "development"

require "./setup/libs"
require "./setup/configure"

Dir['./app/controllers/**/*.rb'].each { |file| require file }
Dir['./lib/marvel_champions/*.rb'].each { |file| require file }
Dir['./lib/marvel_champions/**/*.rb'].each { |file| require file }