# -*- encoding: UTF-8 -*-
require 'rubygems'
require 'sinatra'
require 'json'
require File.dirname(__FILE__) + '/../util/response'
require File.dirname(__FILE__) + '/../util/message'
require File.dirname(__FILE__) + '/../service/query'
require File.dirname(__FILE__) + '/../service/memo'
# module
include Response
include Message::Error

before do
  content_type = "application/json"
end

post '/memo' do
  if params[:uri] and params[:text]
    @memo  = MemoService.new
    @query = QueryService.new
    response = @memo.save(@query.save_from_params(params))
  else
    response = Response::error({ :message => Message::Error::required_parameter("uri or text") })
  end
  response.json
end

get '/memo' do
  if params[:keyword]
    @memo = MemoService.new
    response = @memo.search({ :keyword => params[:keyword].strip.split(/\s+/) })
  else
    response = Response::error({ :message => Message::Error::required_parameter("keyword") })
  end
  response.json
end

get '/memo/similarity' do
  if params[:key] and params[:value]
    @memo = MemoService.new
    keys = params[:key].strip.split(/\s+/)
    values = params[:value].strip.split(/\s+/)
    keywords = [keys, values].transpose
    response = @memo.search_similarity({ :keyword => Hash[*keywords.flatten] })
  else
    response = Response::error({ :message => Message::Error::invalid_parameter("id") })
  end
  response.json
end

get '/memo/:id' do
  if params[:id]
    @memo = MemoService.new
    response = @memo.search_by_id(params[:id])
  else
    response = Response::error({ :message => Message::Error::required_parameter("id") })
  end
  response.json
end

get '/memo/:id/similarity' do
  if params[:id].to_i > 0
    @memo = MemoService.new
    search_by_id = @memo.search_by_id(params[:id])
    if search_by_id.is_success
      doc = search_by_id.hash[:data][:doc]
      response = @memo.search_similarity({ :keyword => doc[:keyword] })
    else
      response = Response::error({ :message => Message::Error::not_found })
      halt response.json
    end
  else
    response = Response::error({ :message => Message::Error::invalid_parameter("id") })
  end
  response.json
end

