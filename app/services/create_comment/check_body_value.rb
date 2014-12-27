class CreateComment
  class CheckBodyValue

    def self.build
      new
    end

    def call(body)
      number_of_long_words = body.to_s.split.reject { |word| word.length < 4 }.size
      raise LowValueError if number_of_long_words < 3
    end

    class LowValueError < StandardError; end
  end
end
