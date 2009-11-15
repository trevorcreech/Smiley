require "command.rb"
require "parser.rb"

def quit
  puts
  exit
end

Signal.trap("SIGINT") { quit }

parser = Parser.new

parser.register_command(Command.new("set", [{:name => "ID", :regex => /^\d+$/}, {:name => "Message", :regex => //}]))
parser.register_command(Command.new("get", [{:name => "ID", :regex => /^\d+$/}, {:name => "Message", :regex => //}]))


loop do
  print ":)"
  input = gets
  quit if input.nil? # CTRL-D
  parser.parse(input)
end
