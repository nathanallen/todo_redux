


def print_list
  puts "Here is our list:".upcase

  Task.all.each do |task|
    print " " if task.id.to_i < 10
    print "#{task.id}. ["
    if task.status == "complete" 
      print "X"
    elsif task.status == "incomplete"
      print " "
    end
    puts "] #{task.name}"
  end
  puts ""
end
