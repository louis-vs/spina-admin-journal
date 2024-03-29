# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class AuthorTest < ActiveSupport::TestCase
        setup do
          @author = spina_admin_journal_authors :marcus
          @institutions = spina_admin_journal_institutions :rockbottom, :miami
          @new_author = Author.new
        end

        test 'author has associated affiliations' do
          assert_not_nil @author.affiliations
          assert @new_author.affiliations.empty?
        end

        test 'author must have at least one affiliation' do
          assert @new_author.invalid?
          attributes = {
            affiliations_attributes: [
              { first_name: 'test', surname: 'test', institution_id: @institutions[0].id, status: 'primary' }
            ]
          }
          valid_author = Author.new attributes
          assert valid_author.valid?
        end

        test 'author must have at least one primary affiliation' do
          attributes = {
            affiliations_attributes: [
              { first_name: 'test', surname: 'test', institution_id: @institutions[0].id, status: 'primary' }
            ]
          }
          valid_author = Author.new attributes
          assert valid_author.valid?
          attributes[:affiliations_attributes][0][:status] = 'other'
          invalid_author = Author.new attributes
          assert invalid_author.invalid?
        end

        test 'author must have at most one primary affiliation' do
          attributes = {
            affiliations_attributes: [
              { first_name: 'test', surname: 'test', institution_id: @institutions[0].id, status: 'primary' },
              { first_name: 'test2', surname: 'test2', institution_id: @institutions[1].id, status: 'primary' }
            ]
          }
          invalid_author = Author.new attributes
          assert invalid_author.invalid?
        end

        test 'authorship has a valid orcid' do
          assert @author.valid?
          assert_empty @author.errors[:orcid]
          @author.orcid = '0000-0001-5237-5153'
          assert @author.valid?
          assert_empty @author.errors[:orcid]
          @author.orcid = '0000-0001-5237-515X'
          assert @author.valid?
          assert_empty @author.errors[:orcid]
        end

        test 'orcid should have correct format' do
          assert @author.valid?
          assert_empty @author.errors[:orcid]
          @author.orcid = '0000-00+01-5237-5153'
          assert @author.invalid?
          assert_not_empty @author.errors[:orcid]
          @author.orcid = '0000--5237-5153'
          assert @author.invalid?
          assert_not_empty @author.errors[:orcid]
        end

        test 'orcid may be blank' do
          assert @author.valid?
          assert_empty @author.errors[:orcid]
          @author.orcid = ''
          assert @author.valid?
          assert_empty @author.errors[:orcid]
        end
      end
    end
  end
end
