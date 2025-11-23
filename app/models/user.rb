# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
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
class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
  validates :name, length: { maximum: 20 }
  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { uid.present? }

  normalizes :email, with: ->(e) { e.strip.downcase }

  has_many :sessions, dependent: :destroy
  has_many :team_users, dependent: :destroy
  has_many :teams, through: :team_users
  has_many :owned_teams, class_name: "Team", foreign_key: :owner_id, inverse_of: :owner, dependent: :destroy
  has_many :user_item_states, dependent: :destroy
  has_many :items, through: :user_item_states
  has_many :visible_items, -> { merge(UserItemState.visible) }, through: :user_item_states, source: :item

  has_one_attached :avatar

  after_create :create_default_team

  def self.from_omniauth(auth)
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    return user if user

    existing_user = User.find_by(email: auth.info.email)

    if existing_user.present?
      existing_user.update(provider: auth.provider, uid: auth.uid)
      return existing_user
    end

    user = User.new(
      email: auth.info.email,
      name: auth.info.name,
      password: SecureRandom.hex(15),
      provider: auth.provider,
      uid: auth.uid
    )

    user.attach_avatar_from_provider(auth)
    user.save!
    user
  end

  def attach_avatar_from_provider(auth)
    return unless auth.info.image.present?

    url = auth.info.image
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)

    file = StringIO.new(response.body)
    avatar.attach(io: file, filename: File.basename(uri.path))
  end

  def avatar_string
    name.present? ? name.first.upcase : email.first.upcase
  end

  private

  def create_default_team
    team = teams.new(owner: self, name: default_team_name)
    team.team_users.new(user: self)
    team.save!
  end

  def default_team_name
    "#{email.split("@").first}'s team"
  end
end
