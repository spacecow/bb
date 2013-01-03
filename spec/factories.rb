FactoryGirl.define do
  factory :familiar do
    sequence(:name){|n| "Factory name #{n}"}
  end

  factory :sale do
    familiar
    unit_mask 0
    value 10
  end
end
