# frozen_string_literal: true

require 'uri'

module Spina
  module Admin
    module Journal
      # A simple validator for URIs
      class UriValidator < ActiveModel::EachValidator
        def validate_each(record, attribute, value)
          return if value == '' || value.nil?

          uri = URI.parse(value)

          return if uri.is_a?(URI::HTTP) && !uri.host.nil?

          record.errors.add attribute, :invalid_uri
        rescue URI::InvalidURIError
          record.errors.add attribute, :invalid_uri
        end
      end
    end
  end
end
