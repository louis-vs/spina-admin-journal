# frozen_string_literal: true

require 'test_helper'

# fixes GitHub CI
require 'selenium-webdriver' unless self.class.const_defined? :Selenium

ActiveSupport.on_load :action_dispatch_system_test_case do
  ActionDispatch::SystemTesting::Server.silence_puma = true
end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include ::Spina::Engine.routes.url_helpers

  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 800]

  Capybara.default_max_wait_time = 5

  def authenticate
    @user = spina_users :admin

    visit spina.admin_login_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: 'password'
    click_button "Login"
    assert_selector "div", text: "Pages"
  end
end
