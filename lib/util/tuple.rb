
module Rubyx
  module Vecmath
    
    include Math
    
    module TupleNotImplementMethod
      #def set;end
      def get;end
      #def add;end
      #def sub;end
      #def negate;end
      #def scale;end
      #def scale_add;end
      #def equals;end
      #def epsilon_equals;end
      def clamp;end
      def clamp_min;end
      def clamp_max;end
      def absolute;end
      def interpolate;end
    end
    
    module Tuple2
      attr_accessor :x,:y
      
      def initialize x=0,y=0
        @x,@y = x,y
      end

      def set x,y
        @x,@y = x,y
      end

      def to_s; @x.to_s + ',' + @y.to_s; end
      
      def equals obj; @x==obj.x && @y==obj.y; end
      def epsilon_equals obj,e; ((@x-obj.x).abs <= e) && ((@y-obj.y).abs <= e) ; end
      
      def add obj;  @x += obj.x; @y += obj.y;  end
      def sub obj;  @x -= obj.x; @y -= obj.y;  end
      def negate;   @x = -@x   ; @y = -@y   ;  end
      def scale s;  @x *= s    ; @y *= s    ;  end
    end
    
    module Tuple3
      include Tuple2
      attr_accessor :z
      
      def initialize x=0,y=0,z=0
        super(x,y)
        @z = z
      end
      
      def set x,y,z
        super(x,y)
        @z = z
      end
      
      def to_s; super()+','+@z.to_s; end
      
      def equals obj; super(obj) && @z==obj.z; end
      def epsilon_equals obj,e; super(obj) && ((@z-obj.z).abs <= e) ; end
      
      def add obj;  super(obj); @z += obj.z;  end
      def sub obj;  super(obj); @z -= obj.z;  end
      def negate;   super()   ; @z = -@z   ;  end
      def scale s;  super(s)  ; @z *= s    ;  end
    end
    
    module Tuple4
      include Tuple3
      attr_accessor :w
      
      def initialize x=0,y=0,z=0,w=0
        super(x,y,z)
        @w = w
      end
      
      def set x,y,z,w
        super(x,y,z)
        @w = w
      end
      
      def to_s; super()+','+@w.to_s; end
      
      def equals obj; super(obj) && @w==obj.w; end
      def epsilon_equals obj,e; super(obj) && ((@w-obj.w).abs <= e) ; end
      
      def add obj;  super(obj); @w += obj.w;  end
      def sub obj;  super(obj); @w -= obj.w;  end
      def negate;   super()   ; @w = -@w   ;  end
      def scale s;  super(s)  ; @w *= s    ;  end
    end
  end
end


if __FILE__ == $0
  require 'test/unit'
  require 'vector'
  require 'point'
  
  include Rubyx::Vecmath
  include Math
  
  class TestTuple2 < Test::Unit::TestCase
    def setup
      @p0_0 =  Point2.new
      @v0_0 = Vector2.new
      @p1_1 =  Point2.new(1,1)
      @v1_1 = Vector2.new(1,1)
      @p2_2 =  Point2.new(2,2)
      @v2_2 = Vector2.new(2,2)
      
      @points  = [@p0_0,@p1_1,@p2_2]
      @vectors = [@v0_0,@v1_1,@v2_2]
    end
    
    def test_set
      
    end
    
    def test_to_s
      assert_equal("0,0", @p0_0.to_s)
      assert_equal("0,0", @v0_0.to_s)
      assert_equal("1,1", @p1_1.to_s)
      assert_equal("1,1", @v1_1.to_s)
      assert_equal("2,2", @p2_2.to_s)
      assert_equal("2,2", @v2_2.to_s)
    end
    
    def test_equals
      @points.each_with_index{|point,i|
        @vectors.each_with_index{|vector,j|
          bool = (i == j)
          assert_equal(bool,point.equals(vector))
          assert_equal(bool,vector.equals(point))
        }
      }
    end
    
    def test_epsilon_equals
      @points.each_with_index{|point,i|
        @vectors.each_with_index{|vector,j|
          bool = (i == j)
          assert_equal(bool,point.epsilon_equals(vector,0.0001))
          assert_equal(bool,vector.epsilon_equals(point,0.0001))
        }
      }
      @points.each_with_index{|point,i|
        @vectors.each_with_index{|vector,j|
          assert_equal(true,point.epsilon_equals(vector,2))
          assert_equal(true,vector.epsilon_equals(point,2))
        }
      }
    end
    
    def test_add_point
      @points.each{|point|
        @vectors.each{|vector|
          x = point.x+vector.x
          y = point.y+vector.y
          point.add(vector)
          assert_equal(x,point.x)
          assert_equal(y,point.y)
        }
      }
    end
    
    def test_add_vector
      @points.each{|point|
        @vectors.each{|vector|
          x = point.x+vector.x
          y = point.y+vector.y
          vector.add(point)
          assert_equal(x,vector.x)
          assert_equal(y,vector.y)
        }
      }
    end
    
    def test_sub
      
    end
    
    def test_negate
      
    end
    
    def test_scale
      
    end
  end
  
  class TestTuple3 < Test::Unit::TestCase
    def setup
      @p0_0_0 =  Point3.new
      @v0_0_0 = Vector3.new
      @p1_1_1 =  Point3.new(1,1,1)
      @v1_1_1 = Vector3.new(1,1,1)
      @p2_2_2 =  Point3.new(2,2,2)
      @v2_2_2 = Vector3.new(2,2,2)
      
      @points  = [@p0_0_0,@p1_1_1,@p2_2_2]
      @vectors = [@v0_0_0,@v1_1_1,@v2_2_2]
    end
    
    def test_to_s
      assert_equal("0,0,0", @p0_0_0.to_s)
      assert_equal("0,0,0", @v0_0_0.to_s)
      assert_equal("1,1,1", @p1_1_1.to_s)
      assert_equal("1,1,1", @v1_1_1.to_s)
      assert_equal("2,2,2", @p2_2_2.to_s)
      assert_equal("2,2,2", @v2_2_2.to_s)
    end
    
    def test_equals
      @points.each_with_index{|point,i|
        @vectors.each_with_index{|vector,j|
          bool = (i == j)
          assert_equal(bool,point.equals(vector))
          assert_equal(bool,vector.equals(point))
        }
      }
    end
  end
end


