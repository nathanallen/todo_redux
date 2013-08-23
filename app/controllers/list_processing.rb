
class ListProcessor
  def self.renumber_list_index
    Task.all.each_with_index do |task, i|
      task.list_index = (i + 1)
      task.save!
    end
  end
end
