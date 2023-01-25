module Observer
  class TodoAddedToList < Observer
    def handle(event)
      Domain::Todos.save(event.todo)
    end
  end
end
