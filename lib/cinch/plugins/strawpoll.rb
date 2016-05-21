require 'cinch'
require 'cinch/extensions/authentication'
require 'json'
require 'net/http'
require 'uri'

module Cinch
  module Plugins

    class Strawpoll
      include Cinch::Plugin
      include Cinch::Extensions::Authentication

      enable_authentication
      set :plugin_name, 'strawpoll'
      set :help, <<-HELP.gsub(/^ {6}/, '')
        !poll <title> | <option>, <option>
        Requests a straw poll using <title> and a minimum of 2 <option> separated by commas.
        HELP

      def initialize(*args)
        super
        @repeat_time = config[:repeat_time] || 60
        @repeat_count = config[:repeat_count] || 3
        @allow_pol = config[:allow_pol] || false
      end

      match /(poll?)\s(.+)\|(.+)/
      def execute(m, mode, title, options_string)
        return if mode == "pol" && !@allow_pol
        options = options_string.split(",").collect { |o| o = o.strip }
        options << "pol pot" if mode == "pol" && @allow_pol
        response = request_poll(title.strip, options)
        unless response['id'].nil?
          3.times do
            Channel(@bot.channels.first).send "#{Format(:white, :blue, " VOTE ")} #{title.strip} https://strawpoll.me/#{response['id']}"
            sleep 60
          end
        else
          m.user.notice "Error: #{response['error']}"
        end
      end

      private

        def request_poll(title, options)
          uri = URI('https://strawpoll.me/api/v2/polls/')
          req = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' })
          req.body = { title: title, options: options, multi: false }.to_json
          @bot.debug "Request body: #{req.body}"
          res = Net::HTTP.start(uri.host, uri.port, :use_ssl => true) { |http| http.request req }
          JSON.parse(res.body)
        end
    end

  end
end
