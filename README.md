# Fixturator

Fixturator is a Rails plugin that generates fixtures from your ActiveRecord
models. It requires you to whitelist models in your `config/fixturator.yml`

**QUIRKS**

I've made `created_at` and `updated_at` always output the same time. The reason
this is part of the gem is that git diffs get really messy otherwise.

You can also exclude timestamps entirely by using the `exclude_timestamps`
setting

## Usage

There are two ways to use Fixturator. There's a rake task that it comes with,
but you can also call it yourself with a model.

#### Rake task

This gem ships with a rake task that can read a file located at
`config/fixturator.yml`

```sh
bin/rake db:fixtures:generate
```

Here's an example configuration with all valid attributes:

```yml
# Excludes created_at and updated_at on all models
exclude_timestamps: false

# The models for which fixtures are generated
models:
  - name: Driver
  - name: User
    # excluded attributes for that model
    exclude:
      - secret_attribute
      - ssn
```


#### Ruby interface

```rb
Fixturator.generate!
# Uses the config/fixturator.yml
# generates a bunch of fixtures in your configured fixture directory

Fixturator.call(User, exclude_attributes: ["created_at"])
# generates a User fixture at your configured fixture directory
# by default it's at test/fixtures/users.yml
```



## Installation
Add this line to your application's Gemfile:

```ruby
gem 'fixturator'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install fixturator
```

## Contributing
Please submit specific issue reports if you see this working in a way you
wouldn't expect. PRs and discussion is welcomed and appreciated!

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
