require 'rubygems'
require 'bundler/setup'
require 'rack'
require 'yaml'
require 'json'
require 'haml'

[:helpers, :models ,:controllers].each do |dir|
  Dir.glob(File.dirname(__FILE__)+"/app/#{dir}/*.rb").each do |rb|
    puts "loading #{rb}"
    require rb
  end
end

set :haml, :escape_html => true

begin
  @@conf = YAML::load open(File.dirname(__FILE__)+'/resource/conf/config.yaml').read
  p @@conf
rescue => e
  STDERR.puts 'config.yaml load error!'
  STDERR.puts e
  exit 1
end

