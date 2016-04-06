class TypeOfService < ActiveRecord::Base
  validates :description, :standart_kms, :standart_days, :sms_model, :user_id, presence: true
end
