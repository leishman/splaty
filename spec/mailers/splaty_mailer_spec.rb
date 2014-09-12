require 'rails_helper'

describe SplatyMailer do
  describe "wall_copy" do
    let(:wall) { FactoryGirl.create(:wall) }
    let(:email) { 'leishman@splaty.com' }
    let(:mail) { SplatyMailer.wall_copy(wall, email) }

    it "renders the subject" do
      expect(mail.subject).to eq "Copy of Splaty - #{wall.path}"
    end

    it "renders the sender email" do
      expect(mail.from).to include 'no-reply@splaty.com'
    end

    it "renders the receiver email" do
      expect(mail.to).to include email
    end

    it "renders the wall text in the body" do
      pending 'Figure out encoding issue'
      # expect(mail.body.decoded).to include wall.text
    end
  end
end