require_relative '../app/models/task.rb'
require 'faker'

class ToDoListImporter
  def self.import
    10.times do |i|
      Task.create!(name: Faker::Company.catch_phrase, list_index: (i + 1))
    end
  end
end

