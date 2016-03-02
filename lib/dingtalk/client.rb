module Dingtalk
  class Client
    attr_accessor :corp_id

    def initialize(corp_id)
      @corp_id = corp_id
    end

    def decrypt(echo_str)
      aes_key = Base64.decode64(Dingtalk.suite_aes_key + '=')
      content, status = Dingtalk::Prpcrypt.decrypt(aes_key, echo_str, Dingtalk.suite_key)
      # TODO check status
      JSON.parse(content)
    end

    def suite
      Api::Suite.new
    end

    def department
      Api::Department.new(@corp_id)
    end
  end
end
