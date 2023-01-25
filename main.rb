require_relative './init';

module Adapter end

require_relative 'app/TodoListService'
require_relative 'impl/FileDatabase'
require_relative 'impl/IdService'
require_relative 'impl/TodoFileRepository'
require_relative 'impl/TodoListFileRepository'
require_relative 'model/Todo'
require_relative 'model/TodoList'
require_relative 'adapter/in/Console'
require_relative 'adapter/out/Console'
require_relative 'config'

if File.empty?($config['dbJsonFilePath'])
  File.open($config['dbJsonFilePath'], 'w') {|file|
    require 'json'
    emptyDb = {
      'TodoList' => {},
      'Todo' => {},
    }
    file.write(JSON.generate(emptyDb))
    puts 'Database has been created.'
  }
end

fileDatabase = Impl::FileDatabase.new($config['dbJsonFilePath'])
app = App::TodoListService.new(
  todoListFactory: Model::TodoList::Factory.new(
    Impl::IdService.new
  ),
  todoListRepo: Impl::TodoListFileRepository.new(
    fileDatabase
  ),
  todoFactory: Model::Todo::Factory.new(
    Impl::IdService.new
  ),
  todoRepo: Impl::TodoFileRepository.new(
    fileDatabase
  ),
  outputPort: Adapter::Out::Console.new
)

Adapter::In::Console.new(app).run(ARGV)
