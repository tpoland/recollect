#!/usr/bin/ruby

require 'FileUtils'

module Recollect
  
  def initialize()
    @recollect_path = File.join(ENV['HOME'], '.recollections')
    FileUtils.mkdir_p(@recollect_path)
  end
  
  def usage(msg = nil )
    puts msg unless msg.nil?
    puts "USAGE: #{__FILE__} ACTION [arg]"
    puts "  Actions: list, new, edit, or <name> where <name> is the recollection to be displayed."
    puts "    list        - provides a listing of all available recollections"
    puts "    name        - displays the recollection matching 'name'"
    puts "    new [name]  - provides a listing of all available recollections"
    puts "    edit [name] - provides a listing of all available recollections"
    puts "    remove [name]   - removes a recollections"
    exit 1
  end
  
  def get_recollections
    recollections.map{|r| File.basename(r, File.extname(r))}
  end
  
  def recollections
    @recollections ||= Dir.glob(File.join(@recollect_path, '**'))
  end
  
  def verify_name(item = @name)
    unless item_exists?(item)
      puts "Unable to find a recollecter matching '#{item}'"
      usage
      exit
    end
  end
  
  def item_exists?(item)
    recollections.find {|e| /#{item}\./ =~ e}
  end
  
  def write_file
    %x{mate #{File.join(@recollect_path, @name) + '.txt'}}
  end
  
  def confirm?
    puts "Are you sure you want to remove #{@name} [Y/n]?"
    a = $stdin.gets.chomp.downcase
    a == 'y' ? true : false
  end
  
  unless ARGV.length >= 1 and ARGV.length <= 2
    usage
    exit
  end
  
  @action, @name = ARGV
  @separator = '-------------------------'
  
  case @action
   when 'list'
     puts "Available recollections:\n#{@separator}"
     puts get_recollections.map{|r| "  " + r}
   when 'new'
     abort "'#{@name}' Already exists; use edit to change." if item_exists?(@name)
     write_file
   when 'edit'
     verify_name
     write_file
   when 'rm'
     verify_name
     File.delete(File.join(@recollect_path, @name) + '.txt') if confirm?
   else
     verify_name(@action)
     puts @separator
     puts %x{cat #{File.join(@recollect_path, @action) + '.*'}}
  end
end