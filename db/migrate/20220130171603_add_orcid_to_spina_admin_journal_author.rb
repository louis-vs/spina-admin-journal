# frozen_string_literal: true

class AddOrcidToSpinaAdminJournalAuthor < ActiveRecord::Migration[7.0] # :nodoc:
  def change
    add_column :spina_admin_journal_authors, :orcid, :string, null: false, default: ''
  end
end
