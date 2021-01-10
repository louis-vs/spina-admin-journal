# frozen_string_literal: true

module Spina
  Account.first_or_create name: 'MyJournal', theme: 'default'
  User.first_or_create name: 'Marcus Atherton', email: 'someone@someaddress.com', password: 'password', admin: true

  module Admin
    module Journal
      Journal.first_or_create name: 'The Best Journal'
    end
  end
end
