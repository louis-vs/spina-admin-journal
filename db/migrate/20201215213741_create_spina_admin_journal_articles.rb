# frozen_string_literal: true

class CreateSpinaAdminJournalArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :spina_admin_journal_articles do |t|
      t.text :title
      t.text :abstract
      t.datetime :date

      t.timestamps
    end
  end
end
