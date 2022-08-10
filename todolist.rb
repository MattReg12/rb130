
class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def not_done?
    !done
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def each
    @todos.each { |todo| yield(todo) }
    self
  end

  def select
    list = TodoList.new(title)
    each { |todo| list.add(todo) if yield(todo) }
    list
  end

  def find_by_title(title)
    select { |todo| todo.title == title }.first
  end

  def all_done
    select(&:done?)
  end

  def all_not_done
    select(&:not_done?)
  end

  def mark_done(title)
    todo = find_by_title(title)
    todo.done! if todo
  end

  def mark_all_done
    each(&:done!)
  end

  def mark_all_undone
    each(&:undone!)
  end

  def add(todo)
    raise TypeError, 'Can only add Todo objects' unless todo.is_a?(Todo)
    todos << todo
  end

  def method_missing(method)
    raise NoMethodError unless todos.respond_to?(method.intern)
    todos.send method.intern
  end

  def done!
    todos.each(&:done!)
  end

  def done?
    todos.all?(&:done?)
  end

  def item_at(i)
    todos.fetch(i)
  end

  def mark_done_at(i)
    item_at(i).done!
  end

  def mark_undone_at(i)
    item_at(i).undone!
  end

  def remove_at(i)
    item_at(i)
    todos.delete_at(i)
  end

  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  private

  attr_reader :todos
end
