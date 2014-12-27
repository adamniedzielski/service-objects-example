class CreateComment
  class CheckProhibitedWords
    PROHIBITED_WORDS = ['bad', 'cheap', 'boring']

    def self.build
      new
    end

    def call(title)
      count = (title.to_s.split & PROHIBITED_WORDS).size
      raise ProhibitedWordError if count > 1
    end

    class ProhibitedWordError < StandardError; end
  end
end
