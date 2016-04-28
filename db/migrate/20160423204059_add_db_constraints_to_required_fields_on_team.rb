class AddDbConstraintsToRequiredFieldsOnTeam < ActiveRecord::Migration
  def change
    change_column :teams, :name, :string, null: false
  end
end
