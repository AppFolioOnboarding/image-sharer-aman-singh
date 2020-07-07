class Feedback < ApplicationRecord
  validates :name, length: {
    minimum: 2,
    maximum: 50,
    too_short: 'must have at least %{count} characters',
    too_long: 'must have at most %{count} characters'
  }
  validates :comment, length: {
    minimum: 2,
    maximum: 500,
    too_short: 'must have at least %{count} characters',
    too_long: 'must have at most %{count} characters'
  }
end
