# frozen_string_literal: true

module Spina
  module Admin
    module Journal
      class Authorship < ApplicationRecord
        belongs_to :article
        belongs_to :author_name
      end
    end
  end
end
