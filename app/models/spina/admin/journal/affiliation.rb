# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Rich join between an Institution and an Author. Associated with Articles via Authorships.
      #
      # Since authors can in principle use different names in different articles, names are associated
      # with affiilations, rather than with authors directly.
      #
      # === Validators
      # Presence:: {#first_name}, {#surname}
      #
      # === Scopes
      # sorted:: sorted by surname in alphabetical order
      #
      # @see Institution
      # @see Author
      # @see Article
      # @see Authorship
      class Affiliation < ApplicationRecord
        # @!attribute [rw] first_name
        #   @return [String] the first name(s) of the author
        # @!attribute [rw] surname
        #   @return [String] the last name(s) of the author
        # @!attribute [rw] status
        #   @return [Integer] the status of the author, which can be either primary (1) or other (0)
        # @!attribute [rw] author
        #   @return [ActiveRecord::Relation] the {Author} whose affiliation this record holds
        belongs_to :author
        # @!attribute [rw] institution
        #   @return [ActiveRecord::Relation] the {Institution} to which the author is affiliated
        belongs_to :institution
        # @!attribute [rw] authorships
        #   @return [ActiveRecord::Relation] directly associated {Authorship}s
        has_many :authorships, dependent: :destroy
        # @!attribute [rw] articles
        #   @return [ActiveRecord::Relation] {Article}s associated through {Authorship}s
        has_many :articles, through: :authorships

        validates :first_name, presence: true
        validates :surname, presence: true

        enum status: { primary: 1, other: 0 }

        scope :sorted, -> { order(surname: :asc) }

        # @!attribute [r] name
        #   @return [String] The full name of the author.
        def name
          "#{first_name} #{surname}"
        end

        # @!attribute [r] reversed_name
        #   @return [String] The full name of the author, surname first.
        def reversed_name
          "#{surname}, #{first_name}"
        end
      end
    end
  end
end
