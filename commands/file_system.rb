require "rubygems"
require "memcache"

module Commands
  class FileSystem
    
    @current_dir = "./"
    
    def self.load(parser)
      #TODO: Go to home dir instead of .
      @home_dir = Dir.pwd

      parser.register_command(Command.new("ls",
                                          [],
                                          proc{|args| self.ls}))
      parser.register_command(Command.new("cd",
                                          [{:name => "New Directory", :default => @home_dir}],
                                          proc{|args| self.cd(args.first)}))
      parser.register_command(Command.new("cat",
                                          [{:name => "File"}],
                                          proc{|args| self.cat(args.first)}))
                                        
    end
    
    def self.ls
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
    
    def self.cat(file)
      if(self.valid_file?(file))
        File.open(file).each_line {|l| puts l }
      else
        puts "Invalid File"
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
    
    def self.valid_file?(file)
      File.file?(file)
    end
  end
end
