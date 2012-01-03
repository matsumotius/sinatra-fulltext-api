# -*- encoding: UTF-8 -*-
require 'rubygems'
require 'json'

module Response
  class Message
    def initialize(attribute = {})
      @attribute = attribute
      @is_success = false
    end

    def is_success
      @is_success
    end

    def success
      @is_success = true;
    end

    def error
      @is_success = false;
    end

    def message
      @attribute[:message]
    end

    def data
      @attribute[:data]
    end

    def json
      hash.to_json
    end

    def hash
      { 'is_success' => @is_success }.merge(@attribute)
    end
  end

  def success(params = {})
    message = Message.new(params)
    message.success
    return message
  end

  def error(params = {})
    message = Message.new(params)
    message.error
    return message
  end
end
