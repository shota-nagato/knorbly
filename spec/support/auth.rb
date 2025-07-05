module Auth
  module Test
    module IntegrationHelpers
      def sign_in(user)
        login_as user
      end

      def login_as(user)
        visit login_path

        fill_in "email", with: user.email
        fill_in "password", with: user.password

        click_button "ログインする"

        expect(page).to have_content "ログインしました"
      end
    end
  end
end

RSpec.configure do |config|
  config.include Auth::Test::IntegrationHelpers, type: :system
end
