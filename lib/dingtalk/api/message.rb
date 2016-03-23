module Dingtalk
  module Api
    class Message < Base
      def send_with(params)
        http_post('send', params)
      end

      private
        def base_url
          'message'
        end
    end
  end
end
