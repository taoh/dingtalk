module Dingtalk
  module Api
    class Sns
      def initialize
        @app_id = Dingtalk.sns_app_id
        @app_secret = Dingtalk.sns_app_secret
      end
    end
  end
end
