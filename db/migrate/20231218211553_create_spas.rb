class CreateSpas < ActiveRecord::Migration[7.1]
  def change
    create_table :spas do |t|
      t.string :name
      t.string :address
      t.integer :price
      t.integer :rating
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
