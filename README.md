# cinch-strawpoll
Strawpoll plugin for Cinch. http://strawpoll.me

## Installation
In your `Gemfile`
```Ruby
gem 'cinch-strawpoll'
```
Don't forget to `bundle install`
```Shell
$ bundle install
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
        repeat_time: 60, # Seconds to wait between poll notifications
        repeat_count: 3 # Total number of poll notifications
      }
    }
  end
end
```

## Usage
```IRC
!poll <title> | <option>, <option>
```
Requests a straw poll using `<title>` and a minimum of 2 `<option>` separated by commas.

## Support
Like my code? Want to support my coffee habit? http://tinnvec.com/support
