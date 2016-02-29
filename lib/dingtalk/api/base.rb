module Dingtalk
  module Api
    class Base
      attr_accessor :corp_id

      def initialize(corp_id = nil)
        @corp_id = corp_id
      end

      private
        def http_get(url, params = {})
          res = RestClient.get(request_url(url), params.to_json, content_type: :json)
          JSON.parse(res)
        end

        def http_post(url, params = {})
          res = RestClient.post(request_url(url), params.to_json, content_type: :json)
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
          # debug
          Redis.new
        end
    end
  end
end
