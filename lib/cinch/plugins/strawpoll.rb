# coding: utf-8
# frozen_string_literal: true
# file: lib/cinch/plugins/strawpoll.rb

require 'cinch'
require 'cinch/extensions/authentication'

require_relative 'strawpoll/api'

module Cinch
  module Plugins
    # Strawpoll plugin
    class Strawpoll
      include Cinch::Plugin
      include Cinch::Extensions::Authentication

      enable_authentication

      set :plugin_name, 'strawpoll'
      set :help,  '!poll <title> | <choice>, <choice> - Request a' \
                  ' strawpoll using <title> and a minimum of 2 <choice>' \
                  ' separated by commas.'

      match(/(poll?)\s(.+)\|(.+)/)

      def initialize(*args)
        super
        @repeat_time    = config[:repeat_time]    || 60
        @repeat_count   = config[:repeat_count]   || 3
        @allow_pol      = config[:allow_pol]      || false
        @strawpoll_api = StrawpollApi.new
      end

      def execute(_m, mode, _title, choices_string)
        return if mode == 'pol' && !@allow_pol
        choices = choices_string.split(',').collect(&:strip)
        choices << 'pol pot' if mode == 'pol' && @allow_pol
        response = @strawpoll_api.create_poll(title.strip, choices)
        return if @repeat_count < 1
        do_announcements(response['id'], title, choices)
      end

      private

      def do_announcements(poll_id, title)
        if poll_id.nil?
          m.user.notice "Error: #{response['error']}"
          return
        end
        Thread.new(Channel(channel)) do |c|
          @repeat_count.times do
            c.send(format_announcement(title, poll_id))
            sleep @repeat_time
          end
        end
      end

      def format_announcement(title, poll_id)
        "#{Format(:white, :blue, ' VOTE ')}#{title.strip}" \
        " https://strawpoll.me/#{poll_id}"
      end
    end
  end
end
