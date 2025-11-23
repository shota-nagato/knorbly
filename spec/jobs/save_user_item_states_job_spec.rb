require 'rails_helper'

RSpec.describe SaveUserItemStatesJob, type: :job do
  let(:user) { create(:user) }
  let(:source) { create(:source) }

  before do
    create_list(:item, 10, source: source)
  end

  it "ユーザーごとのstatsを保存できる" do
    expect do
      SaveUserItemStatesJob.perform_now(user.teams.first, source)
    end.to change(UserItemState, :count).by(10)
  end
end
