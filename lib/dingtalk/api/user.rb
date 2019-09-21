module Dingtalk
  module Api
    class User < Base
      def get_user_info(code)
        http_get("getuserinfo?access_token=#{access_token}&code=#{code}")
      end

      def userids(department=1)
        http_get("getDeptMember?access_token=#{access_token}&deptId=#{department}")
      end

      def simplelist(department=1)
        http_get("simplelist?access_token=#{access_token}&department_id=#{department}")
      end

      def listbypage(department=1, offset=0, size=20, order='custom')
        http_get("list?access_token=#{access_token}&department_id=#{department}&offset=#{offset}&size=#{size}&order=#{order}")
      end

      def get(userid)
        http_get("get?access_token=#{access_token}&userid=#{URI.escape userid}")
      end

      def get_admin
        http_get("get_admin?access_token=#{access_token}")
      end

      def get_admin_scope
        http_get("get_admin_scope?access_token=#{access_token}")
      end

      def get_access_microapp(app_id, user_id)
        http_get("get_access_microapp?access_token=#{access_token}&appId=#{app_id}&user_id=#{URI.escape userid}")
      end

      def get_userid_by_unionid(unionid)
        http_get("getUseridByUnionid?access_token=#{access_token}&unionid=#{URI.escape unionid}")
      end

      # onlyActive: 0: 包含未激活钉钉的人员数量, 1: 不包含未激活钉钉的人员数量
      def get_org_user_count(onlyActive = 0)
        http_get("get_org_user_count?access_token=#{access_token}&onlyActive=#{onlyActive}")
      end

      def delete(userid)
        http_get("delete?access_token=#{access_token}&userid=#{URI.escape userid}")
      end

      def get_by_mobile(mobile)
        http_get("get_by_mobile?access_token=#{access_token}&mobile=#{URI.encode_www_form_component mobile}")
      end

      def create(name, mobile, department=[1], options={})
        params = options.merge(
          name: name,
          mobile: mobile,
          department: department
        )
        http_post("create?access_token=#{access_token}", params)
      end

      def update(params)
        http_post("update?access_token=#{access_token}", params)
      end

      private
        def base_url
          'user'
        end
    end
  end
end

