require 'rails_helper'

describe CreateComment::CheckProhibitedWords do

  before do
    @service = CreateComment::CheckProhibitedWords.build
  end

  it "raises exception if title contains at least two prohibited words" do
    title = "bad boring movie"
    expect { @service.call(title) }.
      to raise_error(CreateComment::CheckProhibitedWords::ProhibitedWordError)
  end

  it "does not raise if title contains one prohibited word" do
    title = "cheap but interesting movie"
    expect { @service.call(title) }.not_to raise_error
  end
end
