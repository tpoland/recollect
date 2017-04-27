require 'fileutils'

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
    end

    def usage(msg = nil)
      puts msg unless msg.nil?
      puts "\nUSAGE: recollect ACTION [arg]\n"
      puts 'Recollect manages a series of things worth remembering "recollections" as a series of'
      puts "text files.\n\n"
      puts '  Actions: list, new, edit, or <name> where <name> is the recollection to be displayed.'
      puts '    list            - provides a listing of all available recollections'
      puts "    name            - displays the recollection matching 'name'"
      puts '    new [name]      - creates a new recollection'
      puts '    edit [name]     - modifies an existing recollection'
      puts '    remove [name]   - removes a recollections'
      puts "\nNote: #{@reserved} are reserved and cannot be the name"
      puts 'of a recollection.'
      exit 1
    end

    def recollection_names
      recollections.map { |r| File.basename(r, File.extname(r)) }
    end

    def recollections
      @recollections ||= Dir.glob(File.join(@recollect_path, '**'))
    end

    def verify_name(item = @name)
      unless item_exists?(item)
        puts "Unable to find a recollecter matching '#{item}'"
        usage
      end
    end

    def item_exists?(item)
      recollections.find { |e| /#{item}\./ =~ e }
    end

    def write_file
      `#{ENV['EDITOR']} #{File.join(@recollect_path, @name) + '.txt'}`
    end

    def list_recollections
      puts "Available recollections:\n#{@separator}"
      puts recollection_names.map { |r| '  ' + r }
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
      File.delete(File.join(@recollect_path, @name) + '.txt') if confirm?
    end

    def print_recollection
      verify_name(@action)
      puts @separator
      #puts `cat #{File.join(@recollect_path, @action) + '.*'}`
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
