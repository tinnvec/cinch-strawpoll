# coding: utf-8
# file: lib/cinch/plugins/strawpoll/api.rb

require 'httparty'
require 'json'

class StrawpollApi
    include HTTParty

    base_uri 'https://strawpoll.me/api/v2'

    def create_poll(title, choices)
        response = create_poll_request(title, choices)
        return response
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
            return JSON.parse(response.body)
        end
end
