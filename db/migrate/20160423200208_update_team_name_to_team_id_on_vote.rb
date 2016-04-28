class UpdateTeamNameToTeamIdOnVote < ActiveRecord::Migration
  def up
    add_column :votes, :team_id, :integer, null: false

    data_migration_sql = <<-EOSQL
      update votes
        set team_id=teams.id
        from teams
        where teams.name = votes.team_name
    EOSQL

    ActiveRecord::Base.connection.execute data_migration_sql

    remove_column :votes, :team_name
  end

  def down
    add_column :votes, :team_name, :string, null: false

    data_migration_sql = <<-EOSQL
      update votes
        set team_name=teams.name
        from teams
        where teams.id = votes.team_id
    EOSQL

    ActiveRecord::Base.connection.execute data_migration_sql

    remove_column :votes, :team_id

  end

end
