# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class UriValidatable
        include ActiveModel::Validations

        attr_accessor :uri

        validates :uri, 'spina/admin/journal/uri': true
      end

      class UriValidatorTest < ActiveSupport::TestCase
        invalid_uris = %w[fail 12345h;lfg'~ http:/not\ a\ url]

        def obj
          @obj ||= UriValidatable.new
        end

        test 'should invalidate URI' do
          invalid_uris.each do |uri|
            obj.uri = uri
            assert_not obj.valid?, "URI #{uri} was not invalidated"
          end
        end

        test 'should add error for invalid URI' do
          invalid_uris.each do |uri|
            obj.uri = uri
            obj.valid?
            assert_equal I18n.t('errors.messages.invalid_uri'), obj.errors.first.message
          end
        end

        test 'should validate URI' do
          obj.uri = 'http://google.co.uk/totally/a/real/website.php'
          assert obj.valid?
        end

        test 'should validate blank URI' do
          obj.uri = ''
          assert obj.valid?
        end

        test 'should validate nil URI' do
          obj.uri = nil
          assert obj.valid?
        end
      end
    end
  end
end
