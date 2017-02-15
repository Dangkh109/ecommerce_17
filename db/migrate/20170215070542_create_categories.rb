class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.integer :parent_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
