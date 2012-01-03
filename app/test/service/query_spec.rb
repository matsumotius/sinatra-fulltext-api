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
end
