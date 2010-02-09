require 'acts_as_stripper'
ActiveRecord::Base.send(:include, TrAvid::Acts::Stripper)
