require 'rails_helper'

author_id = 1
category_id = 1
title = "Hello new world"
text = "This is testing text and it should be quite long to be valid"
image = "car.png"

RSpec.describe Article, :type => :model do

    it "is valid with valid attributes" do
        article = Article.new(author_id:author_id, category_id:category_id, title:title, text:text, image:image)
        expect(article).to be_valid
    end

    it "is not valid without a title"
    
    it "is not valid without a description"
    it "is not valid without a start_date"
    it "is not valid without a end_date"
end

# article = Article.new(author_id:, category_id:, title:, text:, image:)
# article = Article.new(author_id:author_id, category_id:category_id, title:title, text:text, image:image)