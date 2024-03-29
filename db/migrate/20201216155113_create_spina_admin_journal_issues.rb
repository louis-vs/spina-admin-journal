# frozen_string_literal: true

class CreateSpinaAdminJournalIssues < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_issues do |t|
      t.integer :number, null: false
      t.string :title, null: false, default: ''
      t.date :date, null: false
      t.references :volume, null: false, foreign_key: { to_table: :spina_admin_journal_volumes }

      t.timestamps
    end
  end
end
