# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_12_213215) do
  create_table "weather_locations", force: :cascade do |t|
    t.string "latitude", limit: 50
    t.string "longitude", limit: 50
    t.string "weather", limit: 50
    t.string "icon", limit: 10
    t.float "temperature"
    t.text "full_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
