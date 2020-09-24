USERS_COUNT = 3
COMPANY_COUNT = 200
TAGS_COUNT = 20
CONTACTS_PER_COMPANY_COUNT = 30

users = FactoryBot.create_list(:user, USERS_COUNT)
tags = FactoryBot.create_list(:tag, TAGS_COUNT)
companies = FactoryBot.create_list(:company, COMPANY_COUNT, :with_shuffle_tags, existing_tags: tags)
companies.each do |c|
  CONTACTS_PER_COMPANY_COUNT.times {
    FactoryBot.create(:contact, company: c, user: users.shuffle.first)
  }
end