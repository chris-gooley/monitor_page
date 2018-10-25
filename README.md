# MonitorPage
A gem to view status checks of multiple services from a single page.

## Usage
Create an initializer and setup your checks. Each check should have a `pass` and an `error` call.

```ruby
MonitorPage.configure do
  check 'Sidekiq' do
    if Sidekiq::Queue.all.select{ |q| q.size > 50 }.any?
      error "Sidekiq has too many jobs"
    else
      pass
    end
  end

  check 'Passing Check' do
    pass
  end

  check 'Failing Check' do
    error "GAME OVER MAN, GAME OVER!"
  end
end
```

In your routes:
```ruby
  mount MonitorPage::Engine, at: '/monitor_page'
```

Visiting `/monitor_page` should give you something like this:
```
Sidekiq: Passed
Passing Check: Passed
Failing Check: Failed - GAME OVER MAN, GAME OVER!
-----------
Overall: Failed
```

`Overall` will always display `Passed` or `Failed` based on if all the above checks have passed or if there is a failure.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'monitor_page'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install monitor_page
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
