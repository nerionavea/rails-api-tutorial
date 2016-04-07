class TypeOfService < ActiveRecord::Base
  validates :description, :standart_kms, :standart_days, :sms_model, :user_id, presence: true
  validates :standart_kms, :standart_days, numericality: true
  belongs_to :user
end
