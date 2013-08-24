
class ListProcessor
  def self.renumber_list_index
    Task.all.each_with_index do |task, i|
      task.list_index = (i + 1)
      task.save!
    end
  end

  def self.complete_task(id)
    Task.where(list_index: id).each do |task|
      task.status = 'complete'
      task.completed_at = Time.now
      task.save!
    end
  end

  def self.add_task_to_list(name)
    Task.create!(name: name)
  end

  def self.delete_task(id)
    Task.where(list_index: id).destroy_all
  end
end

# ListProcessor.add_task_to_list(argv[1])
#     elsif argv[0] == "complete"
#       ListProcessor.complete_task(argv[1].to_i)
#     elsif argv[0] == "delete"
#       ListProcessor.delete_task(argv[1].to_i)
