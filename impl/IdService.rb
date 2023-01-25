module Impl
  require 'securerandom'

  class IdService
    def createId()
      SecureRandom.uuid
    end
  end
end
