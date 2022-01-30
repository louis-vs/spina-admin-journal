# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      # Correctly styles label, description and content of form fields.
      class FormGroupComponent < ApplicationComponent
        attr_reader :label, :description

        def initialize(label:, description: '')
          @label = label
          @description = description
        end
      end
    end
  end
end
