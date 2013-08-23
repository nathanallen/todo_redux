# Run tasks directly from the command line using ARGV.
 
# Commands include:
# $ ruby todo.rb list => display list
# $ ruby todo.rb add (string) => add task to the list
# $ ruby todo.rb complete (integer) => complete task with the chosen id value
# $ ruby todo.rb delete (integer) => delete task with the chosen id value

require 'csv'


############## TASK #############

class Task

  attr_reader :name, :complete, :id, :created_at, :completed_at

  def initialize(id, name, complete="incomplete", created_at=Time.now.to_s, completed_at="incomplete")
    @id = id
    @name = name
    @complete = complete
    @created_at = created_at
    @completed_at = completed_at
  end

  def finish_task
    @complete = "complete"
    @completed_at = Time.now.to_s
  end

  def reopen_task
    @complete = "incomplete"
    @completed_at = "incomplete"
  end

  def to_s
    @name
  end
end


############## LIST #############

class List
  attr_accessor :tasks

  def initialize
    @tasks = []
  end
  
  def add(task)
    #add a task
    @tasks << task
  end
  
  def delete(task)
    @tasks = @tasks.reject { |t| t.id == task.id }
  end

  def sort_completed
    completed = @tasks.select { |task| task.complete == "complete" }
    completed.sort_by { |task| task.completed_at }.reverse
  end

  def sort_outstanding
    outstanding = @tasks.select { |task| task.complete == "incomplete" }
    outstanding.sort_by { |task| task.created_at } 
  end
end



########## CONTROLLER ###########


class Controller
  def initialize
    @list = List.new
    pull_tasks_from_csv
    evaluate_input(ARGV)
    overwrite_csv
  end

  def pull_tasks_from_csv
    index = 0
    CSV.foreach("./todo.csv") do |row|
      if row.length == 1
        index += 1
        @list.add(Task.new(index.to_s, row[0], "incomplete", Time.now.to_s))
      elsif row[0] == "id"
        @header_row = row
      else
        index += 1
        @list.add(Task.new(index.to_s, row[1], row[2], row[3], row[4]))
      end

    end
    @list.tasks
  end

  def add_task_to_list(name)
    id = @list.tasks.last.id.to_i + 1
    @list.tasks << Task.new(id, name)
    print_list
    puts "Added '#{@list.tasks.last}' to the list!"
    puts ""
  end

  def print_list
    puts "Here is our list:".upcase

    @list.tasks.each do |task|
      print " " if task.id.to_i < 10
      print "#{task.id}. ["
      if task.complete == "complete" 
        print "X"
      elsif task.complete == "incomplete"
        print " "
      end
      puts "] #{task.name}"
    end
    puts ""
  end

  def print_outstanding_items
    puts "Here are your outstanding items:".upcase

    @list.sort_outstanding.each do |task|
      print " " if task.id.to_i < 10
      puts "#{task.id}. [ ] #{task.name}"
    end
    puts ""
  end

  def print_completed_items
    puts "Here are your completed items:".upcase

    @list.sort_completed.each do |task|
      print " " if task.id.to_i < 10
      puts "#{task.id}. [X] #{task.name}"
    end
    puts ""
  end

  def complete_task(id)
    completed = false
    @list.tasks.each do |task|
      if task.id.to_i == id
         task.finish_task
         completed = true
      end
    end
    print_list
    if completed
      puts "Completed task \##{id}!"
    else
      puts "Could not locate task \##{id}."
    end
    puts ""
  end

  def delete_task(id)
    deleted = false
    @list.tasks.each do |task|
      if task.id.to_i == id
        @list.delete(task)
        deleted = true
      end
    end
    print_list
    if deleted
      puts "Deleted task \##{id} from the list."
    else
      puts "Could not locate task \##{id}."
    end
    puts ""
  end

  def overwrite_csv
    counter = 1
    CSV.open("todo.csv", "wb") do |csv|
      csv << ["id", "task_name", "status", "created_at", "completed_at"]
      @list.tasks.each do |task|
        csv << [counter, task, task.complete, task.created_at, task.completed_at]
        counter+=1
      end
    end
  end

  def evaluate_input(argv)
    if argv == ["list"] || argv.empty?
      print_list
    elsif argv == ["list:outstanding"]
      print_outstanding_items
    elsif argv == ["list:completed"]
      print_completed_items
    elsif argv[0] == "add"
      add_task_to_list(argv[1])
    elsif argv[0] == "complete"
      complete_task(argv[1].to_i)
    elsif argv[0] == "delete"
      delete_task(argv[1].to_i)
    end
  end=
end

puts ""
c = Controller.new
