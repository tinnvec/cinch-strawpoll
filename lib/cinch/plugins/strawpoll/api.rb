# coding: utf-8
# frozen_string_literal: true
# file: lib/cinch/plugins/strawpoll/api.rb

require 'httparty'
require 'json'

# Strawpoll api adapter
class StrawpollApi
  include HTTParty

  base_uri 'https://strawpoll.me/api/v2'

  def create_poll(title, choices)
    response = create_poll_request(title, choices)
    response
  end

  private

  def create_poll_request(title, choices)
    options = {
      headers: { 'Content-Type' => 'application/json' },
      body: {
        title: title, options: choices, multi: false
      }.to_json
    }
    response = self.class.post('/polls', options)
    JSON.parse(response.body)
  end
end
