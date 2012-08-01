class DropNotNullForLoginInUsers < ActiveRecord::Migration
  def up
    execute "ALTER TABLE users ALTER COLUMN login DROP NOT NULL"
  end

  def down
    execute "ALTER TABLE users ALTER COLUMN login SET NOT NULL"
  end
end
