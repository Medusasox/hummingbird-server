require 'rails_helper'

RSpec.describe FeedCommentingBadge do
  let!(:user) { create(:user) }

  describe 'rank 1' do
    before { create(:comment, user: user) }

    it 'show rank, progress, title, description, goal' do
      badge = FeedCommentingBadge.new(user)
      expect(badge.rank).to eq(1)
      expect(badge.goal).to eq(5)
      expect(badge.progress).to eq(1)
      expect(badge.title).to eq('Smooth')
      expect(badge.description).to eq('First comment! It seems you know' \
        ' how to break the ice.')
    end

    it 'create bestowment' do
      expect(Bestowment.all.count).to eq(1)
    end
  end

  describe 'rank 2' do
    before { 5.times { create(:comment, user: user) } }

    it 'show rank, progress, title, description, goal' do
      badge = FeedCommentingBadge.new(user)
      expect(badge.rank).to eq(2)
      expect(badge.goal).to eq(50)
      expect(badge.progress).to eq(5)
      expect(badge.title).to eq('Chatterbox')
      expect(badge.description).to eq('You really know your way' \
        ' around a conversation. You\'ve already made 5 comments!')
    end
  end
end
