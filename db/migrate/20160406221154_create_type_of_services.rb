class CreateTypeOfServices < ActiveRecord::Migration
  def change
    create_table :type_of_services do |t|
      t.string :description
      t.integer :standart_kms
      t.integer :standart_days
      t.text :sms_model
      t.integer :user_id

      t.timestamps
    end
    add_index :type_of_services, :user_id
  end
end
