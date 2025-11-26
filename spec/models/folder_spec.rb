# == Schema Information
#
# Table name: folders
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  position   :integer          default(0), not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  team_id    :bigint           not null
#
# Indexes
#
#  index_folders_on_team_id               (team_id)
#  index_folders_on_team_id_and_position  (team_id,position) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe "factory" do
    subject { build(:folder) }

    it "レコードを新規作成できる" do
      expect(subject).to be_valid
    end
  end

  describe "slug" do
    let(:team) { create(:team) }

    before do
      create(:folder, name: "folder name", team:)
    end

    context "同チームで同じ名前のフォルダを作成した場合" do
      it "slugに連番が振られる" do
        folder = create(:folder, name: "folder name", team:)
        expect(folder.slug).to eq("folder-name2")
      end
    end

    context "別チームで同じ名前のフォルダを作成した場合" do
      it "slugに連番が振られない" do
        folder = create(:folder, name: "folder name")
        expect(folder.slug).to eq("folder-name")
      end
    end
  end
end
