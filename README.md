[![Chatrealm IRC][irc-chatrealm-badge]][irc-chatrealm-link]
[![Support tinnvec][support-tinnvec-badge]][support-tinnvec-link]

# cinch-strawpoll
Strawpoll plugin for Cinch. http://strawpoll.me

## Installation

In your `Gemfile`
```Ruby
gem 'cinch-strawpoll'
```

Don't forget to `bundle install`
```Shell
bundle install
```

Add to your bot config
```Ruby
require 'cinch'
require 'cinch/plugins/strawpoll'
...
bot = Cinch::Bot.new do
  configure do |c|
    ...
    c.plugins.plugins = [
      ...
      Cinch::Plugins::Strawpoll
    ]
    c.plugins.options = {
      ...
      Cinch::Plugins::Strawpoll => {
        repeat_time:    60, # Seconds to wait between poll notifications
        repeat_count:   3   # Total number of poll notifications
      }
    }
  end
end
```

## Usage
```IRC
!poll <title> | <option>, <option>
```
Request a strawpoll using `<title>` and a minimum of 2 `<option>` separated by commas.

Announcements will be made `repeat_count` times, one every `repeat_time` seconds.

[irc-chatrealm-link]: http://irc.chatrealm.net
[irc-chatrealm-badge]: https://img.shields.io/badge/irc-chatrealm-orange.svg?style=flat-square

[support-tinnvec-link]: http://tinnvec.com/support
[support-tinnvec-badge]: https://img.shields.io/badge/Support-tinnvec-blue.svg?style=flat-square
