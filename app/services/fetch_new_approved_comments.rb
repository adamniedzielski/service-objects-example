class FetchNewApprovedComments

  def self.build
    new
  end

  def call
    Comment.where(status: 'approved').
      where(created_at: [3.days.ago .. DateTime.current]).
      limit(30)
  end
end