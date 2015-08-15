class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
    	t.integer :count
      t.string :name
      t.string :description
      t.string :price
      t.string :company
      t.integer :category_id
    	t.references :category, index: true
    	t.references :user, index: true
      t.timestamps null: false
    end
  end
end
