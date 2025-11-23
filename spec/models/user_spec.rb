# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  admin           :boolean          default(FALSE)
#  email           :string           not null
#  name            :string
#  password_digest :string           not null
#  provider        :string
#  uid             :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email             (email) UNIQUE
#  index_users_on_provider_and_uid  (provider,uid) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "factory" do
    subject { build(:user) }

    it "レコードを新規作成できる" do
      expect(subject).to be_valid
    end
  end

  describe "default team" do
    it "ユーザー作成後、デフォルトのチームが作成される" do
      expect do
        create(:user)
      end.to change(Team, :count).by(1)
    end
  end
end
