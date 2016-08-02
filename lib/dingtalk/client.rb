module Dingtalk
  class Client
    def initialize(corp = nil)
      @corp = corp
    end

    def decrypt(echo_str)
      content, status = Dingtalk::Prpcrypt.decrypt(aes_key, echo_str, Dingtalk.suite_key)
      # TODO check status
      JSON.parse(content)
    end

    def response_json(return_str)
      the_timestamp = timestamp
      the_nonce = nonce
      encrypted = encrypt(return_str)
      {
        msg_signature: signature(return_str, encrypted, the_timestamp, the_nonce),
        encrypt: encrypted,
        timeStamp: the_timestamp,
        nonce: the_nonce
      }
    end

    def encrypt(return_str)
      encrypt = Dingtalk::Prpcrypt.encrypt(aes_key, return_str, Dingtalk.suite_key)
    end

    def signature(return_str, encrypted, the_timestamp, the_nonce)
      sort_params = [Dingtalk.suite_token, the_timestamp, the_nonce, encrypted].sort.join
      Digest::SHA1.hexdigest(sort_params)
    end

    def jssign_package(request_url)
      return nil unless @corp

      the_timestamp = timestamp
      the_nonce = nonce
      str = "jsapi_ticket=#{base.js_ticket}&noncestr=#{the_nonce}&timestamp=#{the_timestamp}&url=#{CGI.unescape(request_url)}"
      signature = Digest::SHA1.hexdigest(str)
      {
        js_ticket: base.js_ticket,
        request_url: request_url,
        corp_id: @corp.corp_id,
        timeStamp: the_timestamp,
        nonceStr: the_nonce,
        signature: signature
      }
    end

    def base
      Api::Base.new(@corp)
    end

    def suite
      Api::Suite.new
    end

    def sns
      Api::Sns.new
    end

    def department
      Api::Department.new(@corp)
    end

    def user
      Api::User.new(@corp)
    end

    def attendance
      Api::Attendance.new(@corp)
    end

    def message
      Api::Message.new(@corp)
    end

    def micro_app
      Api::MicroApp.new(@corp)
    end

    def call_back
      Api::CallBack.new(@corp)
    end

    private
      def aes_key
        Base64.decode64(Dingtalk.suite_aes_key + '=')
      end

      def timestamp
        Time.now.to_i.to_s
      end

      def nonce
        SecureRandom.hex
      end
  end
end
