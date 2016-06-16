class MixCodesUnique < ActiveRecord::Migration
  def change
    add_index :mixes, [:code], unique: true
  end
end
