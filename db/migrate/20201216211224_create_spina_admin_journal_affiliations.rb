# frozen_string_literal: true

class CreateSpinaAdminJournalAffiliations < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_affiliations do |t|
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.references :institution, null: false, foreign_key: { to_table: :spina_admin_journal_institutions }

      t.timestamps
    end
  end
end
