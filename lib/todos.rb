require_relative "../db/setup"
require_relative '../lib/all'
require          'yaml'


class Todo

def initialize(options = {})
  @options, @items = options, []
  grabitall
  load_items
end

FILE = File.expand_path('.todos')

# allow 'todo' items to be accessible from the outside (i.e. db)
attr_accessor :items


def add(todo)
@items << Item.new(todo)
save
@items.last
end

########

def delete(index)
    todo = @items.delete_at(index.to_i-1)
    save
    todo
  end

  # returns the completed 'todo' item
  def done(index)
    item = @items[index.to_i-1]
    item.context = '@done'
    save
    item
  end


###########

def list
    longest = @items.map(&:text).max_by(&:length) || 0
    @items.each_with_index do |todo, index|
      printf "%s: %-#{longest.size+5}s %s\n", index+1, todo.text, todo.context
    end
  end


def bump(index, position = 1)
    @items.insert(position-1, @items.delete_at(index.to_i-1))
    save
    @items[position.to_i-1]
  end

  # Accessor for the todo list file

  def file
    @file ||= File.exist?(FILE) ? FILE : "#{ENV['HOME']}/.todos"
  end

#################

  def to_hash
    @items.group_by(&:context).inject({}) do |h,(k,v)|
      h[k.to_sym] = v.map(&:text); h
    end
  end

  def load_items
    YAML.load_file(file).each do |key, texts|
      texts.each do |text|
        if key.to_s == @options[:filter] || @options[:filter].nil?
          @items << Item.new("#{text} #{key}") if key.to_s != '@done'
        end
      end
    end
    @items
  end

##########

  def clear!
      @items.clear
      save
  end

  private

  def save
      File.open(file, "w") {|f| f.write(to_hash.to_yaml)}
  end

    # creates a new todo file if nothing is present


  def grabitall
    return if File.exist?(file)
    save
  end

end

if __FILE__ == $0
  case ARGV[0]
  when 'list','ls'
    Todo.new(:filter => ARGV[1]).list
  when 'add','a'
    puts "Added: #{Todo.new.add(ARGV[1..-1].join(' '))}"
  when 'delete', 'del', 'd'
    puts "Deleted: #{Todo.new.delete(ARGV[1])}"
  when 'done'
    puts "Done: #{Todo.new.done(ARGV[1])}"
  when 'edit'
    system("`echo $EDITOR` #{Todo.new.file} &")
  when 'clear'
    puts "All #{Todo.new.clear!} todos cleared! #{Todo.new.clear!}"
  when 'bump'
    puts "Bump: #{Todo.new.bump(ARGV[1])}"
    Todo.new.list
else
    puts "\nUsage: todo [options] COMMAND\n\n"
    puts "Commands:"
    puts "  add TODO        adds a todo"
    puts "  delete NUM      deletes a todo"
    puts "  done NUM        completes a todo"
    puts "  list [CONTEXT]  lists all active todos"
    puts "  bump NUM        bumps priority of a todo"
    puts "  edit            opens todo file"
  end
end




