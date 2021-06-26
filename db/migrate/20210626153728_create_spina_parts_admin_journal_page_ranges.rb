# frozen_string_literal: true

class CreateSpinaPartsAdminJournalPageRanges < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    create_table :spina_parts_admin_journal_page_ranges, &:timestamps
  end
end
