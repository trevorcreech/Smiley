require "rubygems"
require "memcache"

module Commands
  class MemCache
    def self.load(parser)

      memcache = ::MemCache.new("localhost")

      parser.register_command(Command.new("set",
                                          [{:name => "ID"}, {:name => "Message"}],
                                          proc{|args| puts memcache.set(args[0], args[1])}))
      parser.register_command(Command.new("get",
                                          [{:name => "ID"}],
                                          proc{|args| puts memcache.get(args[0])}))
      parser.register_command(Command.new("del",
                                          [{:name => "ID"}],
                                          proc{|args| puts memcache.delete(args[0])}))
    end
  end
end
