class AddCoordinatesToSpas < ActiveRecord::Migration[7.1]
  def change
    add_column :spas, :latitude, :float
    add_column :spas, :longitude, :float
  end
end
