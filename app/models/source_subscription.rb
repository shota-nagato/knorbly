# == Schema Information
#
# Table name: source_subscriptions
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  folder_id  :bigint           not null
#  source_id  :bigint           not null
#
# Indexes
#
#  index_source_subscriptions_on_folder_id_and_source_id  (folder_id,source_id) UNIQUE
#  index_source_subscriptions_on_source_id                (source_id)
#
# Foreign Keys
#
#  fk_rails_...  (folder_id => folders.id)
#  fk_rails_...  (source_id => sources.id)
#
class SourceSubscription < ApplicationRecord
  belongs_to :source
  belongs_to :folder

  before_validation :set_default_name, on: :create

  validates :source, presence: true
  validates :folder, presence: true
  validates :source_id, uniqueness: { scope: :folder_id }

  private

  def set_default_name
    self.name = source.name
  end
end
