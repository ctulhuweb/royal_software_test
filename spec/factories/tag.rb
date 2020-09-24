FactoryBot.define do
  factory :tag do
    name { Faker::Job.field }
  end
end