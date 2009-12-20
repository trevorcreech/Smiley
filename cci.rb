require "rubygems"
require "command.rb"
require "parser.rb"
require "activesupport"

class CCI
  
  BUNDLES = %w(MemCache FileSystem)
  
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
    BUNDLES.each {|b| load_bundle(b) }

    loop do
      print "#{@prompt} "
      input = gets
      quit if input.nil? # CTRL-D
      @parser.parse(input)
    end
  end

  private

  def internal_commands
    @parser.register_command(Command.new("set_prompt",
                                         [{:name => "Prompt", :default => ":)"}],
                                         proc {|args| @prompt = args.first } ))
  end
  
  def load_bundle(bundle)
    bundle = "Commands::#{bundle}"
    require bundle.underscore
    bundle.constantize.load(@parser)
  end
end

c = CCI.new
c.run
