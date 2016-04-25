module Dingtalk
  module Api
    class User < Base
      def get_user_info(code)
        http_get("getuserinfo?access_token=#{access_token}&code=#{code}")
      end

      def get(userid)
        http_get("get?access_token=#{access_token}&userid=#{userid}")
      end

      def get_by_mobile(mobile)
        http_get("get_by_mobile?access_token=#{access_token}&mobile=#{mobile}")
      end

      private
        def base_url
          'user'
        end
    end
  end
end

