

class ViewController

  def self.print_list
    puts "Here is our list:".upcase
    ListProcessor.renumber_list_index

    Task.all.each do |task|
      print " " if task.list_index.to_i < 10
      print "#{task.list_index}. ["
      if task.status == "complete" 
        print "X"
      elsif task.status == "incomplete"
        print " "
      end
      puts "] #{task.name}"
    end
    puts ""
  end

end
