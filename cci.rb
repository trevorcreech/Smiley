require "command.rb"
require "parser.rb"

require "commands/memcache"

def quit
  puts
  exit
end

Signal.trap("SIGINT") { quit }

parser = Parser.new

Commands::MemCache.load(parser)

loop do
  print ":)"
  input = gets
  quit if input.nil? # CTRL-D
  parser.parse(input)
end
