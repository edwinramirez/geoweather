class CreateWeatherLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :weather_locations do |t|
      t.string :latitude, limit: 50
      t.string :longitude, limit: 50
      t.string :weather, limit: 50
      t.string :icon, limit: 10
      t.float :temperature
      t.text :full_response

      t.timestamps
    end
  end
end
