require_relative './impl/TodoFileRepository'
require_relative './impl/TodoListFileRepository'

# 依存解決
module Domain
  Todos = Impl::TodoFileRepository.new
  TodoLists = Impl::TodoListFileRepository.new
end
