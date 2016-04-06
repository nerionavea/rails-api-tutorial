require 'spec_helper'

describe TypeOfService do
  let(:type_of_service){FactoryGirl.build :type_of_service}
  subject {type_of_service}

  it {should respond_to(:description)}
  it {should respond_to(:standart_kms)}
  it {should respond_to(:standart_days)}
  it {should respond_to(:sms_model)}

  it {should validate_presence_of :description}
  it {should validate_presence_of :standart_days}
  it {should validate_presence_of :standart_kms}
  it {should validate_presence_of :sms_model}
  it {should validate_presence_of :user_id}
end
