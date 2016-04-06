FactoryGirl.define do
  factory :type_of_service do
    description "MyString"
    standart_kms {rand() * 1000}
    standart_days {rand() * 100}
    sms_model "MyText"
    user
  end
end
