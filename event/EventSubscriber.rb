module Event
  class EventSubscriber
    private_class_method :new

    def initialize(eventClass, handler)
      @eventClass = eventClass
      @handler = handler
    end

    def self.subscribe(*args)
      new(*args)
    end

    def accept(event)
      @handler.call(event)
    end

    def subscribe?(eventClass)
      @eventClass.equal?(eventClass)
    end
  end
end
