module Sluggable
  extend ActiveSupport::Concern

  included do
    class_attribute :slug_column, :slug_scope
    before_save :generate_slug
  end

  class_methods do
    def sluggable(column, scope: nil)
      self.slug_column = column
      self.slug_scope = scope
    end
  end

  def to_param
    slug
  end

  private

  def generate_slug
    source_value = send(self.class.slug_column)
    slug = if source_value.match?(/\p{Han}|\p{Hiragana}|\p{Katakana}/)
      source_value.gsub(/[[:space:]]/, "")
    else
      source_value.parameterize
    end

    slug_candidate = slug
    counter = 2

    while slug_exists?(slug_candidate)
      slug_candidate = "#{slug}#{counter}"
      counter += 1
    end

    self.slug = slug_candidate
  end

  def slug_exists?(slug_candidate)
    scope_condition = self.class.slug_scope ? { self.class.slug_scope => send(self.class.slug_scope) } : {}
    self.class.exists?(scope_condition.merge(slug: slug_candidate))
  end
end
