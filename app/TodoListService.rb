require_relative '../event/EventPublisher'
require_relative '../event/EventSubscriber'
require_relative '../model/TodoAddedToList'

module App
  class TodoListService
    def initialize(
      todoListFactory:,
      todoListRepo:,
      todoFactory:,
      todoRepo:,
      outputPort:
    )
      @todoListFactory = todoListFactory
      @todoListRepo = todoListRepo
      @todoFactory = todoFactory
      @todoRepo = todoRepo
      @outputPort = outputPort
    end

    def lsList()
      @outputPort.write(@todoListRepo.all.map {|t| t.attrs})
    end

    def addList(name)
      unless @todoListRepo.unique?('name', name)
        raise Exception::ValidationError.new(
          'A list with this name already exists.'
        )
      end

      list = @todoListFactory.create(name)
      @todoListRepo.save(list)
    end

    def addTodo(listName, text)
      list = @todoListRepo.findByName(listName)

      unless list then
        raise Exception::ValidationError.new(
          'No such list.'
        )
      end

      Event::EventPublisher.register(
        Event::EventSubscriber.subscribe(
          Model::TodoAddedToList,
          Proc.new {|event|
            @todoRepo.save(event.todo)
          })
      )

      list.addTodo(text, @todoFactory)
    end
  end
end
