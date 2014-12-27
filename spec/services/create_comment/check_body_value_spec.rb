require 'rails_helper'

describe CreateComment::CheckBodyValue do

  before do
    @service = CreateComment::CheckBodyValue.build
  end

  it "raises exception if body contains less than three four-letter words" do
    body = "the an test body in the box"
    expect { @service.call(body) }.to raise_error(CreateComment::CheckBodyValue::LowValueError)
  end

  it "does not raise if body contains at least three four-letter words" do
    body = "long word is very good for comments"
    expect { @service.call(body) }.not_to raise_error
  end
end
