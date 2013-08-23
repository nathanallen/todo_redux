require_relative '../../config/application.rb'

class CreateTask < ActiveRecord::Migration 
  def change 
    create_table :tasks do |t|
      t.integer :list_index
      t.string :name
      t.string :status, :default => 'incomplete'
      t.datetime :completed_at
      t.timestamps
    end
  end
end
