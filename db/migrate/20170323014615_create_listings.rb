class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
