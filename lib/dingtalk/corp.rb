module Dingtalk
  class Corp
    attr_accessor :corp_id, :isv_mode, :corp_secret, :permanent_code

    def initialize(corp_id)
      @corp_id = corp_id
      @isv_mode = true
      @corp_secret = ''
      @permanent_code = ''
    end

    def isv_mode?
      @isv_mode
    end
  end
end