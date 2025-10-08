require 'rails_helper'

RSpec.describe "omniauth", type: :system do
  include OmniauthHelper

  it "Googleログインができる" do
    mock_auth_hash(
      "google_oauth2",
      uid: "123456",
      email: "test@example.com",
      name: "Test User"
    )

    visit login_path

    expect do
      find('form[action="/auth/google_oauth2"]').find('button,input[type="submit"]').click
    end.to change(User, :count).by(1).and change(Team, :count).by(1)

    user = User.last
    expect(user.provider).to eq("google_oauth2")
    expect(user.name).to eq("Test User")
    expect(user.email).to eq("test@example.com")
    expect(user.teams.last.name).to eq("test's team")
  end
end
