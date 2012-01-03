# -*- encoding: UTF-8 -*-
require File.dirname(__FILE__) + '/../../dao/memo'

describe Memo do
  after(:all) do
    @memo = Memo.new
  end

  before(:each) do
    @memo  = Memo.new
    @query = {
      :attr => {
        "uri" => "http://example.com/"
      },
      :text => ["東京は夜の７時"]
    }
  end

  it 'メモを保存する' do
    doc = @memo.save(@query)
    doc.id().should == 1
    doc.attr("@uri").should == @query[:attr]["uri"]
  end

  it 'メモをIDから取得する' do
    doc = @memo.find_by_id(1)
    doc.attr("@uri").should == @query[:attr]["uri"]
  end

  it 'メモを検索して取得する' do
    docs = @memo.find("東京 AND 夜")
    docs.length.should == 1
    docs[0].attr("@uri").should == @query[:attr]["uri"]

  end

  it 'メモを検索する' do
    docs = []
    result = @memo.search("東京 AND 夜")
    length = result.doc_num
    for index in 0...length
      doc = @memo.find_by_id(result.get_doc_id(index))
      docs.push(doc)
    end
    docs.length.should == 1
    docs[0].attr("@uri").should == @query[:attr]["uri"]
  end

  it 'メモを削除する' do
    doc = @memo.save({
      :attr => {
        "uri" => "http://example.com/2"
      },
      :text => ["東京は夜の７時"]
    })
    @memo.remove(doc.attr("@id"))
    result = @memo.search("東京 AND 夜")
    result.doc_num.should == 1
  end
end
