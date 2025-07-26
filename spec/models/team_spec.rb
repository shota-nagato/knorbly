# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
# Indexes
#
#  index_teams_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
require 'rails_helper'

RSpec.describe Team, type: :model do
  describe "factory" do
    subject { build(:team) }

    it "レコードを新規作成できる" do
      expect(subject).to be_valid
    end
  end

  describe "associations" do
    let(:team) { create(:team) }

    it "オーナーが削除されるとチームも削除される" do
      team.owner.destroy
      expect(Team.exists?(team.id)).to be_falsey
    end
  end
end
