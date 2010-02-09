# ActsAsCommentable
module TrAvid
  module Acts #:nodoc:
    module Stripper #:nodoc:

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def acts_as_stripper          
          include TrAvid::Acts::Stripper::InstanceMethods
          before_validation_on_update :strip_white_spaces
        end
      end
            
      # This module contains instance methods
      module InstanceMethods
        def strip_white_spaces
          attributes.each_key {|a| self[a].strip! if self[a].respond_to?(:strip!) }
        end
      end
    end
  end
end
