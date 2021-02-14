# Spina::Admin::Journal

![Rails tests](https://github.com/louis-vs/spina-admin-journal/workflows/Verify/badge.svg?branch=master&event=push)
[![codecov](https://codecov.io/gh/louis-vs/spina-admin-journal/branch/master/graph/badge.svg?token=9TZ9QGGLAH)](https://codecov.io/gh/louis-vs/spina-admin-journal)
[![CodeFactor](https://www.codefactor.io/repository/github/louis-vs/spina-admin-journal/badge)](https://www.codefactor.io/repository/github/louis-vs/spina-admin-journal)
[![LGTM alerts](https://img.shields.io/lgtm/alerts/g/louis-vs/spina-admin-journal.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/louis-vs/spina-admin-journal/alerts/)
[![Code quality: JavaScript](https://img.shields.io/lgtm/grade/javascript/g/louis-vs/spina-admin-journal.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/louis-vs/spina-admin-journal/context:javascript)
[![Inline docs](http://inch-ci.org/github/louis-vs/spina-admin-journal.svg?branch=master)](http://inch-ci.org/github/louis-vs/spina-admin-journal)

*Journal* is a plugin for [Spina](https://www.spinacms.com/), a content management system built in [Ruby on Rails](http://rubyonrails.org/). *Journal* augments Spina by providing an admin interface for managing an academic journal.

## Usage

The plugin adds two menus to Spina's primary navigation:

* **Journal settings** provides access to global properties of the journal. It is divided into 3 submenus:
  * **Journal** allows you to change the name of the journal.
  * **Institutions** allows you to add institutions, to which authors can be affiliated.
  * **Authors** allows you to add authors, who can then be added to articles.
* The **journal content** menu will be named after the journal as specified in Journal Settings. It provides a means of editing the content of the journal and is divided into three submenus:
  * **Volumes** allows you to add and remove volumes of the journal, and edit their respective issues.
  * **Issues** allows you to add, edit and remove issues of particular volumes of the journal, and edit their respective articles.
  * **Articles** allows you to add, edit and remove articles belonging to particular issues.

The plugin does not provide any public-facing frontend. However, an example implementation can be found at **[TBC]**.

**NB this plugin is currently a work in progress**: please wait until an official release to use this plugin in production.

## Installation

### From scratch

Make sure you have a working installation of Ruby on Rails 6.1. You can find a setup guide [here](https://guides.rubyonrails.org/getting_started.html).

Then run:

```bash
$ rails new your-app --database=postgresql
$ cd your-app
$ bin/rails db:create
$ bin/rails active_storage:install
```

Add this line to your new application's Gemfile:

```ruby
gem 'spina', '~> 1.2'
```

And then execute:

```bash
$ bundle install
```

Run the Spina install generator:

```bash
$ bin/rails g spina:install
```

And follow the prompts. Once this is complete, follow the instructions below.

### For existing Spina installations

Add this line to your application's Gemfile:

```ruby
gem 'spina-admin-journal', '~> 0.1.0'
```

And then execute:

```bash
$ bundle install
```

You'll then need to install and run the migrations for the journal:

```bash
$ bin/rails spina_admin_journal_engine:install:migrations
$ bin/rails db:migrate
```

You can then start a local server to test that everything's working.

```bash
$ bin/rails s
```

You can manually populate the database from within the app, or alternatively you can use seed data for testing. A sample `seeds.rb` file can be found [here](../master/test/dummy/db/seeds.rb).

## Contributing

Bug reports and feature requests are welcome in the [Issues](https://github.com/louis-vs/spina-admin-journal/issues) section. Translations are also very welcome!

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
