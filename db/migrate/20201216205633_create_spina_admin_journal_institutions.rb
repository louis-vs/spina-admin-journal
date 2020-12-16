# frozen_string_literal: true

class CreateSpinaAdminJournalInstitutions < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_institutions do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
