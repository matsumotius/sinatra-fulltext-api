# -*- encoding: UTF-8 -*-
require File.dirname(__FILE__) + '/../../service/memo'

describe MemoService do
  before(:each) do
    @memo_service = MemoService.new
    @query = {
      :attr => {
        "uri" => "http://example.com/"
      },
      :text => ["東京は夜の７時"]
    }
  end

  it 'メモを保存する' do
    save_memo = @memo_service.save(@query)
    save_memo.is_success.should == true
    memo = save_memo.hash[:data][:doc]
    memo[:attr]["id"].should == "1"
    memo[:attr]["uri"].should == "http://example.com/"
  end

  it 'メモをキーワードで検索する' do
    find_memo = @memo_service.search({ :keyword => ['東京', '夜'] })
    find_memo.is_success.should == true
  end

  it 'メモをキーワードで類似検索する' do
    find_memo = @memo_service.search_similarity({ :keyword => { '東京' => 200, '夜' => 100 } })
    find_memo.is_success.should == true
  end
end
