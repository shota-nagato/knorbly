# == Schema Information
#
# Table name: sources
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string           not null
#  rss_url     :string
#  slug        :string           not null
#  source_type :integer          default(0), not null
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :source do
    name { "Source" }
    description { "Source description" }
    sequence(:rss_url) { |n| "https://example#{n}.com/rss" }
  end
end
