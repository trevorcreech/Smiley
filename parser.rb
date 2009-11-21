require 'command.rb'

class Parser
  def initialize
    @commands = []
    internal_commands
  end

  def internal_commands
    register_command(Command.new("commands", nil, proc { puts @commands.map{|c| c.command}.join("\n") } ))
    register_command(Command.new("help", [{:name => "Command"}], proc {|args| help(args[0])} ))
  end

  def help(command_name)
    command = find_command(command_name)
    puts command.example if command
  end

  def register_command(command)
    @commands << command
  end

  def parse(string)
    words = string.split(" ")
    command_name = words.shift
    args = words

    command = find_command(command_name)
    begin
      command.execute(args) if command
    rescue ArgumentError => e
      puts e.message
      puts "Example: #{command.example}"
    end
  end

  def find_command(name)
    @commands.each do |c|
      return c if c.command == name
    end
    return nil
  end
end