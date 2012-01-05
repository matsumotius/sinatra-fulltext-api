# -*- encoding: UTF-8 -*-
require File.dirname(__FILE__) + '/../../service/query'

describe QueryService do
  before(:each) do
    @query_service = QueryService.new
    @query = { :keyword => ["東京", "夜"] }
    @query_with_similarity = {
      :config  => "12 1024 4096",
      :keyword => {
        "東京" => 100,
        "夜"   => 200 
      }
    }
    @params = {
      :uri    => "9999",
      :text   => "東京は夜の７時",
      :author => "myatsumoto"
    }
  end

  it 'キーワード検索のクエリーをつくる' do
    query = @query_service.search(@query)
    query.should == "東京 AND 夜"
  end

  it '類似検索のクエリーをつくる' do
    query = @query_service.search_similarity(@query_with_similarity)
    query.should == "[SIMILAR] 12 1024 4096 WITH 200 夜 WITH 100 東京"
  end

  it 'パラメータからの保存クエリーをつくる' do
    query = @query_service.save_from_params(@params)
    query[:attr]["uri"].should == @params[:uri]
    query[:attr]["author"].should == @params[:author]
    query[:text][0].should == @params[:text]
  end

  it 'パラメータから検索クエリーをつくる' do
    keyword_params = { :keyword => "東京 夜 ７ 時" } 
    text_params    = { :text => "東京は夜の７時" } 
    query = @query_service.search_from_params(keyword_params)
    query[:keyword][0].should == "東京"
    query = @query_service.search_from_params(text_params)
    query[:keyword][0].should == "東京"
  end

  it 'パラメータから類似検索クエリーをつくる' do
    keyword_params = { :key => "東京 夜 ７ 時", :value => "1 2 3 4" } 
    text_params    = { :text => "東京は夜の７時" } 
    query = @query_service.similarity_from_params(keyword_params)
    query[:keyword]["東京"].should == 1
    query[:keyword]["夜"].should == 2
    query = @query_service.similarity_from_params(text_params)
    query[:keyword]["東京"].should == 1
    query[:keyword]["夜"].should == 1
  end
end
