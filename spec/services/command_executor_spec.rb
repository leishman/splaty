require 'rails_helper'

describe CommandExecutor do
	it "should raise an error if not initialized with a wall and command" do
		wall = FactoryGirl.build(:wall)
		command = nil
		expect { CommandExecutor.new(wall: wall, command: command) }.to raise_error(ArgumentError)
	end
end