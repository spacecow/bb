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

ActiveRecord::Schema.define(:version => 20130125043330) do

  create_table "familiars", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "sales_count", :default => 0
    t.string   "image"
    t.integer  "maxhp"
    t.integer  "maxatk"
    t.integer  "maxdef"
    t.integer  "maxwis"
    t.integer  "maxagi"
  end

  create_table "familiars_skills", :force => true do |t|
    t.integer  "familiar_id"
    t.integer  "skill_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sales", :force => true do |t|
    t.integer  "familiar_id"
    t.float    "value"
    t.integer  "unit_mask"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "note"
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "kind"
    t.float    "modifier",    :default => 0.0
    t.string   "status"
    t.string   "target"
  end

end
