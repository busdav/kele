require 'httparty'
require 'pp'
# require 'rest_client'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(e, p)
    @auth = {email: e, password: p}
    response = self.class.post('/sessions', body: @auth)
    @auth_token = response['auth_token']
    pp @auth_token
    raise "This is an invalid username and/or password" if @auth_token.nil?
  end
end
