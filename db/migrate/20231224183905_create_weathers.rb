class CreateWeathers < ActiveRecord::Migration[6.0]
  def change
    create_table :weathers do |t|
      t.float :temperature, null: false
      t.datetime :observation_time, null: false

      t.timestamps
    end
  end
end
