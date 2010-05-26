# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100526152448) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email",                               :default => "", :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "role"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "fb_token"
    t.integer  "fb_id"
    t.string   "gender"
    t.string   "encrypted_password",   :limit => 128, :default => ""
    t.string   "password_salt",                       :default => ""
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "invitation_token",     :limit => 20
    t.datetime "invitation_sent_at"
  end

  add_index "accounts", ["invitation_token"], :name => "index_accounts_on_invitation_token"

  create_table "admins", :force => true do |t|
    t.string   "email",                             :default => "", :null => false
    t.string   "encrypted_password", :limit => 128, :default => "", :null => false
    t.string   "password_salt",                     :default => "", :null => false
    t.integer  "sign_in_count",                     :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                   :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "avatars", :force => true do |t|
    t.integer  "user_id"
    t.integer  "shirt_id"
    t.integer  "short_id"
    t.integer  "snicker_id"
    t.integer  "shirt_rotation"
    t.integer  "short_rotation"
    t.integer  "snicker_rotation"
    t.integer  "shirt_scale"
    t.integer  "short_scale"
    t.integer  "snicker_scale"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.string   "title"
    t.text     "content"
    t.string   "email"
    t.string   "user_id"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string "name"
  end

  create_table "groups", :force => true do |t|
    t.string "name"
  end

  create_table "matches", :force => true do |t|
    t.integer  "number"
    t.datetime "played_at"
    t.string   "place"
    t.integer  "stadium_id"
    t.integer  "first_team_id"
    t.integer  "second_team_id"
    t.integer  "first_team_goals"
    t.integer  "second_team_goals"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

  create_table "places", :force => true do |t|
    t.string "name"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.datetime "born_at"
    t.string   "country"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bio"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  create_table "predictions", :force => true do |t|
    t.integer  "user_id"
    t.datetime "predicted_at"
    t.integer  "match_id"
    t.integer  "winner_id"
    t.integer  "first_team_result"
    t.integer  "second_team_result"
    t.integer  "scoring_player_id"
    t.integer  "victory_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shirts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shorts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "snickers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stadia", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bio"
    t.integer  "country_id"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bio"
    t.integer  "country_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
