# BuildTasks

[![Build Status](https://travis-ci.org/Jimdo/buildtasks.svg?branch=master)](https://travis-ci.org/Jimdo/buildtasks)

Rake tasks to build Debian packages with [git-buildpackage] and [fpm-cookery].

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'buildtasks'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install buildtasks

## Usage

Require the `buildtasks` gem in a `Rakefile` and call `BuildTasks::Tool.define`,
where "Tool" is the name of the build tool you want to use (see below for a list
of options you can pass to `.define`).

This will create two Rake tasks:

* *build* -- used to build Debian package(s)
* *publish* -- used to copy built packages to directory specified by
  `PUBLISH_DIR` environment variable

Invoke the *build* task to first build the packages, e.g., inside a Vagrant
machine or Docker container. Afterwards, run the *publish* task to copy the
resulting packages to a known location, e.g., your host system via a shared
volume.

### fpm-cookery

To build packages with [fpm-cookery], create a `Rakefile` with this content:

```ruby
require "buildtasks"

BuildTasks::FPMCookery.define do
  recipe              "recipe.rb" # name of recipe file (optional)
  fpm_cookery_version "0.25.0"    # version of fpm-cookery gem to use (optional)
  fpm_version         "1.3.3"     # version of fpm gem to use (optional)
end
```

In case you don't need to configure any attributes:

```ruby
require "buildtasks"

BuildTasks::FPMCookery.define
```

Note that fpm-cookery will automatically install dependencies specified by the
`build_depends` and `depends` attributes in `recipe.rb` before building.

### git-buildpackage

To build packages with [git-buildpackage], create a `Rakefile` with this
content:

```ruby
require "buildtasks"

BuildTasks::GitBuildpackage.define do
  name        "thrift" # project name
  version     "0.9.1"  # git ref to build
  source      "https://github.com/apache/thrift" # git repository to clone
  apply_patch "patches/THRIFT-2211.patch"        # patch to apply before building (optional)
end
```

Note that all build dependencies from `debian/control` will be automatically
installed before building.

### Extending Rake tasks

`.define` generates ordinary Rake tasks, which you can extend.

For example, here's how to download some file before fpm-cookery starts
building:

```ruby
require "buildtasks"

BuildTasks::FPMCookery.define

task :download do
  sh "curl ..."
end
task :build => :download
```

## License and Authors

Author:: Mathias Lafeldt (mathias.lafeldt@jimdo.com)

Copyright:: 2014-2015, Jimdo GmbH

Licensed under the Apache 2.0 license. See [LICENSE](LICENSE) for details.

## Contributing

1. [Fork this repository](https://github.com/Jimdo/buildtasks/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


[fpm-cookery]: https://github.com/bernd/fpm-cookery
[git-buildpackage]: https://honk.sigxcpu.org/piki/projects/git-buildpackage/
