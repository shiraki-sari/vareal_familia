# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  login_id        :string(30)       not null
#
FactoryBot.define do
  factory :user do
    name { 'test' }
    login_id { 'test' }
    password_digest { '$2a$12$L82rha0KRtXhtSIHIKASuegDuGTOUIcVi2B3r2vM7yOxzVM1Kp5u6' }

    trait :skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
