class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.float :salary
      t.float :rating
      t.string :type
      t.boolean :resigned, default: false
      t.integer :reporter_id
      t.timestamps
    end

    add_index :employees, :reporter_id
  end
end
