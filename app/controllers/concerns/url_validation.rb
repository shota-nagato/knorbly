module UrlValidation
  extend ActiveSupport::Concern

  private

  def valid_url?(url)
    return false if url.blank?

    URI::DEFAULT_PARSER.make_regexp.match?(url)
  end
end
