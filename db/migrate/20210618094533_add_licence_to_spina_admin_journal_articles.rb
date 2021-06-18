# frozen_string_literal: true

class AddLicenceToSpinaAdminJournalArticles < ActiveRecord::Migration[6.1] # :nodoc:
  def change
    add_reference :spina_admin_journal_articles, :licence, null: true,
                                                           foreign_key: { to_table: :spina_admin_journal_licences }
  end
end
