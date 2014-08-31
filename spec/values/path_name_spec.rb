require 'rails_helper'

describe PathName do

  ['abcd', '123142_asdlaaeADF', '12', 'an'].each do |path|
    it "should show #{path} as a valid path name" do
        path_name = PathName.new(path)
        expect(path_name.valid?).to eq true
    end
  end

  ['', '-', ' ', 'a' * 40, 'adsf%&', '&av'].each do |path|
    it "should show #{path} as an invalid path name" do
        path_name = PathName.new(path)
        expect(path_name.valid?).to eq false
    end
  end
end