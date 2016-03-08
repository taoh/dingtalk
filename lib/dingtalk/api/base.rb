module Dingtalk
  module Api
    class Base
      attr_accessor :corp_id
      ACCESS_TOKEN = "access_token"
      JS_TICKET = "js_ticket"

      def initialize(corp_id = nil, permanent_code = nil)
        @corp_id = corp_id
        @permanent_code = permanent_code
      end

      def access_token
        redis.get("#{corp_id}_#{ACCESS_TOKEN}") || set_access_token
      end

      def set_access_token
        Suite.new.set_corp_access_token(@corp_id, @permanent_code)
      end

      def js_ticket
        redis.get("#{corp_id}_#{JS_TICKET}") || set_js_ticket
      end

      def set_js_ticket
        key = "#{corp_id}_#{JS_TICKET}"
        res = http_get('get_jsapi_ticket')
        redis.set(key, res['suite_access_token'])
        redis.expire(key, 7200)
        redis.get(key)
      end

      private
        def default_params
          { access_token: access_token }
        end

        def payload(url, params)
          [ request_url(url), {
            params: default_params.merge(params).to_json,
            content_type: :json
          }]
        end

        def http_get(url, params = {})
          p = default_params.merge(params)
          res = RestClient.get(request_url(url), p.to_json, content_type: :json)
          JSON.parse(res)
        end

        def http_post(url, params = {})
          p = default_params.merge(params)
          res = RestClient.post(request_url(url), p.to_json, content_type: :json)
          JSON.parse(res)
        end

        def base_url
          ''
        end

        def request_url(url)
          "#{ENDPOINT}/#{base_url}/#{url}"
        end

        def redis
          Dingtalk.dingtalk_redis
        end
    end
  end
end
