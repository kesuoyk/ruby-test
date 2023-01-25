module Event
  class EventPublisher
    private_class_method :new

    def initialize()
      @subscribers = []
    end

    @@singleton = new

    def self.method_missing(method, *args)
      @@singleton.__send__(method, *args)
    end

    def register(subscriber)
      @subscribers.push(subscriber)
    end

    def publish(event)
      @subscribers.filter {|sub|
        sub.subscribe?(event.class)
      }.each {|sub|
        sub.accept(event)
      }
    end
  end
end
