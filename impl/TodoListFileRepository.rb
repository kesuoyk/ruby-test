module Impl
  class TodoListFileRepository
    def initialize(db)
      @db = db
    end

    def all()
      @db.read {|db|
        db['TodoList'].map {|id, list|
          Model::TodoList.new(
            id: id,
            name: list['name']
          )
        }
      }
    end

    def find(id)
      @db.read {|db|
        db['TodoList'][id]
      }
    end

    def findByName(name)
      result = @db.read {|db|
        db['TodoList'].find {|id, list|
          list['name'] == name
        }
      }

      result && self.class.toModel(*result)
    end

    def unique?(attrName, value)
      @db.read {|db|
        !(
          db['TodoList'].values.map {|list|
            list[attrName]
          }.include?(value)
        )
      }
    end

    def save(todoList)
      @db.write {|db|
        db['TodoList'].store(todoList.id, todoList.attrs)
      }
    end

    private

    def self.toModel(id, list)
      Model::TodoList.new(
        id: id,
        name: list['name']
      )
    end
  end
end
