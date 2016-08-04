require 'rspec'
require_relative '../src/composite/dependency'

context 'Composite' do

  context 'SingleDependency' do

    let(:rspec) { SingleDependency.new('Rspec', 13) }

    describe '#download' do

      it 'should raise an exception because it is available' do
        rspec.is_available = true
        expect { rspec.download }.to raise_exception(RuntimeError, 'Already downloaded')
      end

    end

    describe '#download_size' do

      it 'should be the expected size' do
        expect(rspec.download_size).to eq(13)
      end

    end

    describe '#available?' do

      it 'should not be available before downloading' do
        expect(rspec.available?).to be false
      end

      it 'should be available after downloading' do
        rspec.download
        expect(rspec.available?).to be true
      end

    end

  end

  context 'MultipleDependency' do

    let(:rake) { SingleDependency.new('Rake', 150) }
    let(:pry) { SingleDependency.new('Pry', 20) }
    let(:nokogiri) { SingleDependency.new('Nokogiri', 50) }
    let(:rack) { SingleDependency.new('rack', 30) }
    let(:yaml) { SingleDependency.new('yaml', 100) }

    let(:bundler) { MultiDependency.new('Rails', yaml, rack) }
    let(:rails) { MultiDependency.new('Rails', rake, pry, nokogiri, bundler) }

    describe '#download' do

      it 'should not be available' do
        expect(bundler.available?).to be false
      end

      it 'should raise an exception because it is available' do
        rake.is_available = true
        pry.is_available = true
        nokogiri.is_available = true
        rack.is_available = true
        yaml.is_available = true
        expect { rails.download }.to raise_exception(RuntimeError, 'Already downloaded')
      end

    end

    describe '#download_size' do

      it 'should be the sum of the missing dependencies' do
        rake.is_available = true
        expect(rails.download_size).to eq(200)
      end

      it 'should be zero if it is available' do
        rake.is_available = true
        pry.is_available = true
        nokogiri.is_available = true
        rack.is_available = true
        yaml.is_available = true
        expect(rails.download_size).to eq(0)
      end

    end

    describe '#available?' do

      it 'should be available because all dependencies are available' do
        rack.is_available = true
        yaml.is_available = true
        expect(bundler.available?).to be true
      end

      it 'should not be available because some dependencies are not available' do
        rack.is_available = true
        expect(bundler.available?).to be false
      end

    end

  end

end