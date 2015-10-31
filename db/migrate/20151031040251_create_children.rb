class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.datetime :date_of_birth

      t.timestamps null: false
    end
  end
end
