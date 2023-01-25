require_relative './TodoAddedToList'

module Model
  class TodoList
    attr_reader :id, :name, :todos

    def initialize(id:, name:, todos: [])
      @id = id
      @name = name
      @todos = todos
    end

    def addTodo(text, todoFactory)
      todo = todoFactory.create(@id, text)
      @todos.push(todo)
      TodoAddedToList.new(todo).publish
    end

    def remove(id)
      # TODO
    end

    def attrs()
      {
        name: @name,
      }
    end

    class Factory
      def initialize(idService)
        @idService = idService
      end

      def create(name)
        id = @idService.createId()
        TodoList.new(id: id, name: name)
      end
    end
  end
end
