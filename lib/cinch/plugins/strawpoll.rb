# coding: utf-8
# file: lib/cinch/plugins/strawpoll.rb

require 'cinch'
require 'cinch/extensions/authentication'

require_relative 'strawpoll/api'

module Cinch
    module Plugins
        class Strawpoll
            include Cinch::Plugin
            include Cinch::Extensions::Authentication

            enable_authentication

            set :plugin_name, 'strawpoll'
            set :help,  '!poll <title> | <choice>, <choice> - Request a ' +
                        'strawpoll using <title> and a minimum of 2 <choice> ' +
                        'separated by commas.'

            match(/(poll?)\s(.+)\|(.+)/)

            def initialize(*args)
                super
                @repeat_time    = config[:repeat_time]    || 60
                @repeat_count   = config[:repeat_count]   || 3
                @allow_pol      = config[:allow_pol]      || false

                @strawpoll_api = StrawpollApi.new
            end

            def execute(m, mode, title, choices_string)
                return if mode == 'pol' && !@allow_pol

                choices = choices_string.split(',').collect { |o| o = o.strip }
                choices << 'pol pot' if mode == 'pol' && @allow_pol

                response = @strawpoll_api.create_poll(title.strip, choices)

                if !response['id'].nil? && @repeat_count > 0
                    Thread.new(Channel(m.channel)) do |channel|
                        @repeat_count.times do
                            announcement = Format(:white, :blue, " VOTE ")
                            announcement += " #{title.strip}"
                            announcement += " https://strawpoll.me/#{response['id']}"
                            channel.send(announcement)
                            sleep @repeat_time
                        end
                    end
                else
                    m.user.notice "Error: #{response['error']}"
                end
            end

            private
        end
    end
end
