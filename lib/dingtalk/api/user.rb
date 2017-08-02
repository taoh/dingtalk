module Dingtalk
  module Api
    class User < Base
      def get_user_info(code)
        http_get("getuserinfo?access_token=#{access_token}&code=#{code}")
      end

      def get(userid)
        http_get("get?access_token=#{access_token}&userid=#{URI.escape userid}")
      end

      def delete(userid)
        http_get("delete?access_token=#{access_token}&userid=#{URI.escape userid}")
      end

      def get_by_mobile(mobile)
        http_get("get_by_mobile?access_token=#{access_token}&mobile=#{mobile}")
      end

      def create(name, mobile, department=[1], options={})
        params = options.merge(
          name: name,
          mobile: mobile,
          department: department
        )
        http_post("create?access_token=#{access_token}", params)
      end

      def update(params)
        http_post("update?access_token=#{access_token}", params)
      end

      private
        def base_url
          'user'
        end
    end
  end
end

