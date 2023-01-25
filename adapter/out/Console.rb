module Adapter::Out
  class Console
    def write(todoLists)
      puts todoLists.map {|t| t[:name]}.join("\n")
    end
  end
end
