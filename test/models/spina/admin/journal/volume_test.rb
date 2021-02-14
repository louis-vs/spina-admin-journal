# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Journal
      class VolumeTest < ActiveSupport::TestCase
        setup do
          @volume = spina_admin_journal_volumes :vol1
          @new_volume = Volume.new
        end

        test 'volume has associated issues' do
          assert_not_nil @volume.issues
          assert @new_volume.issues.empty?
        end

        test 'number should not be empty' do
          assert @volume.valid?
          assert_empty @volume.errors[:number]
          @volume.number = nil
          assert @volume.invalid?
          assert_not_empty @volume.errors[:number]
        end

        test 'number should be unique per journal' do
          assert @volume.valid?
          assert_empty @volume.errors[:number]
          @volume.number = 2
          assert @volume.invalid?
          assert_not_empty @volume.errors[:number]
        end

        test 'should destroy dependent issues when destroyed' do
          assert_difference 'Issue.count', -1 * Issue.where(volume_id: @volume.id).count do
            @volume.destroy
          end
          assert_empty @volume.errors[:base]
        end
      end
    end
  end
end
