class TypeOfServiceSerializer < ActiveModel::Serializer
  attributes :id, :description, :standart_kms, :standart_days, :sms_model
end
