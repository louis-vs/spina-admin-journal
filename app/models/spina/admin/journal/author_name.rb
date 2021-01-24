# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Record for the names and corresponding affiliations of authors.
      #
      # This is the record that is associated with Articles themselves.
      # An AuthorName is associated with a particular author and a particular institution
      # (via an affiliation).
      #
      # - Validators
      # Presence:: {#name}
      class AuthorName < ApplicationRecord
        # @!attribute [rw] first_name
        #   @return [String] the first name(s) of the author
        # @!attribute [rw] surname
        #   @return [String] the last name(s) of the author
        # @!attribute [rw] author
        #   @return [ActiveRecord::Relation] the author of whom this is a(/the) name
        belongs_to :author

        # @!attribute [rw] authorships
        #   @return [ActiveRecord::Relation] directly associated authorships
        #   @note an AuthorName cannot be deleted if it has dependent authorships.
        #         This scenario must be handled in deletion code, for instance by
        #         automatically reassigning authors or by prompting the user.
        has_many :authorships, dependent: :restrict_with_error
        # @!attribute [rw] articles
        #   @return [ActiveRecord::Relation] articles associated through authorships
        has_many :articles, through: :authorships

        # @!attribute [rw] affiliations
        #   @return [ActiveRecord::Relation] directly associated affiliations
        has_many :affiliations, dependent: :destroy
        # @!attribute [rw] institutions
        #   @return [ActiveRecord::Relation] the institutions corresponding to this AuthorName's affiliations
        has_many :institutions, through: :affiliations

        validates :first_name, presence: true
        validates :surname, presence: true

        def name
          "#{first_name} #{surname}"
        end

        def reversed_name
          "#{surname}, #{first_name}"
        end
      end
    end
  end
end
