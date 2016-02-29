module Dingtalk
  module Api
    class Suite < Base
      def initialize(suite_key, suite_secret, suite_ticket, suite_access_token)
        @suite_key = suite_key
        # put suite ticket to redis
        @suite_ticket = suite_ticket
        # put suite access token to redis
        @suite_access_token = suite_access_token
      end

      def get_permanent_code(tmp_auth_code)
        params = {
          suite_access_token: @suite_access_token,
          tmp_auth_code: tmp_auth_code
        }
        http_get('get_permanent_code', params)
      end

      def suite_access_token
        # get from redis or set it
      end

      def set_suite_access_token
        params = {
          suite_key: @suite_key,
          suite_secret: @suite_secret,
          suite_ticket: @suite_ticket
        }
        http_post(request_url(get_suite_token), params)
        # set suite_access_token to redis
      end

      private
        def base_url
          'service'
        end
    end
  end
end
