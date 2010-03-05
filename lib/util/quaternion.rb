if __FILE__ == $0
  require 'tuple'
end

module Rubyx
  module Vecmath
    
    include Math
    
    class Quat4
      include Tuple4
      
      alias_method :qx, :x
      alias_method :qy, :y
      alias_method :qz, :z
      alias_method :qw, :w
      
    end
    
  end
end


if __FILE__ == $0
  require 'tuple'
  require 'test/unit'

  include Rubyx::Vecmath
  include Math
  

  class TestPoint4 < Test::Unit::TestCase
    def setup

    end
    
    def test_project

    end
  end
end


