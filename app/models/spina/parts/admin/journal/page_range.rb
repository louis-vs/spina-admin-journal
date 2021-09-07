# frozen_string_literal: true

module Spina
  module Parts
    module Admin
      module Journal
        # Part representing a range of pages
        class PageRange < Spina::Parts::Base
          attr_json :first_page, :integer
          attr_json :last_page, :integer

          validate :valid_range

          def content
            self
          end

          def valid_range
            return if first_page.nil? && last_page.nil?

            if last_page.nil?
              errors.add :last_page, 'must be present'
            elsif last_page < first_page
              errors.add :last_page, 'must be larger than the first page'
            end
          end
        end
      end
    end
  end
end
