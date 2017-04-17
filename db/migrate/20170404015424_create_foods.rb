class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.integer :user_id
      t.string :name
      t.string :caption
      t.string :address
      t.string :picture

      t.timestamps
    end
  end
end
