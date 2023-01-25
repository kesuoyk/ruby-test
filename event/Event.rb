require_relative './EventPublisher'

module Event
  class Event
    def publish()
      EventPublisher.publish(self)
    end
  end
end
