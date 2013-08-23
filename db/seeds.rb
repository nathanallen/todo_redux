require_relative '../app/models/task.rb'
require 'faker'

class ToDoListImporter
  def self.import
    10.times do
      Task.create!(name: Faker::Company.catch_phrase)
    end
  end
end

