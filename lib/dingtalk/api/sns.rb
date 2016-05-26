module Dingtalk
  module Api
    class Sns < Base
      ACCESS_TOKEN = "sns_access_token"

      def initialize
        @app_id = Dingtalk.sns_app_id
        @app_secret = Dingtalk.sns_app_secret
      end

      def access_token
        token = redis.get(ACCESS_TOKEN)
        token.to_s.empty? ? set_access_token : token
      end

      def set_access_token
        res = http_get("gettoken?appid=#{@app_id}&appsecret=#{@app_secret}")
        redis.set(ACCESS_TOKEN, res['access_token'])
        redis.expire(key, 7200)
        redis.get(ACCESS_TOKEN)
      end

      def get_persistent_code(code)
        params = { tmp_auth_code: code }
        http_post("get_persistent_code?access_token=#{access_token}", params)
      end

      def get_sns_token(openid, persistent_code)
        params = {
          openid: openid,
          persistent_code: persistent_code
        }

        http_post("get_sns_token?access_token=#{access_token}", params)
      end

      def get_user_info(sns_token)
        http_get("getuserinfo?sns_token=#{sns_token}")
      end

      private
        def default_params
          {}
        end

        def base_url
          'sns'
        end
    end
  end
end
