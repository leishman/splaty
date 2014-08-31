require 'rails_helper'

RSpec.describe Wall, :type => :model do
  it { should validate_uniqueness_of :path }
end
