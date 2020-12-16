# frozen_string_literal: true

class AddAuthorToAffiliations < ActiveRecord::Migration[6.0] # :nodoc:
  def change
    add_reference :spina_admin_journal_affiliations, :author,
                  null: false, foreign_key: { to_table: :spina_admin_journal_authors } # rubocop:disable Rails/NotNullColumn
  end
end
