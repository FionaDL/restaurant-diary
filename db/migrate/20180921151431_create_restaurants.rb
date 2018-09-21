class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table "restaurants", force: :cascade do |t|
      t.string "name"
      t.string "location"
      t.string "thoughts"
      t.string "rating"
      t.boolean "visited"
    end
  end
end
