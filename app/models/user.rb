# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8 }

  normalizes :email, with: ->(e) { e.strip.downcase }

  has_many :sessions, dependent: :destroy

  after_create :create_default_team

  private

  def create_default_team
    Team.create!(owner: self, name: default_team_name)

    # TODO: team_users作成後以下に変更
    # team = teams.new(owner: self, name: default_team_name)
    # team.team_users.new(user: self)
    # team.save!
  end

  def default_team_name
    "#{email.split("@").first}'s team"
  end
end
