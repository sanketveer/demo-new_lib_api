
# features/support/env.rb

require 'active_record/fixtures'
require 'cucumber/rails'

# # Load fixtures
# fixtures_folder = Rails.root.join('spec', 'fixtures')
# fixtures = Dir.glob(File.join(fixtures_folder, '*.yml')).map { |f| File.basename(f, '.yml') }
# ActiveRecord::FixtureSet.create_fixtures(fixtures_folder, fixtures)


module FixtureAccess
  def self.extended(base)
    ActiveRecord::FixtureSet.reset_cache
    fixtures_folder = File.join(Rails.root, 'spec', 'fixtures')
    fixtures = Dir[File.join(fixtures_folder, '*.yml')].map { |f| File.basename(f, '.yml') }
    fixtures += Dir[File.join(fixtures_folder, '*.csv')].map { |f| File.basename(f, '.csv') }
    # ActiveRecord::FixtureSet.create_fixtures(fixtures_folder, fixtures)
    (class << base; self; end).class_eval do
      @@fixture_cache = {}

      fixtures.each do |table_name|
        table_name = table_name.to_s.tr('.', '_')

        define_method(table_name) do |*fixture_symbols|
          @@fixture_cache[table_name] ||= {}
          # This will populate the test database tables
          ActiveRecord::FixtureSet.create_fixtures(fixtures_folder, table_name)
          instances = fixture_symbols.map do |fixture_symbol|
            if (fix = ActiveRecord::FixtureSet
                .cached_fixtures(ActiveRecord::Base.connection, table_name)
                .first
                .fixtures[fixture_symbol.to_s])
              # find model.find's the instance
              @@fixture_cache[table_name][fixture_symbol] ||= fix.find
            else
              raise StandardError,
                    "No fixture with name '#{fixture_symbol}' found for table '#{table_name}'"
            end
          end
          instances.size == 1 ? instances.first : instances
        end
      end
    end
  end
end

World(FixtureAccess)