module Dingtalk
  module Api
    class Suite < Base
      SUITE_TICKET = "suite_ticket"
      SUITE_ACCESS_TOKEN = "suite_access_token"
      EXPIRATION = 7200

      def initialize
        @suite_key = Dingtalk.suite_key
        @suite_secret = Dingtalk.suite_secret
      end

      def get_permanent_code(tmp_auth_code)
        params = {
          tmp_auth_code: tmp_auth_code
        }
        http_post("get_permanent_code?suite_access_token=#{suite_access_token}", params)
      end

      def suite_access_token
        token = redis.get(SUITE_ACCESS_TOKEN)
        token.to_s.empty? ? set_suite_access_token : token
      end

      def set_suite_access_token
        params = {
          suite_key: @suite_key,
          suite_secret: @suite_secret,
          suite_ticket: suite_ticket
        }
        res = http_post('get_suite_token', params)
        # TODO globally check response values
        redis.set(SUITE_ACCESS_TOKEN, res['suite_access_token'])
        redis.expire(SUITE_ACCESS_TOKEN, EXPIRATION)
        redis.get(SUITE_ACCESS_TOKEN)
      end

      def set_corp_access_token(corp_id, permanent_code)
        params = {
          permanent_code: permanent_code,
          auth_corpid: corp_id
        }
        res = http_post("get_corp_token?suite_access_token=#{suite_access_token}", params)
        redis.set("#{corp_id}_#{ACCESS_TOKEN}", res['access_token'])
        redis.expire("#{corp_id}_#{ACCESS_TOKEN}", EXPIRATION)
        redis.get("#{corp_id}_#{ACCESS_TOKEN}")
      end

      def activate_suite(corp_id, permanent_code)
        params = {
          suite_key: @suite_key,
          permanent_code: permanent_code,
          auth_corpid: corp_id
        }
        http_post("activate_suite?suite_access_token=#{suite_access_token}", params)
      end

      def get_auth_info(corp_id, permanent_code)
        params = {
          suite_key: @suite_key,
          suite_access_token: suite_access_token,
          permanent_code: permanent_code,
          auth_corpid: corp_id
        }
        http_post("get_auth_info?suite_access_token=#{suite_access_token}", params)
      end

      def suite_ticket
        redis.get(SUITE_TICKET)
      end

      private
        def default_params
          {}
        end

        def base_url
          'service'
        end
    end
  end
end
