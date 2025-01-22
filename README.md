# AnnotateModel [![Gem Version][]][gem-version]

AnnotateModel is a lightweight gem to annotate Rails models with database schema information.

[Gem Version]: https://badge.fury.io/rb/annotate_model.svg?v=2
[gem-version]: https://rubygems.org/gems/annotate_model

## Example

Here's an example of the schema information in your model file after annotation:
```ruby
# == Schema Information
#
# id         :integer         not null
# name       :string
# created_at :datetime        not null
# updated_at :datetime        not null
# ==
class Product < ApplicationRecord
end
```

```ruby
# == Schema Information
#
# id         :integer         not null
# name       :string
# email      :string
# created_at :datetime        not null
# updated_at :datetime        not null
# ==
class Admin::User < ApplicationRecord
end
```

The annotation block is re-written each time the command runs. The starting line `# == Schema Information` and the ending line `# ==` should never be changed as they are important for the regex match used to remove existing annotations.

## Installation

Add this line to the application's Gemfile:

```
group :development do
  ...
  gem "annotate_model"
```

Or install it globally:

```sh
gem install annotate_model
```

## Usage

To annotate all models, run:

`bundle exec annotate_model`

To annotate specific models, run:

`bundle exec annotate_model Product Admin::User`

## Skipping Annotation

If you want to skip annotation for a specific model, add the following skip flag to the model file:

```ruby
# == annotate_model:skip
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
