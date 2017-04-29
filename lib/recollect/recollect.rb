require 'fileutils'
require 'pathname'

module Recollect
  class Recollection
    def initialize(args)
      @reserved = %w[new edit remove help search]
      usage unless args.length >= 1 && args.length <= 2
      @action, @name = args
      usage if @reserved.include?(@action) && args.length < 2
      usage if args.length == 2 && @reserved.include?(@name)
      @separator = '-------------------------'
      @recollect_path = File.join(ENV['HOME'], '.recollections')
      FileUtils.mkdir_p(@recollect_path)
      @debug = ENV['DEBUG']
    end

    def usage(msg = nil)
      puts msg unless msg.nil?
      puts "\nUSAGE: recollect ACTION [arg]\n"
      puts 'Recollect manages a series of things worth remembering "recollections" as a series of'
      puts "text files.\n\n"
      puts '  Actions: list, new, edit, or <name> where <name> is the recollection to be displayed.'
      puts '    list [category] - provides a listing of all available recollections.'
      puts '                      use [category] to specify a subdirectory'
      puts "    name            - displays the recollection matching 'name'"
      puts '    new <name>      - creates a new recollection'
      puts '    edit <name>     - modifies an existing recollection'
      puts '    remove <name>   - removes a recollection'
      puts "\nNote: #{@reserved} are reserved and cannot be the name"
      puts 'of a recollection.'
      exit 1
    end
    
    def debug(msg)
      puts msg if @debug == '1' or @debug == 'true'
    end

    def recollection_names(search_path = @recollect_path)
      rec = []
      recollections(search_path).each do |r| 
        abs = Pathname.new(File.expand_path(r))
        rel = abs.relative_path_from(Pathname.new(File.expand_path(search_path)))
        *p, f = rel.to_s.split('/')
        file = File.basename(f, File.extname(f))
        out = p.empty? ? file : File.join(p, file)
        rec << out
      end
      rec
    end

    def recollections(search_path = @recollect_path)
      Dir.glob(File.join(search_path, '**/*')).select { |f| f unless File.directory?(f) }
    end

    def verify_name(item = @name)
      unless item_exists?(item)
        puts "**** Unable to find a recollection matching '#{item}'"
        if File.directory?(File.join(@recollect_path, item))
          puts "Here are the contents of that category:"
          list_recollections(item)
          exit
        else
          usage
        end
      end
    end

    def item_exists?(item)
      recollections.find { |e| /#{item}\./ =~ e }
    end
    
    def write_file
      fullPath = File.join(@recollect_path, @name) + '.txt'
      subdir = File.dirname(fullPath)
      FileUtils.mkdir_p(subdir) unless subdir == '.'
      `#{ENV['EDITOR']} #{fullPath}`
    end

    def list_recollections(local_name = @name)
      location = @recollect_path
      location = File.join(@recollect_path, local_name) unless local_name.nil?
      puts "Available recollections:\n#{@separator}"
      puts recollection_names(location).map { |r| '  ' + r }
    end

    def new_recollection
      msg = "'#{@name}' Already exists; use edit to change."
      abort msg if item_exists?(@name)
      write_file
    end

    def edit_recollection
      verify_name
      write_file
    end

    def remove_recollection
      verify_name
      if confirm?
        File.delete(File.join(@recollect_path, @name) + '.txt')
        cleanup_path(File.dirname(File.join(@recollect_path, @name)))
      end
    end
    
    def cleanup_path(path)
      if path != @recollect_path && Dir["#{path}/*"].empty?
        debug "removing #{path}..."
        FileUtils.rmdir(path)
        cleanup_path(File.dirname(path))
      end
    end

    def print_recollection
      verify_name(@action)
      puts @separator
      File.open(File.join(@recollect_path, @action) + '.txt', 'r') do |f|
        f.each_line do |line|
          puts line
        end
      end
    end

    def confirm?
      puts "Are you sure you want to remove #{@name} [Y/n]?"
      a = $stdin.gets.chomp.downcase
      a == 'y' ? true : false
    end

    def run
      case @action
      when 'list'
        list_recollections
      when 'new'
        new_recollection
      when 'edit'
        edit_recollection
      when 'remove'
        remove_recollection
      else
        print_recollection
      end
    end
  end
end
