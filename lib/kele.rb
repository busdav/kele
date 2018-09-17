require 'httparty'
require 'json'
require 'pp'
require './lib/roadmap'

class Kele
  include HTTParty
  base_uri "https://www.bloc.io/api/v1"
  include Roadmap

  def initialize(e, p)
    @auth = {"email" => e, "password" => p}
    response = self.class.post("/sessions", body: @auth)
    @auth_token = response["auth_token"]
    pp @auth_token
    raise "This is an invalid username and/or password" if @auth_token.nil?
  end

  def get_me
    response = self.class.get("/users/me", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def get_messages(pageNumber = nil)
    if pageNumber.nil?
      message_url = "/message_threads"
    else
      message_url = "/message_threads?page=#{pageNumber}"
    end
    response = self.class.get(message_url, headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def create_message(sender, recipient_id, token = nil, subject, stripped_text)
    response = self.class.post("/messages", headers: { "authorization" => @auth_token }, body: {
      "sender" => sender,
      "recipient_id" => recipient_id,
      "token" => token,
      "subject" => subject,
      "stripped_text" => stripped_text
    })
    if response.success?
      JSON.parse(response.body)
    else
      raise "Message not sent. Please try again"
    end
  end
end
