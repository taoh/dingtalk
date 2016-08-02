module Dingtalk
  module Api
    class CallBack < Base
      def initialize
        @suite_token = Dingtalk.suite_token
        @suite_aes_key = Dingtalk.suite_aes_key
      end

      def register_call_back(call_back_tag = [], url)
        params = {
          call_back_tag: call_back_tag,
          token: @suite_token,
          aes_key: @suite_aes_key,
          url: url
        }
        http_post("register_call_back?access_token=#{access_token}", params)
      end

      private
        def base_url
          'call_back'
        end
    end
  end
end
