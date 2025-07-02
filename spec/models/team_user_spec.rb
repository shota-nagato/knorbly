# == Schema Information
#
# Table name: team_users
#
#  id         :bigint           not null, primary key
#  role       :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_team_users_on_team_id  (team_id)
#  index_team_users_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe TeamUser, type: :model do
  describe "factory" do
    subject { build(:team_user) }

    it "レコードを新規作成できる" do
      expect(subject).to be_valid
    end
  end

  describe "validation" do
    let(:user) { create(:user) }

    subject { build(:team_user, team: user.teams.first, user:) }

    it "team_id, user_idが重複している場合、保存できない" do
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to eq [ "チームIDはすでに存在します" ]
    end
  end
end
