require 'rails_helper'

describe CommandExecutor do
  it "should raise an error if not initialized with a wall and command" do
    wall = FactoryGirl.build(:wall)
    command = nil
    expect { CommandExecutor.new(wall: wall, command: command) }.to raise_error(ArgumentError)
  end

  context "Email Command" do
    it "should send an email to the given email address" do
      wall = FactoryGirl.build(:wall)
      ce = CommandExecutor.new(wall: wall, command: '$$email leishman@splaty.com')
      ce.run!
      expect(last_email.to).to include 'leishman@splaty.com'
    end

  end
end