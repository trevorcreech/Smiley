require "rubygems"
require "memcache"

module Commands
  class FileSystem
    
    @current_dir = "./"
    
    def self.load(parser)

      parser.register_command(Command.new("ls",
                                          [],
                                          proc{|args| self.ls}))
      parser.register_command(Command.new("cd",
                                          [{:newdir => "New Directory"}],
                                          proc{|args| self.cd(args[0])}))
    end
    
    def self.ls
      p "Switching to #{@current_dir}"
      dirs, files = Dir.open(@current_dir).partition {|f| File.directory?(f) }
      
      dirs.each do |dir|
        color = :blue
        puts dir
      end
      
      files.each do |file|
        color = :white
        puts file
      end
    end
    
    def self.cd(newdir)
      unless newdir[0,1] == "/"
        newdir = @current_dir + newdir
      end
      newdir = dirify(newdir)
      if valid_dir?(newdir)
        @current_dir = newdir
      else
        puts "Invalid Directory"
      end
    end
    
    private
    
    def self.dirify(dir)
      dir += "/" unless dir[-1,1] == "/"
      dir
    end
    
    def self.valid_dir?(dir)
      File.directory?(dir)
    end
  end
end
