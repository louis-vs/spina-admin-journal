# frozen_string_literal: true

class CreateSpinaAdminJournalJournals < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_journals do |t|
      t.string :name, null: false, default: 'Unnamed Journal'
      t.references :logo, null: true, foreign_key: { to_table: :spina_images }
      t.integer :singleton_guard, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
