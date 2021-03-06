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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130627142407) do

  create_table "attachments", :force => true do |t|
    t.string   "name"
    t.string   "file"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "content_type"
    t.integer  "file_size"
    t.integer  "user_id"
    t.integer  "mandator_id"
  end

  add_index "attachments", ["attachable_id"], :name => "index_attachments_on_attachable_id"
  add_index "attachments", ["mandator_id"], :name => "index_attachments_on_mandator_id"
  add_index "attachments", ["user_id"], :name => "index_attachments_on_user_id"

  create_table "customers", :force => true do |t|
    t.integer  "mandator_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "street"
    t.integer  "postal_code"
    t.string   "city"
    t.string   "province"
    t.string   "country"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "customers", ["mandator_id"], :name => "index_customers_on_mandator_id"
  add_index "customers", ["user_id"], :name => "index_customers_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "distributors", :force => true do |t|
    t.integer  "mandator_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "street"
    t.integer  "postal_code"
    t.string   "city"
    t.string   "province"
    t.string   "country"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "distributors", ["mandator_id"], :name => "index_distributors_on_mandator_id"
  add_index "distributors", ["user_id"], :name => "index_distributors_on_user_id"

  create_table "invoice_items", :force => true do |t|
    t.integer  "invoice_id"
    t.decimal  "price",               :precision => 12, :scale => 2, :default => 0.0,   :null => false
    t.string   "currency"
    t.integer  "quantity",                                           :default => 0,     :null => false
    t.string   "name",                                                                  :null => false
    t.decimal  "tax",                 :precision => 5,  :scale => 2, :default => 0.0,   :null => false
    t.decimal  "benefit",             :precision => 12, :scale => 2, :default => 0.0,   :null => false
    t.boolean  "benefit_is_relative",                                :default => false, :null => false
    t.decimal  "net_amount",          :precision => 12, :scale => 2, :default => 0.0,   :null => false
    t.decimal  "gross_amount",        :precision => 12, :scale => 2, :default => 0.0,   :null => false
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
  end

  add_index "invoice_items", ["invoice_id"], :name => "index_invoice_items_on_invoice_id"

  create_table "invoices", :force => true do |t|
    t.integer  "mandator_id"
    t.integer  "user_id"
    t.integer  "distributor_id", :null => false
    t.integer  "customer_id",    :null => false
    t.integer  "invoice_number", :null => false
    t.date     "invoice_date",   :null => false
    t.date     "delivery_date",  :null => false
    t.date     "value_date",     :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "invoices", ["customer_id"], :name => "index_invoices_on_customer_id"
  add_index "invoices", ["distributor_id"], :name => "index_invoices_on_distributor_id"
  add_index "invoices", ["mandator_id"], :name => "index_invoices_on_mandator_id"
  add_index "invoices", ["user_id"], :name => "index_invoices_on_user_id"

  create_table "mandators", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "mandators", ["name"], :name => "index_mandators_on_name", :unique => true

  create_table "messages", :force => true do |t|
    t.string   "title",       :null => false
    t.text     "text",        :null => false
    t.integer  "mandator_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "messages", ["mandator_id"], :name => "index_messages_on_mandator_id"
  add_index "messages", ["user_id"], :name => "index_messages_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "activated",              :default => false, :null => false
    t.integer  "mandator_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["activated"], :name => "index_users_on_activated"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["mandator_id"], :name => "index_users_on_mandator_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "versions", :force => true do |t|
    t.string   "item_type",   :null => false
    t.integer  "item_id",     :null => false
    t.string   "event",       :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.integer  "mandator_id"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"
  add_index "versions", ["mandator_id"], :name => "index_versions_on_mandator_id"

end
