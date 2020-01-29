class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :image
      t.text :description
      t.integer :age
      t.integer :cost
      t.integer :user_id

      t.timestamps
    end
  end
end
