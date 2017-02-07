# mymodule

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with mymodule](#setup)
    * [Creating a module from scratchWhat mymodule affects](#creating-a-module-from-scratch)
    * [Configuring rspec-puppet on an existing module](#configuring-rspec-puppet-on-an-existing-module)
    * [Writing rspec-puppet tests](#writing-rspec-puppet-tests)
    * [Using puppet-retrospec to generate tests automatically](#using-puppet-retrospec-to-generate-tests-automatically)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Start with a one- or two-sentence summary of what the module does and/or what
problem it solves. This is your 30-second elevator pitch for your module.
Consider including OS/Puppet version it works with.

You can give more descriptive information in a second paragraph. This paragraph
should answer the questions: "What does this module *do*?" and "Why would I use
it?" If your module has a range of functionality (installation, configuration,
management, etc.), this is the time to mention it.

## Setup

You may wish to customize the rspec output by creating a `.rspec` file in the
top level of the module or your $HOME directory.

```
$ cat .rspec
--format documentation
--color
```

### Creating a module from scratch

When you use `puppet module generate <userid>-<modulename>` to
start a new module, everything you need for rspec-puppet is
pre-configured!

```
bundle exec puppet module generate jerej-mymodule
cd mymodule
bundle install --path .bundle/gems
bundle exec rake -T
bundle exec rake spec

echo “.bundle” >> .gitignore
git add --all
git remote add origin https://github.com/jerej/puppet-mymodule.git
git commit -m "Initial module creation"
git push --set-upstream origin master

bundle exec rake spec
Cloning into 'spec/fixtures/modules/stdlib'...
remote: Counting objects: 9302, done.
remote: Total 9302 (delta 0), reused 0 (delta 0), pack-reused 9302
Receiving objects: 100% (9302/9302), 1.87 MiB | 0 bytes/s, done.
Resolving deltas: 100% (4475/4475), done.
Checking connectivity... done.
HEAD is now at 1ffd72d Merge branch 'puppetlabs-release/four_one_oh'
/Users/jere/.rvm/rubies/ruby-2.3.1/bin/ruby -I/Users/jere/rpug/mymodule/.bundle/gems/ruby/2.3.0/gems/rspec-core-3.5.4/lib:/Users/jere/rpug/mymodule/.bundle/gems/ruby/2.3.0/gems/rspec-support-3.5.0/lib /Users/jere/rpug/mymodule/.bundle/gems/ruby/2.3.0/gems/rspec-core-3.5.4/exe/rspec --pattern spec/\{aliases,classes,defines,unit,functions,hosts,integration,types\}/\*\*/\*_spec.rb --color
.

Finished in 0.26083 seconds (files took 1.52 seconds to load)
1 example, 0 failures
```

### Configuring rspec-puppet on an existing module

example42 posted a brief setup guide for [adding rspec-puppet to an existing
module](http://www.example42.com/2017/01/30/rspec-on-existing-code/)

### Writing rspec-puppet tests

The Ruby rspec grammer is reasonably human-readable and translates well from a
business requirements doc.  This lends itself well to Test Driven Development
(TDD).  Tests are written in the form of expectations applied to a subject and
are grouped by `describe` and `context` blocks.

Example:
```
require 'spec_helper'

describe 'logrotate::rule' do
  let(:title) { 'nginx' }

  it { is_expected.to contain_class('logrotate::rule') }

  it do
    is_expected.to contain_file('/etc/logrotate.d/nginx').with({
      'ensure' => 'present',
      'owner'  => 'root',
      'group'  => 'root',
      'mode'   => '0444',
    })
  end
end
```

See the [rspec-puppet tutorial](http://rspec-puppet.com/tutorial/) and the
[matchers](http://rspec-puppet.com/matchers/) documentation for more.

### Using puppet-retrospec to generate tests automatically

[Puppet-Retrospec](https://github.com/nwops/puppet-retrospec) - “A retrospec
plugin for puppet that generates puppet rspec test code based on the current
code inside your module.”

```
git checkout master
git reset --hard origin/master
git checkout -b retrospec
echo ‘gem 'puppet-retrospec' >> Gemfile
bundle install --path .bundle/gems

# add some code to `manifests/init.pp` or another class file.
bundle exec retrospec puppet

git status; # See all the files that were touched or added
bundle exec rake spec

# Clean up the formatting a bit:
bundle exec rake rubocop:auto_correct

```

### What mymodule affects **OPTIONAL**

If it's obvious what your module touches, you can skip this section. For
example, folks can probably figure out that your mysql_instance module affects
their MySQL instances.

If there's more that they should know about, though, this is the place to mention:

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute.
* Dependencies that your module automatically installs.
* Warnings or other important notices.

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled,
etc.), mention it here.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you might want to include an additional "Upgrading" section
here.

### Beginning with mymodule

The very basic steps needed for a user to get the module up and running. This
can include setup steps, if necessary, or it can be an example of the most
basic use of the module.

## Usage

This section is where you describe how to customize, configure, and do the
fancy stuff with your module here. It's especially helpful if you include usage
examples and code samples for doing things with your module.

## Reference

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Limitations

This is where you list OS compatibility, version compatibility, etc. If there
are Known Issues, you might want to include them under their own heading here.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel
are necessary or important to include here. Please use the `## ` header.


