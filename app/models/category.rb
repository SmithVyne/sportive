class Category < ApplicationRecord
  has_many :articles

  # Validations
  validates :name, presence: true, length: { in: 3..20 }
  validates :priority, presence: true, numericality: { only_integer: true }
end
