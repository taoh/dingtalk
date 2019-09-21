module Dingtalk
  module Api
    class Message < Base
      def send(userid_list, msg)
        http_post("asyncsend_v2?access_token=#{access_token}", {
          agent_id: @corp.agent_id,
          userid_list: userid_list,
          msg: msg
        })
      end

      def send_to_departments(dept_id_list, msg)
        http_post("asyncsend_v2?access_token=#{access_token}", {
          agent_id: @corp.agent_id,
          dept_id_list: dept_id_list,
          msg: msg
        })
      end

      def send_to_all_users(msg)
        if @corp.isv_mode?
          raise 'ISV not supporting sending messages to all users'
        end
        http_post("asyncsend_v2?access_token=#{access_token}", {
          agent_id: @corp.agent_id,
          to_all_user: true,
          msg: msg
        })
      end

      private
        def base_url
          'topapi/message/corpconversation'
        end
    end
  end
end
