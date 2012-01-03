require 'rubygems'
require 'sinatra'
require File.dirname(__FILE__)+'/bootstrap'

set :environment, :development

set :port, 4567
set :server, 'thin'

Sinatra::Application.run
