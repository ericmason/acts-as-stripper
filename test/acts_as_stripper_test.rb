require 'test/unit'
require 'test_helper'
require 'active_record'
require 'acts_as_stripper'

ActiveRecord::Base.send(:include, TrAvid::Acts::Stripper)

ActiveRecord::Base.class_eval do
  alias_method :save, :valid?
  def self.columns() @columns ||= []; end
      
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type, null)
  end
end

class DummyClass < ActiveRecord::Base
  acts_as_stripper(:exclude => :login)
  column :id,    :integer
  column :login, :string
  column :name,  :string
end

class NonNilDummy < ActiveRecord::Base
  acts_as_stripper(:exclude => :login, :convert_empty_string_to_nil => false)
  
  column :id,    :integer
  column :login, :string
  column :name,  :string
end

class ActsAsStripperTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "strips whitespace" do 
    d = DummyClass.new
    d.name = "blah "
    d.valid?
    assert_equal "blah", d.name
  end
  
  test "excludes excluded attributes" do
    d = DummyClass.new
    d.login = "asdf "
    d.valid?
    assert_equal "asdf ", d.login
  end
  
  test "converts empty strings to nil" do
    d = DummyClass.new
    d.name = ""
    d.valid?
    assert_equal nil, d.name
  end
  
  test "doesn't convert empty strings to nil when not supposed to" do
    d = NonNilDummy.new
    d.name = ""
    d.valid?
    assert_equal "", d.name
  end
end
