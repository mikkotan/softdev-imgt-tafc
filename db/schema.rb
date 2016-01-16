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

ActiveRecord::Schema.define(version: 20160116124344) do

  create_table "clients", force: :cascade do |t|
    t.string   "company_name"
    t.string   "owner"
    t.string   "representative"
    t.text     "address"
    t.string   "tel_num"
    t.string   "email"
    t.string   "tin_num"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "clients", ["user_id"], name: "index_clients_on_user_id"

  create_table "provisional_receipts", force: :cascade do |t|
    t.integer  "transaction_id"
    t.text     "paid_items"
    t.float    "amount_paid"
    t.string   "receipt_no"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "provisional_receipts", ["transaction_id"], name: "index_provisional_receipts_on_transaction_id"

  create_table "related_costs", force: :cascade do |t|
    t.string   "nature"
    t.float    "value"
    t.integer  "service_id"
    t.boolean  "is_template", default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "related_costs", ["service_id"], name: "index_related_costs_on_service_id"

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.float    "monthly_fee"
    t.string   "service_type",   default: "none"
    t.boolean  "is_template",    default: true
    t.integer  "transaction_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "services", ["transaction_id"], name: "index_services_on_transaction_id"

  create_table "transactions", force: :cascade do |t|
    t.string   "billing_num"
    t.float    "retainers_fee"
    t.float    "vat"
    t.float    "percentage"
    t.float    "withholding_1601c"
    t.float    "withholding_1601e"
    t.float    "employee_benefit_sss"
    t.float    "employee_benefit_philhealth"
    t.float    "employee_benefit_pag_ibig"
    t.integer  "client_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "transactions", ["client_id"], name: "index_transactions_on_client_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "role"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
