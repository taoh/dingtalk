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

    def suite_key
      @suite_key ||= config.suite_key
    end

    def suite_secret
      @suite_secret ||= config.suite_secret
    end

    def suite_aes_key
      @suite_aes_key ||= config.suite_aes_key
    end

    def suite_token
      @suite_token ||= config.suite_token
    end

    def sns_app_id
      @sns_app_id ||= config.sns_app_id
    end

    def sns_app_secret
      @sns_app_secret ||= config.sns_app_secret
    end
  end

  class Config
    attr_accessor :redis, :redis_prefix, :redis_options, :suite_key, :suite_secret, :suite_aes_key, :suite_token, :sns_app_id, :sns_app_secret
  end
end
