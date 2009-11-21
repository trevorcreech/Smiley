require "command.rb"
require "parser.rb"

require "commands/memcache"

class CCI
  def initialize
    @parser = Parser.new

    @prompt = ":)"
    internal_commands
  end

  def quit
    puts
    exit
  end

  Signal.trap("SIGINT") { quit }

  def run
    Commands::MemCache.load(@parser)

    loop do
      print "#{@prompt} "
      input = gets
      quit if input.nil? # CTRL-D
      @parser.parse(input)
    end
  end

  private

  def internal_commands
    @parser.register_command(Command.new("set_prompt", [{:name => "Prompt"}], proc {|args| @prompt = args.first } ))
  end
end

c = CCI.new
c.run
