# -*- encoding: UTF-8 -*-
require File.dirname(__FILE__) + '/../util/response'
require File.dirname(__FILE__) + '/../util/message'
require File.dirname(__FILE__) + '/../dao/memo'
require File.dirname(__FILE__) + '/../service/serializer'
require File.dirname(__FILE__) + '/../service/query'
include Response
include Message

class MemoService
  def initialize
    @memo       = Memo.new
    @query      = QueryService.new
    @serializer = Serializer.new
  end

  def save(query)
    begin
      doc = @memo.save(query)
      Response::success({ :data => { :doc => @serializer.serialize_doc(doc) } })
    rescue => e
      Response::error({ :message => Message::Error::internal })
    end
  end
  
  def search(query)
    begin
      docs = @memo.find(@query.search(query))
      Response::success({ :data => { :doc => @serializer.serialize_docs(docs) } })
    rescue => e
      Response::error({ :message => Message::Error::internal })
    end
  end

  def search_by_id(id)
    begin
      doc = @memo.find_by_id(id.to_i)
      Response::success({ :data => { :doc => @serializer.serialize_doc(doc) } })
    rescue => e
      Response::error({ :message => Message::Error::internal })
    end
  end

  def search_similarity(query)
    begin
      docs = @memo.find(@query.search_similarity(query))
      Response::success({ :data => { :doc => @serializer.serialize_docs(docs) } })
    rescue => e
      Response::error({ :message => Message::Error::internal })
    end
  end

  def search_similarity_by_id(id)
    begin
      search_by_id = search_by_id(id)
      doc  = search_by_id[:data][:doc]
      docs = @memo.find(@query.search_similarity({ :keyword => doc[:attr]["keyword"] }))
      Response::success({ :data => { :doc => @serializer.serialize_docs(docs) } })
    rescue => e
      Response::error({ :message => Message::Error::internal })
    end
  end

  def remove(id)

  end
end
