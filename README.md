# Vitepress::Rails

Integrate [Vitepress](https://vitepress.vuejs.org/) into your Rails application.

## When you should use this gem?

- The primary use case is for private documentation that utilizes your Rails authentication system

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vitepress-rails'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install vitepress-rails

1. Run `rails vitepress:install` to add Vitepress to your Rails application and install the necessary dependencies.

This command creates docs folder that contains the Vitepress default application.

2. Adds the following line to your `config/routes.rb` file:

```ruby
mount Vitepress::Engine, at: "/docs"
```

- ***Only works with /docs path for now***
- In your vitepress config file needs to have base: '/docs/'.

## Usage

1. Write your `.md` doc inside the `docs` folder.
2. Run `rails assets:precompile`.
3. Your page can be accessed at `/docs/<your-page-name>`

Your `/docs` path always will be `docs/index.md`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Switchdreams/vitepress-rails. This project is
intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct](https://github.com/SwitchDreams/vitepress-rails/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Vitepress::Rails project's codebases, issue trackers, chat rooms and mailing lists is
expected to follow
the [code of conduct](https://github.com/SwitchDreams/vitepress-rails/blob/master/CODE_OF_CONDUCT.md).
