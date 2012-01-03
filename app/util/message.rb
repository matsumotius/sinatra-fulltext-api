# -*- encoding: UTF-8 -*-
require 'rubygems'

module Message
  module Error
    def internal
      "内部でエラーが起きました"
    end

    def invalid_parameter(key = "")
      "無効なパラメータ #{key.to_s}"
    end

    def required_parameter(key = "")
      "不足しているパラメータ #{key.to_s}"
    end

    def not_found()
      "指定した条件では見つかりませんでした"
    end
  end
end
