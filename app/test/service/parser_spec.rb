# -*- encoding: UTF-8 -*-
require File.dirname(__FILE__) + '/../../service/parser'

describe Parser do
  before(:each) do
    @parser = Parser.new
  end

  it '文字列から単語を抽出する' do
    result = @parser.parse("文字列から単語を抽出する")
    result.hash[:noun][0].should == '文字'
  end

  it '文字列から単語の出現回数を解析する' do
    result = @parser.parse("東京は夜の７時。大阪は夜の６時。")
    result.hash[:rank]["東京"].should == 1
    result.hash[:rank]["時"].should == 2
  end
end
