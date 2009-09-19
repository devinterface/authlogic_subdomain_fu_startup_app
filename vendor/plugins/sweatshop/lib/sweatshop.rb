module MDarby
  module Sweatshop #:nodoc:

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods        
      def sweatshop          
        include MDarby::Sweatshop::InstanceMethods
        extend MDarby::Sweatshop::SingletonMethods
      end
    end

    module SingletonMethods
    end

    module InstanceMethods
    end
    
  end
end