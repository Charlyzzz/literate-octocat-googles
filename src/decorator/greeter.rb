class Greeter

  def greet
    'Hi!'
  end

  def are_you_hungry?
    true
  end

end


class SuperPoliteGreeter

  def initialize(the_one_being_decorated)
    @decorated_one = the_one_being_decorated
  end

  def are_you_hungry?
    @decorated_one.are_you_hungry?
  end

  def greet
    @decorated_one.greet << ', how are you?'
  end

end

class Guard

  def initialize(the_one_being_decorated)
    @decorated_one = the_one_being_decorated
  end

  def are_you_hungry?
    false
  end

  def greet
    @decorated_one.greet
  end

end

