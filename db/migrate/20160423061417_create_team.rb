class CreateTeam < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :key
      t.string :name
      t.json :members

      t.timestamps null: false
    end
  end
end
