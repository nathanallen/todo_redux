
class Input
 def self.evaluate_input(argv)
    if argv == ["list"] || argv.empty?
      ViewController.print_list
    elsif argv == ["list:outstanding"]
      ViewController.print_outstanding_items
    elsif argv == ["list:completed"]
      ViewController.print_completed_items
    elsif argv[0] == "add"
      ListProcessor.add_task_to_list(argv[1])
    elsif argv[0] == "complete"
      ListProcessor.complete_task(argv[1].to_i)
    elsif argv[0] == "delete"
      ListProcessor.delete_task(argv[1].to_i)
    end
  end
end
