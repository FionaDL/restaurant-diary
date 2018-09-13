class ChangeColumnType < ActiveRecord::Migration[5.2]
  def change
    change_column :visited_restaurants, :rating, :string
  end
end
