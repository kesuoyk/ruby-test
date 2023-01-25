require 'json'

module Impl
  class FileDatabase
    def initialize(dbJsonFilePath)
      @dbJsonFilePath = dbJsonFilePath
    end

    def read()
      File.open(@dbJsonFilePath) {|f|
        db = JSON.load(f)
        yield(db)
      }
    end

    def write()
      read {|db|
        File.open(@dbJsonFilePath, 'w') {|f|
          yield(db)
          JSON.dump(db, f)
        }
      }
    end
  end
end
