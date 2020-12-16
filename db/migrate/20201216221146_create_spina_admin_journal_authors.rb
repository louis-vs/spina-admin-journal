# frozen_string_literal: true

class CreateSpinaAdminJournalAuthors < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_authors, &:timestamps
  end
end
