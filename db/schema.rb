# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_26_081427) do

  create_table "analyses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "title", null: false
    t.text "text", null: false
    t.text "image"
    t.integer "attack", null: false
    t.integer "defensive", null: false
    t.integer "pitcher", null: false
    t.integer "comprehensive", null: false
    t.integer "expectations", null: false
    t.bigint "user_id", null: false
    t.bigint "school_id", null: false
    t.bigint "tournament_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_analyses_on_school_id"
    t.index ["tournament_id"], name: "index_analyses_on_tournament_id"
    t.index ["user_id"], name: "index_analyses_on_user_id"
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "champions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "champion_school_id", null: false
    t.bigint "tournament_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["champion_school_id"], name: "index_champions_on_champion_school_id"
    t.index ["tournament_id"], name: "index_champions_on_tournament_id"
    t.index ["user_id"], name: "index_champions_on_user_id"
  end

  create_table "comment_analyses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "analysis_id", null: false
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analysis_id"], name: "index_comment_analyses_on_analysis_id"
    t.index ["user_id"], name: "index_comment_analyses_on_user_id"
  end

  create_table "comment_forecasts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "forecast_id", null: false
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["forecast_id"], name: "index_comment_forecasts_on_forecast_id"
    t.index ["user_id"], name: "index_comment_forecasts_on_user_id"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tweet_id", null: false
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id"], name: "index_comments_on_tweet_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_entries_on_room_id"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "forecasts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text", null: false
    t.string "round", null: false
    t.integer "probability", null: false
    t.bigint "user_id", null: false
    t.bigint "win_school_id", null: false
    t.bigint "lose_school_id", null: false
    t.bigint "tournament_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lose_school_id"], name: "index_forecasts_on_lose_school_id"
    t.index ["tournament_id"], name: "index_forecasts_on_tournament_id"
    t.index ["user_id"], name: "index_forecasts_on_user_id"
    t.index ["win_school_id"], name: "index_forecasts_on_win_school_id"
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "tweet_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tweet_id"], name: "index_likes_on_tweet_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "maps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text"
    t.text "image"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.bigint "school_id", null: false
    t.bigint "tournament_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_maps_on_school_id"
    t.index ["tournament_id"], name: "index_maps_on_tournament_id"
    t.index ["user_id"], name: "index_maps_on_user_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "room_id"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "visiter_id", null: false
    t.bigint "visited_id", null: false
    t.bigint "tweet_id"
    t.bigint "analysis_id"
    t.bigint "forecast_id"
    t.bigint "room_id"
    t.bigint "message_id"
    t.bigint "comment_id"
    t.bigint "comment_analysis_id"
    t.bigint "comment_forecast_id"
    t.string "action"
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analysis_id"], name: "index_notifications_on_analysis_id"
    t.index ["comment_analysis_id"], name: "index_notifications_on_comment_analysis_id"
    t.index ["comment_forecast_id"], name: "index_notifications_on_comment_forecast_id"
    t.index ["comment_id"], name: "index_notifications_on_comment_id"
    t.index ["forecast_id"], name: "index_notifications_on_forecast_id"
    t.index ["message_id"], name: "index_notifications_on_message_id"
    t.index ["room_id"], name: "index_notifications_on_room_id"
    t.index ["tweet_id"], name: "index_notifications_on_tweet_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
    t.index ["visiter_id"], name: "index_notifications_on_visiter_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "following_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
    t.index ["following_id"], name: "index_relationships_on_following_id"
  end

  create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.string "round", null: false
    t.text "text", null: false
    t.text "image"
    t.integer "school_a_score", null: false
    t.integer "school_b_score", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "school_a_id", null: false
    t.bigint "school_b_id", null: false
    t.bigint "tournament_id", null: false
    t.bigint "user_id", null: false
    t.index ["school_a_id"], name: "index_tweets_on_school_a_id"
    t.index ["school_b_id"], name: "index_tweets_on_school_b_id"
    t.index ["tournament_id"], name: "index_tweets_on_tournament_id"
    t.index ["user_id"], name: "index_tweets_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.text "text"
    t.integer "prefecture"
    t.text "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "analyses", "categories", column: "school_id"
  add_foreign_key "analyses", "categories", column: "tournament_id"
  add_foreign_key "analyses", "users"
  add_foreign_key "champions", "categories", column: "champion_school_id"
  add_foreign_key "champions", "categories", column: "tournament_id"
  add_foreign_key "champions", "users"
  add_foreign_key "comment_analyses", "analyses"
  add_foreign_key "comment_analyses", "users"
  add_foreign_key "comment_forecasts", "forecasts"
  add_foreign_key "comment_forecasts", "users"
  add_foreign_key "comments", "tweets"
  add_foreign_key "comments", "users"
  add_foreign_key "entries", "rooms"
  add_foreign_key "entries", "users"
  add_foreign_key "forecasts", "categories", column: "lose_school_id"
  add_foreign_key "forecasts", "categories", column: "tournament_id"
  add_foreign_key "forecasts", "categories", column: "win_school_id"
  add_foreign_key "forecasts", "users"
  add_foreign_key "likes", "tweets"
  add_foreign_key "likes", "users"
  add_foreign_key "maps", "categories", column: "school_id"
  add_foreign_key "maps", "categories", column: "tournament_id"
  add_foreign_key "maps", "users"
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "analyses"
  add_foreign_key "notifications", "comment_analyses"
  add_foreign_key "notifications", "comment_forecasts"
  add_foreign_key "notifications", "comments"
  add_foreign_key "notifications", "forecasts"
  add_foreign_key "notifications", "messages"
  add_foreign_key "notifications", "rooms"
  add_foreign_key "notifications", "tweets"
  add_foreign_key "notifications", "users", column: "visited_id"
  add_foreign_key "notifications", "users", column: "visiter_id"
  add_foreign_key "tweets", "categories", column: "school_a_id"
  add_foreign_key "tweets", "categories", column: "school_b_id"
  add_foreign_key "tweets", "categories", column: "tournament_id"
  add_foreign_key "tweets", "users"
end
