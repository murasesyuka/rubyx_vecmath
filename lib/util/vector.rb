if __FILE__ == $0
  require 'tuple'
end

module Rubyx
  module Vecmath

    include Math

    module Vec
      def + obj
        add(obj)
        self
      end
      
      def - obj
        sub(obj)
        self
      end

      def d vec
        dot(vec)
      end

      def c vec
        cross(vec)
        self
      end

      #def to_s;   'vec : '+super();  end
    end
    
    class Vector2
      include Tuple2
      include Vec

      alias_method :vx, :x
      alias_method :vy, :y

      alias_method :vx=, :x=
      alias_method :vy=, :y=

      def dot vec
        @x*vec.vx + @y*vec.vy
      end
      
      def length_square
        @x**2+@y**2
      end
      
      def length
        sqrt(length_square)
      end
      
      def normalize
        d = length
        raise "zero length" if d == 0
        @x /= d
        @y /= d
      end
      
      def angle vec
        atan2((@x*vec.vy - @y*vec.vx) , dot(vec)).abs
      end
    end
    
    class Vector3 < Vector2
      include Tuple3
      include Vec
      
      alias_method :vx, :x
      alias_method :vy, :y
      alias_method :vz, :z

      alias_method :vx=, :x=
      alias_method :vy=, :y=
      alias_method :vz=, :z=

      def dot vec
        super(vec) + @z*vec.vz
      end
      
      def cross vec
        set(
          @y*vec.vz - @z*vec.vy,
          @z*vec.vx - @x*vec.vz,
          @x*vec.vy - @y*vec.vx
        )
      end
      
      def length_square
        super()+@z**2
      end
      
      def length
        sqrt(length_square)
      end
      
      def normalize
        d = length
        raise "zero length" if d == 0
        @x /= d
        @y /= d
        @z /= d
      end
      
      def angle vec
        tmp = Vector3.new(@x,@y,@z)
        tmp.cross(vec)
        atan2(tmp.length, dot(vec)).abs
      end
    end
    
    class Vector4 < Vector3
      include Tuple4
      include Vec
      
      alias_method :vx, :x
      alias_method :vy, :y
      alias_method :vz, :z
      alias_method :vw, :w

      alias_method :vx=, :x=
      alias_method :vy=, :y=
      alias_method :vz=, :z=
      alias_method :vw=, :w=

      def dot vec
        super(vec) + @w*vec.vw
      end

      def cross; raise "not implement"; end
      
      def length_square
        super()+@w**2
      end
      
      def length
        sqrt(length_square)
      end
      
      def normalize
        d = length
        raise "zero length" if d == 0
        @x /= d
        @y /= d
        @z /= d
        @w /= d
      end
      
      def angle vec

      end
    end
  end
end


if __FILE__ == $0
  require 'tuple'
  require 'test/unit'

  include Rubyx::Vecmath
  include Math
  
  class TestVector2 < Test::Unit::TestCase
    def setup
      @v1_2 = Vector2.new(1,2)
      @v4_6 = Vector2.new(4,6)
      
      @v3_4 = Vector2.new(3,4)
      @vn4_3 = Vector2.new(-4,3)
    end
    
    def test_dot
      assert_equal(sqrt(@v1_2.dot(@v1_2)), @v1_2.length)
    end
    
    def test_normalize
    end
    
    def test_angle
      assert_equal(PI/2,@v3_4.angle(@vn4_3))
      assert_equal(PI/2,@vn4_3.angle(@v3_4))
      
      assert_equal(0,@v3_4.angle(@v3_4))
      assert_equal(0,@vn4_3.angle(@vn4_3))
    end
  end
  
  class TestVector3 < Test::Unit::TestCase
    def setup
      @v1_2_3 = Vector3.new(1,2,3)
      @v4_6_1 = Vector3.new(4,6,1)
    end
    
    def test_dot
      assert_equal(19,@v1_2_3.dot(@v4_6_1))
      assert_equal(19,@v4_6_1.dot(@v1_2_3))
    end
    
    def test_length
      assert_equal(sqrt(14), @v1_2_3.length)
      assert_equal(sqrt(53), @v4_6_1.length)
    end
    
    def test_normalize
    end
    
    def test_cross
      
    end
    
    def test_angle
      @v1_2_3.set(3,4,1)
      @v4_6_1.set(-4,3,1)
      
      angle = @v1_2_3.angle(@v4_6_1)
      assert_equal(acos(@v1_2_3.dot(@v4_6_1)/@v1_2_3.length/@v4_6_1.length) ,angle)
      angle = (@v4_6_1).angle(@v1_2_3)
      assert_equal(acos(@v1_2_3.dot(@v4_6_1)/@v1_2_3.length/@v4_6_1.length) ,angle)
    end
  end
end


