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
      set :help, '!poll <title> | <option>, <option> - Requests a straw poll using <title> and a minimum of 2 <option> separated by commas.'
    end
  end
end
