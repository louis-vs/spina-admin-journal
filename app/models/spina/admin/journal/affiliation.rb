# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Rich join between an Institution and an Author.
      # @see Institution, Author
      class Affiliation < ApplicationRecord
        # @!attribute [rw] first_name
        #   @return [String] the first name(s) of the author
        # @!attribute [rw] surname
        #   @return [String] the last name(s) of the author
        # @!attribute [rw] author_name
        #   @return [ActiveRecord::Relation] the Author whose affiliation this record holds
        belongs_to :author
        # @!attribute [rw] insttution
        #   @return [ActiveRecord::Relation] the Institution to which the author is affiliated
        belongs_to :institution
        # @!attribute [rw] authorships
        #   @return [ActiveRecord::Relation] directly associated authorships
        #   @note an Affiliation cannot be deleted if it has dependent authorships.
        #         This scenario must be handled in deletion code, for instance by
        #         automatically reassigning authors or by prompting the user.
        has_many :authorships, dependent: :restrict_with_error
        # @!attribute [rw] articles
        #   @return [ActiveRecord::Relation] articles associated through authorships
        has_many :articles, through: :authorships

        validates :first_name, presence: true
        validates :surname, presence: true

        enum status: { primary: 1, other: 0 }

        scope :sorted, -> { order(surname: :asc) }
        # Ex:- scope :active, -> {where(:active => true)}

        # @!attribute [r] name
        #   @return [String] the full name of the author
        def name
          "#{first_name} #{surname}"
        end

        # @!attribute [r] reversed name
        #   @return [String] the full name of the author, surname first
        def reversed_name
          "#{surname}, #{first_name}"
        end
      end
    end
  end
end
