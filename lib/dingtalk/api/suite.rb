module Dingtalk
  module Api
    class Suite < Base
      SUITE_TICKET = "suite_ticket"
      SUITE_ACCESS_TOKEN = "suite_access_token"
      EXPIRATION = 7200

      def initialize(suite_key, suite_secret)
        # put them into config file?
        @suite_key = suite_key
        @suite_secret = suite_secret
      end

      def get_permanent_code(tmp_auth_code)
        params = {
          suite_access_token: suite_access_token,
          tmp_auth_code: tmp_auth_code
        }
        http_get('get_permanent_code', params)
      end

      def suite_access_token
        redis.get(SUITE_ACCESS_TOKEN) || set_suite_access_token
      end

      def set_suite_access_token
        params = {
          suite_key: @suite_key,
          suite_secret: @suite_secret,
          suite_ticket: suite_ticket
        }
        http_post('get_suite_token', params)
        # TODO check response values
        redis.set(SUITE_ACCESS_TOKEN, res['suite_access_token'])
        redis.expire(SUITE_ACCESS_TOKEN, EXPIRATION)
        redis.get(SUITE_ACCESS_TOKEN)
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
