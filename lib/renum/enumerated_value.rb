require 'forwardable'

module Renum
  class EnumeratedValue
    
    class << self
      include Enumerable
      extend Forwardable
      
      def_delegators :values, :each, :[]
      
      def values
        @values ||= []
      end
      
    end
    
    include Comparable
    attr_reader :name
    attr_reader :index
    
    def initialize name
      @name = name.to_s
      @index = self.class.values.size
      self.class.values << self
    end
    
    def to_s
      "#{self.class}::#{name}"
    end
    
    def <=> other
      index <=> other.index
    end
    
    # Alias +== other+
    def eql? other
      self == other
    end
    
    # Compare other with this object by their +name+ and +class+ attributes.
    # The same functionallity can be achieved by using the +equal?+ method,
    # but this is a little bit more expressive.
    def == other
      self.class == other.class && self.name == other.name
    end
    
  end
end