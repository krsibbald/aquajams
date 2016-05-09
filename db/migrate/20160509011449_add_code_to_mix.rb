class AddCodeToMix < ActiveRecord::Migration
  def change
    add_column :mixes, :code, :integer
    add_column :mixes, :multiple, :boolean, null: false, default: false
    add_column :mixes, :date_for_mix_list, :date
  end
end
