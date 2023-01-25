require_relative '../event/Event'

module Model
  class TodoAddedToList < Event::Event
    attr_reader :todo

    def initialize(todo)
      @todo = todo
    end
  end
end
