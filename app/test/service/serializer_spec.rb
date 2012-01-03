# -*- encoding: UTF-8 -*-
require File.dirname(__FILE__) + '/../../service/serializer'
require File.dirname(__FILE__) + '/../../dao/memo'

describe Serializer do
  before(:each) do
    @memo = Memo.new
    @serializer = Serializer.new
    @query = {
      :attr => {
        "uri" => "http://example.com/"
      },
      :text => ["東京は夜の７時"]
    }
  end

  it 'Documentをserializeする' do
    doc = @memo.save(@query)
    serialized = @serializer.serialize_doc(doc)
    serialized[:attr]["id"].should == "1"
  end

  it '複数のDocumentをserializeする' do 
    docs = @memo.find("東京 AND 夜")
    serialized = @serializer.serialize_docs(docs)
    serialized[0][:attr]["id"].should == "1"
  end
end
