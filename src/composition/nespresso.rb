class Nespresso

  attr_accessor :milk_level, :capsules_left, :features

  def initialize(milk_level = 1, capsules = 1)
    @milk_level = milk_level
    @capsules_left = capsules
    @features = []
  end

  def add_feature(feature)
    @features << feature
  end

  def make_a_coffee
    @features.each do |feature|
      feature.modify(self)
    end

  end

  def pour_milk
    raise 'No milk left' if @milk_level == 0
    @milk_level -= 1
  end

  def pour_coffee
    raise 'No capsules left' if @capsules_left == 0
    @capsules_left -= 1
  end

end


class MilkModule

  def modify(machine)
    machine.pour_milk
  end

end

class EspressoModule

  def modify(machine)
    machine.pour_coffee
  end

end