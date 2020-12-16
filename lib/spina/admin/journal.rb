# frozen_string_literal: true

require 'spina'
require 'spina/admin/journal/engine'
require 'rails-i18n'

module Spina
  module Admin
    module Journal
      def self.table_name_prefix
        'spina_admin_journal_'
      end
    end
  end
end
