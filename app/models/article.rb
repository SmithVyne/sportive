class Article < ApplicationRecord
    belongs_to :author, class_name: "User"
    belongs_to :category
    has_many :votes
    has_many :voting_users, :through => :votes

    # Validations 
    validates :title, presence: true, length: {in: 6..30}
    validates :text, presence: true, length: {minimum: 20}
    validates :image, presence: true
end
