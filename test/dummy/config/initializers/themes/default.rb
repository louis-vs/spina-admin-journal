# frozen_string_literal: true

::Spina::Theme.register do |theme| # rubocop:disable Metrics/BlockLength
  theme.name = 'default'
  theme.title = 'Default Theme'

  theme.parts = [{
    name: 'name',
    title: 'Name',
    part_type: 'Spina::Parts::Line'
  },{
    name: 'text',
    title: 'Text',
    part_type: 'Spina::Parts::Text'
  }, {
    name: 'abstract',
    title: 'Abstract',
    part_type: 'Spina::Parts::Text'
  }, {
    name: 'attachment',
    title: 'Attachment',
    part_type: 'Spina::Parts::Attachment'
  }, {
    name: 'cover_img',
    title: 'Cover Image',
    part_type: 'Spina::Parts::Image'
  }, {
    name: 'description',
    title: 'Description',
    part_type: 'Spina::Parts::Text'
  }, {
    name: 'logo',
    title: 'Logo',
    part_type: 'Spina::Parts::Image'
  }, {
    name: 'url',
    title: 'URL',
    part_type: 'Spina::Parts::Line'
  }, {
    name: 'documents',
    title: 'Documents',
    part_type: 'Spina::Parts::Repeater',
    parts: %w[name attachment]
  }, {
    name: 'journal_abbreviation',
    title: 'Journal Abbreviation',
    part_type: 'Spina::Parts::Line',
  }]

  theme.view_templates = [{
    name: 'homepage',
    title: 'Homepage',
    parts: ['text']
  }, {
    name: 'show',
    title: 'Default',
    description: 'A simple page',
    usage: 'Use for your content',
    parts: ['text']
  }]

  theme.custom_pages = [{
    name: 'homepage',
    title: 'Homepage',
    deletable: false,
    view_template: 'homepage'
  }]

  theme.navigations = [{
    name: 'mobile',
    label: 'Mobile'
  }, {
    name: 'main',
    label: 'Main navigation',
    auto_add_pages: true
  }]
end
