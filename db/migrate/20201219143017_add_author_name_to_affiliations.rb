# frozen_string_literal: true

class AddAuthorNameToAffiliations < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    add_reference :spina_admin_journal_affiliations, :author_name,
                  null: false, foreign_key: { to_table: :spina_admin_journal_author_names } # rubocop:disable Rails/NotNullColumn
  end
end
