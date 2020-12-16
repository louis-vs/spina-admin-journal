# frozen_string_literal: true

class CreateSpinaAdminJournalAuthorships < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    create_table :spina_admin_journal_authorships do |t|
      t.references :article, null: false, foreign_key: { to_table: :spina_admin_journal_articles }
      t.references :author_name, null: false, foreign_key: { to_table: :spina_admin_journal_author_names }
      t.index %i[article_id author_name_id], unique: true, name: :index_authorships_on_article_id_and_author_name_id
      t.index %i[author_name_id article_id], unique: true, name: :index_authorships_on_author_name_id_and_article_id

      t.timestamps
    end
  end
end
