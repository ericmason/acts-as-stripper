# ActsAsCommentable
module TrAvid
  module Acts #:nodoc:
    module Stripper #:nodoc:

      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def acts_as_stripper(opts={})
          opts = {
            :exclude => [],
            :include => []
          }.merge(opts)
          include_keys = opts[:include].to_a.collect {|x| x.to_s}
          exclude_keys = opts[:exclude].to_a.collect {|x| x.to_s}

          before_validation do |obj|
            include_keys = obj.attribute_names if include_keys.empty?
            strip_attributes = include_keys - exclude_keys
            strip_attributes.each {|a| obj[a].strip! if obj[a].respond_to?(:strip!) }
          end
        end
      end
            
    end
  end
end
