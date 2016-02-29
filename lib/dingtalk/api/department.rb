module Dingtalk
  module Api
    class Department < Base
      def list
        http_get('list')
      end

      private
        def base_url
          'department'
        end
    end
  end
end
