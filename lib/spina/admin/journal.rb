# frozen_string_literal: true

require 'haml-rails'
require 'sass-rails'
require 'jquery-rails'
require 'spina'
require 'spina/admin/journal/engine'
require 'rails-i18n'

# Spina CMS.
# @see https://www.spinacms.com Spina website
module Spina
  module Admin
    # Journal management plugin for Spina.
    module Journal
      def self.table_name_prefix
        'spina_admin_journal_'
      end
    end
  end
end
