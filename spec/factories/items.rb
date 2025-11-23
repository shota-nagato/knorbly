# == Schema Information
#
# Table name: items
#
#  id           :bigint           not null, primary key
#  image_url    :string
#  published_at :datetime
#  summary      :string
#  title        :string           not null
#  url          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  source_id    :bigint
#
# Indexes
#
#  index_items_on_source_id  (source_id)
#
FactoryBot.define do
  factory :item do
    association :source
    title { "テスト用記事" }
    sequence(:url) { |n| "http://example.com/articles/#{n}" }
  end
end
