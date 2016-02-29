module Dingtalk
  class << self
    attr_accessor :config

    def configure
    yield self.config ||= Config.new
    end

    def dingtalk_redis
      return nil unless self.config
      @redis ||= config.redis
    end
  end

  class Config
    attr_accessor :redis
  end
end
