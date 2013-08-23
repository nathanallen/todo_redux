require_relative '../../config/application.rb'

class CreateTask < ActiveRecord::Migration 
  def change 
    create_table :tasks do |t|
      t.string :name
      t.string :status
      t.datetime :completed_at
      t.timestamps
    end
  end
end
