module Dingtalk
  class Client
    attr_accessor :corp_id

    def decrypt(echo_str)
      content, status = Dingtalk::Prpcrypt.decrypt(aes_key, echo_str, Dingtalk.suite_key)
      # TODO check status
      JSON.parse(content)
    end

    def response_json(return_str)
      {
        msg_signature: signature(return_str),
        encrypt: encrypt(return_str),
        timeStamp: timestamp,
        nonce: nonce
      }
    end

    def encrypt(return_str)
      encrypt = Dingtalk::Prpcrypt.encrypt(aes_key, return_str, Dingtalk.suite_key)
    end

    def signature(return_str)
      sort_params = [suite.suite_access_token, timestamp, nonce, encrypt(return_str)].sort.join
      Digest::SHA1.hexdigest(sort_params)
    end

    def suite
      Api::Suite.new
    end

    def department
      Api::Department.new(@corp_id)
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
