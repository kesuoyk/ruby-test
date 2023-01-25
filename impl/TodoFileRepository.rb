module Impl
  class TodoFileRepository
    def initialize(db)
      @db = db
    end

    def save(todo)
      @db.write {|db|
        attrs = todo.attrs
        db['Todo'].store(attrs[:id], todo.attrs)
      }
    end
  end
end
