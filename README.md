# Spina::Admin::Journal

*Journal* is a plugin for [Spina](https://www.spinacms.com/) that provides a fully-fledged journal management package, intended to provide a more streamlined, easy-to-use, modern alternative to [OJS](https://pkp.sfu.ca/ojs/).

Spina is a content management system built in [Ruby on Rails](http://rubyonrails.org/). *Journal* augments Spina by providing an admin interface for managing an academic journal.

![Rails tests](https://github.com/louis-vs/spina-admin-journal/workflows/Verify/badge.svg?branch=master&event=push)
[![codecov](https://codecov.io/gh/louis-vs/spina-admin-journal/branch/master/graph/badge.svg?token=9TZ9QGGLAH)](https://codecov.io/gh/louis-vs/spina-admin-journal)
[![CodeFactor](https://www.codefactor.io/repository/github/louis-vs/spina-admin-journal/badge)](https://www.codefactor.io/repository/github/louis-vs/spina-admin-journal)
[![LGTM alerts](https://img.shields.io/lgtm/alerts/g/louis-vs/spina-admin-journal.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/louis-vs/spina-admin-journal/alerts/)
[![Code quality: JavaScript](https://img.shields.io/lgtm/grade/javascript/g/louis-vs/spina-admin-journal.svg?logo=lgtm&logoWidth=18)](https://lgtm.com/projects/g/louis-vs/spina-admin-journal/context:javascript)
[![Inline docs](http://inch-ci.org/github/louis-vs/spina-admin-journal.svg?branch=master)](http://inch-ci.org/github/louis-vs/spina-admin-journal)

## Features

The journal plugin covers many of the needs of a professional online journal publication, including:

- Simple, responsive, intuitive interface that builds upon Spina's own.
- Seamlessly integrate published content with other information about the journal.
- Manage volumes, issues, articles and authors in a highly structured and organised manner.
- Keep track of individual authors with multiple affiliations, e.g. if they change name or institution, connecting with [ORCID](https://orcid.org/).

Currently, a submissions management system is not included, but this is planned for a future release. This will allow you to manage the submissions process for the journal in a streamlined manner in parallel to publication.

## Usage

The plugin adds two menus to Spina's primary navigation:

- **Journal settings** provides access to global properties of the journal. It is divided into 3 submenus:
  - **Journal** allows you to change metadata such as the name of the journal, as well as content that will appear on the journal homepage.
  - **Institutions** allows you to add institutions, to which authors can be affiliated.
  - **Authors** allows you to add authors and their affiliations, which can then be added to articles.
  - **Licences** allows you to add licences and association information, which can be associated with individual articles, representing the licence under which the content is released.
- The **journal content** menu will be named after the journal as specified in Journal Settings. It provides a means of editing the content of the journal and is divided into three submenus:
  - **Volumes** allows you to add and remove volumes of the journal, and edit their respective issues.
  - **Issues** allows you to add, edit and remove issues of particular volumes of the journal, and edit their respective articles.
  - **Articles** allows you to add, edit and remove articles belonging to particular issues.

**NB:** This release of the plugin does not provide any public-facing frontend or Spina theme. An example implementation can be found within the [Conferences Primer Theme](https://github.com/louis-vs/spina-conferences-primer_theme-fork). Note that this theme also contains frontends for two other Spina plugins, [Spina Conferences Blog](https://github.com/louis-vs/spina-admin-conferences-blog) and [Spina Admin Conferences](https://github.com/louis-vs/spina-admin-conferences-fork/). You can use the theme in your project as is, or copy whichever parts of the code you need.

A dedicated journal theme, coupled with an automatic installer, is being planned. A system to manage submissions is also on the roadmap.

## Installation

Make sure you have a working installation of Ruby on Rails 7. You can find a setup guide [here](https://guides.rubyonrails.org/getting_started.html).

You then need to install Spina, following the guide [on the Spina website](https://spinacms.com/docs).

To install the plugin, add this line to your application's Gemfile:

```ruby
gem 'spina-admin-journal', '~> 1.0'
```

Then execute:

```bash
$ bundle install
```

You'll then need to install and run the migrations for the journal:

```bash
$ bin/rails spina_admin_journal:install:migrations
$ bin/rails db:migrate
```

You can then start a local server to test that everything's working.

```bash
$ bin/rails s
```

You can manually populate the database from within the app, or alternatively you can use seed data for testing. A sample `seeds.rb` file can be found [here](../master/test/dummy/db/seeds.rb).

## Contributing

Bug reports and feature requests are welcome in the [Issues](https://github.com/louis-vs/spina-admin-journal/issues) section. Translations are also very welcome!

### Planned features

- [ ] Submissions management
- [ ] Translations

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
