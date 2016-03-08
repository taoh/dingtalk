module Dingtalk
  module Api
    class User < Base
      def get_user_info(code)
        http_get('getuserinfo', { code: code })
      end

      def get(userid)
        http_get('get', { userid: userid })
      end

      private
        def base_url
          'user'
        end
    end
  end
end

