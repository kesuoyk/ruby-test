require_relative '../impl/EventPublisher'

module Model
  class Model
    def initialize()
      @eventPublisher = EventPublisher.new
    end

    private

    def publish(event)
      @eventPublisher.publish(event)
    end
  end
end
