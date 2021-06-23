# frozen_string_literal: true

class CreateSpinaAdminJournalLicences < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    create_table :spina_admin_journal_licences do |t|
      t.string :name, null: false, default: 'Unnamed Licence'
      t.string :abbreviated_name, null: false, default: ''
      t.jsonb :json_attributes

      t.timestamps
    end
  end
end
