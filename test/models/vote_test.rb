require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test 'should not vote without user_id' do
    v = Vote.new
    v.article_id = 1
    assert_not v.save, 'Saved the vote without a user_id'
  end

  test 'should not vote without article_id' do
    v = Vote.new
    v.user_id = 1
    assert_not v.save, 'Saved the vote without a article_id'
  end

  test 'should vote with article_id and user_id' do
    v = Vote.new
    v.user_id = 1
    v.article_id = 1
    assert v.save, "Didn't vote with article_id and user_id"
  end
end
