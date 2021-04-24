# frozen_string_literal: true

::Spina::Theme.register do |theme| # rubocop:disable Metrics/BlockLength
  theme.name = 'default'
  theme.title = 'Default Theme'

  theme.parts = [{
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
