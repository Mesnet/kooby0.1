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

ActiveRecord::Schema.define(version: 20180501171200) do

  create_table "email_projects", force: :cascade do |t|
    t.string "email"
    t.integer "role", default: 2
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_email_projects_on_project_id"
  end

  create_table "posts", force: :cascade do |t|
    t.boolean "publish", default: false
    t.boolean "removed", default: false
    t.integer "user_id"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_posts_on_project_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cat", default: 1
    t.text "description"
    t.boolean "removed", default: false
  end

  create_table "user_emails", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.boolean "linked", default: false
    t.boolean "confirmed", default: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_emails_on_user_id"
  end

  create_table "user_infos", force: :cascade do |t|
    t.integer "user_id"
    t.string "first_name"
    t.string "second_name"
    t.string "pseudo"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_infos_on_user_id"
  end

  create_table "user_projects", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_email_id"
    t.integer "role", default: 2
    t.integer "notif", default: 0
    t.boolean "mute", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "participate", default: false
    t.integer "priority", default: 2
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false
    t.string "color"
    t.string "initial"
    t.string "name"
    t.string "surname"
    t.string "pseudo"
    t.string "phone"
    t.boolean "company"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
