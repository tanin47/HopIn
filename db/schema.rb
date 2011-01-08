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

ActiveRecord::Schema.define(:version => 0) do

  create_table "buses", :force => true do |t|
    t.string   "name",                                  :null => false
    t.string   "thumbnail_path",  :default => "",       :null => false
    t.text     "why",                                   :null => false
    t.float    "amount",                                :null => false
    t.integer  "capacity",                              :null => false
    t.integer  "parent_bus_id",   :default => 0,        :null => false
    t.integer  "facebook_id",                           :null => false
    t.datetime "deadline"
    t.string   "currency_code",                         :null => false
    t.integer  "hops",            :default => 0,        :null => false
    t.string   "status",          :default => "ACTIVE", :null => false
    t.string   "preapproval_key", :default => "",       :null => false
    t.float    "donated_amount",                        :null => false
    t.datetime "created_date",                          :null => false
  end

  create_table "charities", :force => true do |t|
    t.string "name",          :null => false
    t.string "desc"
    t.string "thumbnail_pic"
    t.string "paypal_id"
    t.string "url"
  end

  create_table "currencies", :force => true do |t|
    t.string  "name"
    t.string  "format"
    t.string  "sign"
    t.string  "separator"
    t.string  "delimiter"
    t.string  "paypal_currency_code"
    t.integer "minimum"
  end

  create_table "error_logs", :force => true do |t|
    t.datetime "time",        :null => false
    t.string   "ip_address"
    t.string   "identifier",  :null => false
    t.text     "description", :null => false
  end

  create_table "facebook_caches", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "gender",       :null => false
    t.datetime "updated_date", :null => false
    t.string   "facebook_id",  :null => false
  end

  add_index "facebook_caches", ["facebook_id"], :name => "facebook_id", :unique => true

  create_table "facebook_friend_caches", :force => true do |t|
    t.string   "facebook_id",  :null => false
    t.text     "friends",      :null => false
    t.datetime "updated_date", :null => false
  end

  add_index "facebook_friend_caches", ["facebook_id"], :name => "facebook_id", :unique => true

  create_table "hops", :force => true do |t|
    t.integer  "facebook_id",  :null => false
    t.integer  "bus_id",       :null => false
    t.text     "comment",      :null => false
    t.float    "amount",       :null => false
    t.datetime "created_date", :null => false
  end

  create_table "paypal_ipns", :force => true do |t|
    t.datetime "created_date",         :null => false
    t.string   "remote_host",          :null => false
    t.integer  "buy_offer_id",         :null => false
    t.string   "status",               :null => false
    t.string   "receiver_email"
    t.string   "receiver_id"
    t.string   "residence_country"
    t.string   "test_ipn"
    t.string   "transaction_subject"
    t.string   "txn_id"
    t.string   "txn_type"
    t.string   "payer_email"
    t.string   "payer_id"
    t.string   "payer_status"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address_city"
    t.string   "address_country"
    t.string   "address_country_code"
    t.string   "address_name"
    t.string   "address_state"
    t.string   "address_status"
    t.string   "address_street"
    t.string   "address_zip"
    t.string   "invoice"
    t.string   "mc_gross"
    t.string   "mc_currency"
    t.string   "payment_date"
    t.string   "payment_status"
    t.string   "payment_type"
    t.text     "raw",                  :null => false
  end

end
