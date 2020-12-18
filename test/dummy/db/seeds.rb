# frozen_string_literal: true

module Spina
  Account.first_or_create name: 'MyJournal', theme: 'default'
  User.first_or_create name: 'Marcus Atherton', email: 'someone@someaddress.com', password: 'password', admin: true

  module Admin
    module Journal
      Journal.first_or_create name: 'The Best Journal',
                              description: 'Serving you the best academic content on the daily.'
    end
  end
end
