class Current < ActiveSupport::CurrentAttributes
  attribute :session, :team
  delegate :user, to: :session, allow_nil: true
end
