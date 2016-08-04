require 'rspec'
require_relative '../src/decorator/greeter'

context 'Decorator' do

  def combine_greeters(*greeters)
    greeters.reverse.inject(original_greeter) do |decorated, new_type|
      new_type.new(decorated)
    end
  end

  let(:original_greeter) { Greeter.new }

  describe '#greet' do

    context 'on a Greeter' do

      it 'should say Hi!' do
        expect(original_greeter.greet).to eq('Hi!')
      end
    end

    context 'on a decorated greeter' do

      it 'should modify the greet if there is SuperPoliteGreeters in the chain' do
        unknown_greeter = SuperPoliteGreeter.new(original_greeter)
        expect(unknown_greeter.greet).to eq('Hi!, how are you?')
      end

      it "should concat 'how are you?' for each SuperPoliteGreeter" do
        unknown_greeter = combine_greeters(SuperPoliteGreeter, Guard, SuperPoliteGreeter)
        expect(unknown_greeter.greet).to eq('Hi!, how are you?, how are you?')
      end

    end
  end

  describe '#are_you_hungry?' do

    context 'on a Greeter' do

      it 'should be hungry' do
        expect(original_greeter.are_you_hungry?).to be true
      end

    end

    context 'on a decorated greeter' do

      it 'should be hungry if are no a Guards' do
        unknown_greeter = combine_greeters(SuperPoliteGreeter, SuperPoliteGreeter)
        expect(unknown_greeter.are_you_hungry?).to be true
      end

      it 'should not be hungry if there is a Guard' do
        unknown_greeter = Guard.new(original_greeter)
        expect(unknown_greeter.are_you_hungry?).to be false
      end

      it 'should not be hungry if there are any Guard' do
        unknown_greeter = combine_greeters(SuperPoliteGreeter, Guard, SuperPoliteGreeter)
        expect(unknown_greeter.are_you_hungry?).to be false
      end

    end
  end
end