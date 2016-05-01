class CreateCds < ActiveRecord::Migration
  def change
    create_table :cds do |t|
      t.string :name
      t.integer :code
      t.integer :time_in_sec

      t.timestamps null: false
    end
  end
end
