# spec/factory.rb
require 'active_record'
require 'active_record/fixtures'
module Factory
  def self.included(base)
    base.extend(self)
  end

  # build_valid method: Returns an active_record object using first record from fixtures for this model.
  def build_valid(params = {})
    record = new(build_valid_hash(params))
    record.save
    record
  end

  def build_valid_hash(params={})
    fixture = "#{RAILS_ROOT}/test/fixtures/" + self.name.underscore.pluralize
    raise "There are no default data from #{fixture}[.yml|.csv]" unless File.exists?("#{fixture}.csv") or File.exists?("#{fixture}.yml")
    h = Fixtures.new(self.connection, self.name.tableize, self.name, "#{fixture}").first[1].to_hash
    h.delete('id')
    h.keys.each { |k| h[k] = 'test_' + h[k] if h[k].is_a? String }
    h.merge(params)
  end
end

ActiveRecord::Base.class_eval do
  include Factory
end
