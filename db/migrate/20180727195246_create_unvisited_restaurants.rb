class CreateUnvisitedRestaurants < ActiveRecord::Migration
  def change
    create_table :unvisited_restaurants do |t|
      t.string :name
      t.string :location
      t.integer :user_id
    end
  end
end
