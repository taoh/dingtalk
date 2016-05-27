module Dingtalk
  module Api
    class Attendance < Base
      def list(params)
        http_post("list?access_token=#{access_token}", params)
      end

      private
        def base_url
          'attendance'
        end
    end
  end
end
