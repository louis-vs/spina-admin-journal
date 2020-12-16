# frozen_string_literal: true

class CreateSpinaAdminJournalAuthorNames < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_author_names do |t|
      t.string :name, null: false
      t.references :author, null: false, foreign_key: { to_table: :spina_admin_journal_authors }

      t.timestamps
    end
  end
end
