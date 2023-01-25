
module Model
  class Todo
    def initialize(id:, listId:, text:)
      @id = id
      @listId = listId
      @text = text
    end

    def attrs()
      {
        id: @id,
        listId: @listId,
        text: @text,
      }
    end

    class Factory
      def initialize(identificationService)
        @identificationService = identificationService
      end

      def create(listId, text)
        id = @identificationService.createId()
        Todo.new(id: id, listId: listId, text: text)
      end
    end
  end
end
