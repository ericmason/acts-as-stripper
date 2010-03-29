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
            :include => [],
            :convert_empty_string_to_nil => true
          }.merge(opts)
          include_keys = [*opts[:include]].collect {|x| x.to_s}
          exclude_keys = [*opts[:exclude]].collect {|x| x.to_s}
          convert_empty_string_to_nil = opts[:convert_empty_string_to_nil]

          before_validation do |obj|
            include_keys = obj.attribute_names if include_keys.empty?
            strip_attributes = include_keys - exclude_keys
            strip_attributes.each do |a| 
              obj[a].strip! if obj[a].respond_to?(:strip!)
              obj[a] = nil if convert_empty_string_to_nil and obj[a] == ""
            end
          end
        end
      end
            
    end
  end
end
