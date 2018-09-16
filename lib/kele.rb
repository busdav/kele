require 'httparty'
require 'json'
require 'pp'

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

  def get_me
    response = self.class.get('/users/me', headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end
end
