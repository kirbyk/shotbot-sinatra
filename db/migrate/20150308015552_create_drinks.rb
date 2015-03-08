class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.string :name
      t.text :description
      t.integer :ingredient_name_1
      t.integer :ingredient_name_2
      t.integer :ingredient_name_3
      t.integer :ingredient_name_4
      t.integer :ingredient_name_5
      t.integer :ingredient_name_6
      t.integer :ingredient_name_7
      t.integer :ingredient_name_8
      t.integer :ingredient_volume_1
      t.integer :ingredient_volume_2
      t.integer :ingredient_volume_3
      t.integer :ingredient_volume_4
      t.integer :ingredient_volume_5
      t.integer :ingredient_volume_6
      t.integer :ingredient_volume_7
      t.integer :ingredient_volume_8
      t.timestamps null: false
    end
  end
end
