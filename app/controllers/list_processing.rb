
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

    # if completed
    #   puts "Completed task \##{list_index}!"
    # else
    #   puts "Could not locate task \##{list_index}."
    # end
    # puts ""
    ViewController.print_list
  end

end
