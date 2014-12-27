require 'rails_helper'

describe CreateComment do

  context "integration level" do

    before do
      @service = CreateComment.build
      @valid_params = {
        title: "This is a good title",
        body: "This is a high quality body with meaning"
      }
    end

    it "creates a comment in the database" do
      expect { @service.call(@valid_params) }.to change { Comment.count }.by(1)
    end

    it "assigns 'awaiting' status to comment" do
      @service.call(@valid_params)
      expect(Comment.last.status).to eq 'awaiting'
    end

    context "when title contains at least two prohibited words" do

      it "does not create a comment" do
        expect do
          params = @valid_params.merge(title: "bad cheap movie")
          @service.call(params)
        end.not_to change { Comment.count }
      end
    end

    context "when body does not have much value" do

      it "does not create a comment" do
        expect do
          params = @valid_params.merge(body: "The book is an the in box are")
          @service.call(params)
        end.not_to change { Comment.count }
      end
    end
  end

  context "unit test level" do

    it "uses CreateComment::CheckProhibitedWords" do
      check_prohibited_words = instance_double("CreateComment::CheckProhibitedWords", call: nil)
      service = CreateComment.new(check_prohibited_words, Proc.new {})
      service.call(title: "This is a title")
      expect(check_prohibited_words).to have_received(:call).with("This is a title")
    end

    it "uses CreateComment::CheckBodyValue" do
      check_body_value = instance_double("CreateComment::CheckBodyValue", call: nil)
      service = CreateComment.new(Proc.new {}, check_body_value)
      service.call(body: "This is a body")
      expect(check_body_value).to have_received(:call).with("This is a body")
    end
  end
end