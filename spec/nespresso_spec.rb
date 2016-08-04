require 'rspec'
require_relative '../src/composition/nespresso'

context 'Composition' do

  describe '#make_a_coffee having' do

    let(:coffeeModule) { EspressoModule.new }
    let(:milkModule) { MilkModule.new }

    context 'a EspressoModule' do

      let(:nespresso_machine) do
        machine = Nespresso.new
        machine.add_feature(coffeeModule)
        machine
      end

      it 'should reduce by 1 the capsules' do
        nespresso_machine.make_a_coffee
        expect(nespresso_machine.capsules_left).to eq(0)
      end

      it 'should not modify the milk level' do
        nespresso_machine.make_a_coffee
        expect(nespresso_machine.milk_level).to eq(1)
      end

      it 'should raise an exception if there are no capsules left' do
        nespresso_machine.capsules_left = 0
        expect { nespresso_machine.make_a_coffee }.to raise_exception(RuntimeError, 'No capsules left')

      end

    end

    context 'a MilkModule' do

      let(:nespresso_machine) do
        machine = Nespresso.new
        machine.add_feature(milkModule)
        machine
      end

      it 'should reduce by 1 the milk level' do
        nespresso_machine.make_a_coffee
        expect(nespresso_machine.milk_level).to eq(0)
      end

      it 'should not modify the capsules' do
        nespresso_machine.make_a_coffee
        expect(nespresso_machine.capsules_left).to eq(1)
      end

      it 'should raise an exception if there is no milk left' do
        nespresso_machine.milk_level = 0
        expect { nespresso_machine.make_a_coffee }.to raise_exception(RuntimeError, 'No milk left')
      end

    end

    context 'a MixedMachine' do

      let(:nespresso_machine) do
        machine = Nespresso.new
        machine.features = [milkModule, coffeeModule]
        machine
      end

      it 'should reduce by 1 the milk level' do
        nespresso_machine.make_a_coffee
        expect(nespresso_machine.milk_level).to eq(0)
      end

      it 'should reduce by 1 the capsules' do
        nespresso_machine.make_a_coffee
        expect(nespresso_machine.milk_level).to eq(0)
      end

      it 'should raise an exception if there is no milk left' do
        nespresso_machine.milk_level = 0
        expect { nespresso_machine.make_a_coffee }.to raise_exception(RuntimeError, 'No milk left')
      end

      it 'should raise an exception if there are no capsules left' do
        nespresso_machine.capsules_left = 0
        expect { nespresso_machine.make_a_coffee }.to raise_exception(RuntimeError, 'No capsules left')
      end

    end
  end
end