class Command

  attr_reader :command
  # command: "n"
  # args: [{:name => "id", :regex => /^\d+$/}, {:name => "name", :regex => /^\w+$/}]
  def initialize(command, args, runner = nil)
    @command = command
    @args = args || []
    @runner = runner
  end

  def execute(args)
    validate_args(args)
    if @runner
      @runner.call(args)
    else
      puts "#{@command} #{args.join(" ")}"
    end
  end

  def validate_args(args)
    if args.size > @args.size
      raise ArgumentError.new("#{@command} only takes #{@args.size} parameter#{"s" if @args.size != 1}.")
    end

    @args.each_with_index do |arg, i|
      if args[i].nil? || args[i].empty?
        raise ArgumentError.new("#{@args[i][:name]} is missing.")
      elsif arg[:regex] && args[i] !~ arg[:regex]
        raise ArgumentError.new("#{@args[i][:name]} is invalid.")
      end
    end
  end

  def example
    "#{@command} #{@args.map{|a| a[:name]}.join(" ")}"
  end
end
