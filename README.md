# ZapierRestHooks
[![Gem Version](https://badge.fury.io/rb/zapier_rest_hooks.svg)](https://badge.fury.io/rb/zapier_rest_hooks) [![Build Status](https://travis-ci.org/esbanarango/zapier-REST-hooks.svg?branch=master)](https://travis-ci.org/esbanarango/zapier-REST-hooks) [![Code Climate](https://codeclimate.com/github/esbanarango/zapier-REST-hooks/badges/gpa.svg)](https://codeclimate.com/github/esbanarango/zapier-REST-hooks) [![Test Coverage](https://codeclimate.com/github/esbanarango/zapier-REST-hooks/badges/coverage.svg)](https://codeclimate.com/github/esbanarango/zapier-REST-hooks/coverage)

Rails engine that provides functionality for [Zapier REST hooks pattern](https://zapier.com/developer/documentation/v2/rest-hooks/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zapier_rest_hooks'
```

After you've added _ZapierRestHooks_ to your gemfile, you can install it with:

````bash
rails generate zapier_rest_hooks:install
````

The generator will mount ZapierRestHooks in your config/routes.rb at the path `/hooks`.

Now run `rake db:migrate`

## Usage

By adding __ZapierRestHooks__ engine to your Rails app, you will have access to [ZapierRestHooks::Hook](https://github.com/esbanarango/zapier-REST-hooks/blob/master/app/models/zapier_rest_hooks/hook.rb) model. This model maps the Hook object described on [Zapier REST Hooks pattern](https://zapier.com/developer/documentation/v2/rest-hooks/#rest-hooks).

Here's an example on how you can integrate _hooks_ into your existing models.

###### Note:
This is simple example, in real life you should wrap `ZapierRestHooks::Hook.trigger` inside a Job.

A hook can be scoped to an owner. By default it's _nil_ but you can specify it if you need it.

````ruby
class Candidate < ActiveRecord::Base
  # Relations
  belongs_to :organization

  # Callbacks
  after_create :trigger_hooks_with_owner, if: :organization
  after_create :trigger_hooks_without_owner, unless: :organization

  private

  def trigger_hooks_with_owner
    return unless ZapierRestHooks::Hook.hooks_exist?('new_candidate', organization)
    # Scoped event.
    ZapierRestHooks::Hook.trigger('new_candidate', self.to_json, organization)
  end

  def trigger_hooks_without_owner
    return unless ZapierRestHooks::Hook.hooks_exist?('new_candidate')
    # Global event.
    ZapierRestHooks::Hook.trigger('new_candidate', self.to_json)
  end
end
````

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/esbanarango/zapier-REST-hooks. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## Author

This was written by [Esteban Arango Medina](http://esbanarango.com), based on [Ryan Alyn Porter](https://github.com/endymion) initial solution.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

