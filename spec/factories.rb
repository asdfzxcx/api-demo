FactoryGirl.define do
  factory :group_event do
    sequence(:name)         { |n| "Group event #{n}" }
    sequence(:description)  { |n| "Description of group event" }
    sequence(:location)     { |n| "Location #{n}" }
    starts_at "2016-01-13"
    sequence(:duration)     { |n| n }
  end
end
