class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :article

  # Validations
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :article_id, presence: true, numericality: { only_integer: true }
end
