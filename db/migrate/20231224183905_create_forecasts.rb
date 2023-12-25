class CreateForecasts < ActiveRecord::Migration[6.0]
  def change
    create_table :forecasts do |t|
      t.float :temperature, null: false
      t.datetime :observation_time, null: false

      t.timestamps
    end
  end
end
