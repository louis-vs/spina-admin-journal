module Spina
  module Admin
    module Journal
      class EmptyListComponent < ApplicationComponent
        def initialize(message: t('spina.admin.journal.empty_list'))
          @message = message
        end
      end
    end
  end
end
