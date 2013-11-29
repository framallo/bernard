# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130723213923) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.boolean  "deleted"
    t.datetime "updated_at"
    t.integer  "pm_id"
    t.integer  "pm_account_type"
    t.integer  "display_order"
    t.string   "name"
    t.decimal  "balance_overall",            precision: 10, scale: 2
    t.decimal  "balance_cleared",            precision: 10, scale: 2
    t.string   "number"
    t.string   "institution"
    t.string   "phone"
    t.string   "expiration_date"
    t.string   "check_number"
    t.text     "notes"
    t.string   "pm_icon"
    t.string   "url"
    t.string   "of_x_id"
    t.string   "of_x_url"
    t.string   "password"
    t.decimal  "fee",                        precision: 10, scale: 2
    t.decimal  "fixed_percent",              precision: 10, scale: 2
    t.decimal  "limit_amount",               precision: 10, scale: 2
    t.boolean  "limit"
    t.boolean  "total_worth"
    t.decimal  "exchange_rate",              precision: 10, scale: 2
    t.string   "currency_code"
    t.datetime "last_sync_time"
    t.string   "routing_number"
    t.string   "overdraft_account_id"
    t.string   "keep_the_change_account_id"
    t.decimal  "heek_change_round_to",       precision: 10, scale: 2
    t.string   "uuid"
    t.datetime "created_at"
  end

  create_table "categories", force: true do |t|
    t.boolean  "deleted"
    t.integer  "timestamp"
    t.integer  "category_id"
    t.string   "name"
    t.integer  "pm_type"
    t.integer  "budget_period"
    t.decimal  "budget_limit",           precision: 10, scale: 2
    t.boolean  "include_sub_categories"
    t.boolean  "rollover"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.boolean  "deleted"
    t.integer  "pm_id"
    t.string   "name"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ids", force: true do |t|
    t.boolean  "deleted"
    t.integer  "id_id"
    t.string   "pm_id"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payees", force: true do |t|
    t.boolean  "deleted"
    t.integer  "timestamp"
    t.integer  "pm_id"
    t.string   "name"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payees", ["name"], name: "index_payees_on_name", unique: true, using: :btree

  create_table "splits", force: true do |t|
    t.integer "transaction_id"
    t.integer "pm_id"
    t.decimal "amount"
    t.decimal "xrate",                  precision: 10, scale: 2
    t.integer "category_id"
    t.integer "group_id"
    t.string  "memo"
    t.integer "transfer_to_account_id"
    t.string  "currency_code"
    t.string  "ofxid"
  end

  create_table "transactions", force: true do |t|
    t.integer  "pm_id"
    t.boolean  "deleted"
    t.integer  "pm_type"
    t.datetime "date"
    t.boolean  "cleared"
    t.integer  "account_id"
    t.string   "pm_payee"
    t.string   "check_number"
    t.decimal  "amount",       precision: 10, scale: 2
    t.string   "ofx_id"
    t.string   "uuid"
    t.string   "overdraft_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
