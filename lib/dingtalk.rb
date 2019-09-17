require "dingtalk/version"
require "dingtalk/config"
require "dingtalk/pkcs7_encoder"
require "dingtalk/prpcrypt"
require "dingtalk/corp"
require "dingtalk/api"
require "dingtalk/client"

require 'redis'
require "rest-client"

module Dingtalk
  ENDPOINT = "https://oapi.dingtalk.com"
  # Your code goes here...
end

Dingtalk.configure do |config|
  config.suite_key = 'suiteeazsojmzckxgkw4a'
  config.suite_secret = 'blCId7p9Iy44SyNc2RviaV66-yM7bxis55T197_nIjns1JGJ0CnBSgarLT4lUGK7'
  config.suite_aes_key = 'wsuph070rt8ni8ll8yoe6ccwktz5uk94vnqtnach4zl'
  config.suite_token = 'token'
  config.redis = Redis.new
end