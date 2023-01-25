require_relative '../../app/Exception'

module Adapter::In
  class Console
    COMMAND = [
      ['list', 'add'],
      ['list', 'ls'],
      ['todo', 'add'],
    ]

    def initialize(app)
      @app = app
    end

    def run(argv)
      target, command, args = parse(argv)

      begin
        dispatch(target, command, args)
      rescue App::Exception::ValidationError => evar
        puts evar
      end
    end

    private

    def self.targets()
      COMMAND::map {|c| c[0]}
    end

    def self.commands()
      COMMAND::map {|c| c[1]}
    end

    def parse(argv)
      target = argv[0]
      command = argv[1]
      args = argv[2..] || []

      unless self.class.targets.include?(target)
        raise "Invalid target: '#{target}'."
      end
      unless self.class.commands.include?(command)
        raise "Invalid command: '#{command}'."
      end

      [target, command, args]
    end

    def dispatch(target, command, args)
      case target
      when 'list'
        case command
        when 'add'
          @app.addList(*args)
        when 'ls'
          @app.lsList()
        end
      when 'todo'
        case command
        when 'add'
          @app.addTodo(*args)
        end
      end
    end
  end
end
