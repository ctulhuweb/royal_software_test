FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
  end

  trait :with_shuffle_tags do
    transient do
      existing_tags {[]}
    end

    after(:create) do |company, evaluator|
      company.tags << evaluator.existing_tags.shuffle[0...5]
    end
  end
end