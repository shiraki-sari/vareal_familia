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

    # 仮想フィールド
    # MEMO: after(:create)も定義しないと使えない
    transient do
      password { '1234567890' }
    end

    # create(:user)時のコールバック
    # MEMO: 仮想フィールドの値をテストで使う時は、after(:create)も定義が必要
    after(:create) do |user, evaluator|
      # create(:user, password: 'any password')なら'any password'を代入
      # create(:user)ならデフォルト値のまま
      user.password ||= evaluator.password
    end

    # create(:user)するときにバリデーションをスキップ
    # MEMO: テストでは、create(:user, :skip_validate)のように書く
    trait :skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
