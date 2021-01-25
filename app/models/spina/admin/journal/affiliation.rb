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
        has_many :authorships, dependent: :destroy
        # @!attribute [rw] articles
        #   @return [ActiveRecord::Relation] articles associated through authorships
        has_many :articles, through: :authorships

        validates :first_name, presence: true
        validates :surname, presence: true

        enum status: { primary: 1, other: 0 }

        scope :sorted, -> { order(surname: :asc) }

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
