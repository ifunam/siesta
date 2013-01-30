class LoadSeedToSchedules < ActiveRecord::Migration
  def up
      ['Matutino', 'Vespertino', 'Tiempo Completo'].each do |name|
          Schedule.create(:name => name)
      end
  end

  def down
  end
end
