class CreateComment

  def self.build
    new(CheckProhibitedWords.build, CheckBodyValue.build)
  end

  def initialize(check_prohibited_words, check_body_value)
    self.check_prohibited_words = check_prohibited_words
    self.check_body_value = check_body_value
  end

  def call(params)
    comment = Comment.new(params)
    comment.status = 'awaiting'
    begin
      check_prohibited_words.call(comment.title)
      check_body_value.call(comment.body)
      comment.save!
    rescue => ex
      [false, comment]
    else
      [true, comment]
    end
  end

  private
    attr_accessor :check_prohibited_words
    attr_accessor :check_body_value
end
