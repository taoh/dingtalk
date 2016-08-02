module Dingtalk
  module Api
    class CallBack < Base
      def register_call_back(call_back_tag, url)
        http_post("register_call_back?access_token=#{access_token}", params(call_back_tag, url))
      end

      def update_call_back(call_back_tag, url)
        http_post("update_call_back?access_token=#{access_token}", params(call_back_tag, url))
      end

      def get_call_back
        http_get("get_call_back?access_token=#{access_token}")
      end


      def delete_call_back
        http_get("delete_call_back?access_token=#{access_token}")
      end

      private
        def params(call_back_tag, url)
          {
            call_back_tag: call_back_tag,
            token: Dingtalk.suite_token,
            aes_key: Dingtalk.suite_aes_key,
            url: url
          }
        end

        def base_url
          'call_back'
        end
    end
  end
end
