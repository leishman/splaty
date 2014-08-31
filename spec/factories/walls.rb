FactoryGirl.define do
  factory :wall do
    path 'yolo'
    text <<-eos
        I'm pasting these crazy things to this wall
        I will pay 0.0001 btc to keep this post here for a long time
    eos
  end
end