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
