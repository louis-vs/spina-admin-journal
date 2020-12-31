# frozen_string_literal: true

class AddAuthorNameToAffiliations < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    add_reference :spina_admin_journal_affiliations, :author_name,
                  null: false, foreign_key: { to_table: :spina_admin_journal_author_names } # rubocop:disable Rails/NotNullColumn
    add_index :spina_admin_journal_affiliations, %i[author_name_id institution_id], unique: true,
                                                                                    name: :index_affiliations_on_institution_id_and_author_name_id # rubocop:disable Layout/LineLength
    add_index :spina_admin_journal_affiliations, %i[institution_id author_name_id], unique: true,
                                                                                    name: :index_affiliations_on_author_name_id_and_institution_id # rubocop:disable Layout/LineLength
  end
end
