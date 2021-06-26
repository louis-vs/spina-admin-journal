# frozen_string_literal: true

module Spina
  module Parts
    module Admin
      module Journal
        # Part representing a range of pages
        class PageRange < Spina::Parts::Base
          attr_json :first_page, :integer
          attr_json :last_page, :integer

          def content
            self
          end
        end
      end
    end
  end
end
