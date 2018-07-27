class CreateVisitedRestaurants < ActiveRecord::Migration
  def change
    create_table :visited_restaurants do |t|
      t.string :name
      t.string :location
      t.string :thougts
      t.integer :rating
      t.integer :user_id
    end
  end
end
