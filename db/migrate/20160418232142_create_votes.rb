class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :member_email, null: false
      t.string :team_name, null: false
      t.integer :score, null: false
    end
  end
end