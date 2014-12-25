require 'rails_helper'

describe FetchNewApprovedComments do

  before do
    @service = FetchNewApprovedComments.build

    @day_ago_approved = Comment.create!(created_at: 1.day.ago, status: 'approved')
    @day_ago_awaiting = Comment.create!(created_at: 1.day.ago, status: 'awaiting')
    @week_ago_approved = Comment.create!(created_at: 1.week.ago, status: 'approved')
  end

  it "returns only approved comments" do
    result = @service.call
    expect(result).not_to include(@day_ago_awaiting)
  end

  it "returns comments from last three days" do
    result = @service.call
    expect(result).to include(@day_ago_approved)
    expect(result).not_to include(@week_ago_approved)
  end
end
