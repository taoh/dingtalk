module Dingtalk
  class Client
    attr_accessor :corp_id

    def decrypt(echo_str)
      content, status = Dingtalk::Prpcrypt.decrypt(aes_key, echo_str, Dingtalk.suite_key)
      # TODO check status
      JSON.parse(content)
    end

    def response_json(return_str)
      the_timestamp = timestamp
      the_nonce = nonce
      {
        msg_signature: signature(return_str, the_timestamp, the_nonce),
        encrypt: encrypt(return_str),
        timeStamp: the_timestamp,
        nonce: the_nonce
      }
    end

    def encrypt(return_str)
      encrypt = Dingtalk::Prpcrypt.encrypt(aes_key, return_str, Dingtalk.suite_key)
    end

    def signature(return_str, timestamp, nonce)
      sort_params = [Dingtalk.suite_token, timestamp, nonce, encrypt(return_str)].sort.join
      Digest::SHA1.hexdigest(sort_params)
    end

    def jssign_package(request_url)
      sort_params = [base.js_ticket, timestamp, nonce, request_url].sort.join
      signature = Digest::SHA1.hexdigest(sort_params)
      {
        corp_id: @corp_id,
        timeStamp: timestamp,
        nonceStr: nonce,
        signature: signature
      }
    end

    def base
      Api::Base.new(@corp_id)
    end

    def suite
      Api::Suite.new
    end

    def department
      Api::Department.new(@corp_id)
    end

    def user
      Api::User.new(@corp_id)
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
