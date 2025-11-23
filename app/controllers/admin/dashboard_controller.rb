class Admin::DashboardController < Admin::ApplicationController
  def index
    @users_count = User.count
    @teams_count = Team.count
    @sources_count = Source.count
    @items_count = Item.count

    @recent_users = User.order(created_at: :desc).limit(5)
    @recent_sources = Source.order(created_at: :desc).limit(5)
  end
end
