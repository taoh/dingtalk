module Dingtalk
  module Api
    class MicroApp < Base
      def visible_scopes(agent_id)
        http_post("visible_scopes?access_token=#{access_token}", { agentId: agent_id })
      end

      private
        def base_url
          'microapp'
        end
    end
  end
end


