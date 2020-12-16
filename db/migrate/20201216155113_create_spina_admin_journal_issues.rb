# frozen_string_literal: true

class CreateSpinaAdminJournalIssues < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_issues do |t|
      t.integer :number, null: false
      t.string :title, null: true
      t.date :date, null: false
      t.string :description, null: true
      t.references :volume, null: false, foreign_key: { to_table: :spina_admin_journal_volumes }
      t.references :cover_img, null: true, foreign_key: { to_table: :spina_images }

      t.timestamps
    end
  end
end
