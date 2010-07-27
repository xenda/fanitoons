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

ActiveRecord::Schema.define(:version => 20100727035942) do

  create_table "abuses", :force => true do |t|
    t.string   "email"
    t.string   "title"
    t.string   "referer"
    t.string   "description"
    t.boolean  "confirmed",     :default => false
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
  end

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email",                                 :default => "", :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "role"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "fb_token"
    t.string   "fb_id"
    t.string   "gender"
    t.string   "encrypted_password",     :limit => 128, :default => ""
    t.string   "password_salt",                         :default => ""
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "invitation_token",       :limit => 20
    t.datetime "invitation_sent_at"
    t.date     "birth_date"
    t.integer  "title"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
  end

  add_index "accounts", ["invitation_token"], :name => "index_accounts_on_invitation_token"

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["item_type", "item_id"], :name => "index_activities_on_item_type_and_item_id"

  create_table "admins", :force => true do |t|
    t.string   "email",                              :default => "", :null => false
    t.string   "encrypted_password",  :limit => 128, :default => "", :null => false
    t.string   "password_salt",                      :default => "", :null => false
    t.integer  "sign_in_count",                      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                    :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_created_at"
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

  create_table "badges", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "championship_teams", :force => true do |t|
    t.integer  "team_id"
    t.integer  "championship_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "championships", :force => true do |t|
    t.string   "name"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.text     "description"
    t.string   "place"
    t.integer  "winner_id"
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
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "name"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "iso_name"
  end

  create_table "favorite_teams", :force => true do |t|
    t.integer  "team_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "folders", :force => true do |t|
    t.string   "name"
    t.integer  "account_id"
    t.boolean  "deletable",    :default => false
    t.string   "folder_type"
    t.integer  "lock_version", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friends", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "inviter_id"
    t.integer  "invited_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gangs", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "state"
    t.boolean  "private"
    t.boolean  "moderated",                        :default => false
    t.integer  "user_id"
    t.string   "activation_code",    :limit => 40
    t.datetime "activated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string  "name"
    t.integer "championship_id"
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
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "predictions_count"
    t.integer  "championship_id"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "moderator",                     :default => false
    t.string   "state"
    t.string   "activation_code", :limit => 40
    t.datetime "activated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gang_id"
  end

  create_table "message_readings", :force => true do |t|
    t.integer  "message_id"
    t.integer  "account_id"
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.string   "subject"
    t.text     "content"
    t.integer  "folder_id"
    t.boolean  "is_read",         :default => false
    t.integer  "from_account_id"
    t.integer  "to_account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "post_images", :force => true do |t|
    t.integer  "post_id"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "slug"
    t.datetime "published_at"
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

  create_table "profiles", :force => true do |t|
    t.integer  "account_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "website"
    t.string   "blog"
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shirts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "shorts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "snickers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "stadia", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bio"
    t.integer  "country_id"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "bio"
    t.integer  "country_id"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "flag_file_name"
    t.string   "flag_content_type"
    t.integer  "flag_file_size"
    t.datetime "flag_updated_at"
    t.string   "short_name"
  end

  create_table "titles", :force => true do |t|
    t.integer  "score_needed"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tolk_locales", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tolk_locales", ["name"], :name => "index_tolk_locales_on_name", :unique => true

  create_table "tolk_phrases", :force => true do |t|
    t.text     "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tolk_translations", :force => true do |t|
    t.integer  "phrase_id"
    t.integer  "locale_id"
    t.text     "text"
    t.text     "previous_text"
    t.boolean  "primary_updated", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tolk_translations", ["phrase_id", "locale_id"], :name => "index_tolk_translations_on_phrase_id_and_locale_id", :unique => true

  create_table "user_badges", :force => true do |t|
    t.integer  "user_id"
    t.integer  "badge_id"
    t.datetime "earned_at"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
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
