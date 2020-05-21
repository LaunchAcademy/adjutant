![Ruby](https://github.com/LaunchAcademy/adjutant/workflows/Ruby/badge.svg)

# Adjutant

![Starcraft Adjutant](http://vignette1.wikia.nocookie.net/starcraft/images/a/a4/Adjutant_SC2_Head2.jpg/revision/latest?cb=20100906202000)
Courtesy: [Starcraft Wiki](http://starcraft.wikia.com/wiki/StarCraft_Wiki)

Adjutant is a command line generator for creating new curriculum lessons. It
generates a new lesson folder, based on a supplied title, and prompts you for
tags and vimeo identifiers as applicable.

It is intended to make the process of writing a new lesson easier!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'adjutant',
  git: 'https://github.com/LaunchAcademy/adjutant'
```

And then execute:

    $ bundle

## Usage

For the most part, using the `rake` tasks present in the
[curriculum](https://github.com/launchacademy/curriculum) repo will
suffice.

```no-highlight
rake gen:article    # generate article lesson
rake gen:challenge  # generate challenge lesson
rake gen:exercise   # generate exercise lesson
rake gen:video      # generate video lesson
```

If you'd like to use the supplied `adjutant` command directly. In the your
locally cloned curriculum repository, you can execute the following:

```no-highlight
bundle exec adjutant article
bundle exec adjutant challenge
bundle exec adjutant exercise
bundle exec adjutant video
```

After executing one of the above commands, you'll be prompted to supply the
title of the lesson, the slug (or folder name of the lesson), applicable tags,
and if you're creating a video lesson, you'll be prompted to supply a vimeo id.

To demonstrate how the `rake` tasks can be utilized, please refer to the
animated gif below:

![Adjutant Usage Animated GIF](adjutant_usage.gif)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Templates

Default templates for article, challenge, exercise, and video lesson types can
be found in the `lib/templates` directory. There is also a `.lesson.json.erb`
that is used to generate the lesson metadata file for the lesson.

Templates are bound to the applicable instance context of the `LessonGenerator`
class.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/adjutant-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

