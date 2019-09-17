module Dingtalk
  class Corp
    attr_accessor :corp_id, :isv_mode, :corp_secret

    def initialize(corp_id)
      @corp_id = corp_id
      @isv_mode = false
      @corp_secret = ''
    end
  end
end