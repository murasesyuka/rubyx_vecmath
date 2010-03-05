module Rubyx
  module Vecmath
    
    include Math

    module Pot
      def + vec
      end
      def - vec
      end
      def * vec
      end
    end
    
    class Point2
      include Tuple2

      alias_method :px, :x
      alias_method :py, :y

      alias_method :px=, :x=
      alias_method :py=, :y=

      def distance_squared point
        (@x-point.px)**2 + (@y-point.py)**2
      end
      
      def distance point
        sqrt(distance_squared(point))
      end
      
      def distanceL1 point
        (@x-point.px).abs + (@y-point.py).abs
      end

      def distanceLinf point
        [(@x-point.px).abs, (@y-point.py).abs].max
      end
    end
    
    class Point3 < Point2
      include Tuple3

      alias_method :px, :x
      alias_method :py, :y
      alias_method :pz, :z

      alias_method :px=, :x=
      alias_method :py=, :y=
      alias_method :pz=, :z=

      def distance_squared point
        super(point) + (@z-point.pz)**2
      end
      
      def distance point
        sqrt(distance_squared(point))
      end
      
      def distanceL1 point
        super(point) + (@z-point.pz).abs
      end

      def distanceLinf point
        [super(point), (@z-point.pz).abs].max
      end
      
      def project point
        set(point.px / point.w, point.py / point.w, point.pz / point.w)
      end
    end
    
    class Point4 < Point3
      include Tuple4
      
      alias_method :px, :x
      alias_method :py, :y
      alias_method :pz, :z
      alias_method :pw, :w

      alias_method :px=, :x=
      alias_method :py=, :y=
      alias_method :pz=, :z=
      alias_method :pw=, :w=

      def distance_squared point
        super(point) + (@w-point.pw)**2
      end
      
      def distance point
        sqrt(distance_squared(point))
      end
      
      def distanceL1 point
        super(point) + (@w-point.pw).abs
      end

      def distanceLinf point
        [super(point), (@w-point.pw).abs].max
      end
      
      def project point
        set(point.px / point.w, point.py / point.w, point.pz / point.w, 1)
      end
    end
    
  end
end


if __FILE__ == $0
  require 'tuple'
  require 'test/unit'

  include Rubyx::Vecmath
  include Math
  
  class TestPoint2 < Test::Unit::TestCase
    def setup
      @p_not_init = Point2.new
      @p_org = Point2.new(0,0)
      @p1_1 = Point2.new(1,1)
      @p3_4 = Point2.new(3,4)
      @pn1_n1=Point2.new(-1,-1)
      @pn2_n2=Point2.new(-2,-2)
      @p1_2=Point2.new(1,2)
      @p4_6=Point2.new(4,6)
    end
    
    def test_distance
      assert_equal(0,@p_org.distance(@p_org))
      assert_equal(sqrt(2),@p1_1.distance(@p_org))
      assert_equal(5,@p3_4.distance(@p_org))
    end
    
    def test_distanceL1
      assert_equal(2,@pn1_n1.distanceL1(@p_org))
      assert_equal(4,@pn2_n2.distanceL1(@p_org))
      assert_equal(2,@pn2_n2.distanceL1(@pn1_n1))
      assert_equal(2,@pn1_n1.distanceL1(@pn2_n2))
      
      assert_equal(7,@p1_2.distanceL1(@p4_6))
    end
    
    def test_distanceLinf
      assert_equal(4,@p1_2.distanceLinf(@p4_6))
    end
  end
  
  class TestPoint3 < Test::Unit::TestCase
    def setup
      @p2_4_6    = Point3.new(2,4,6)
      @p4_8_12_2 = Point4.new(4,8,12,2)
    end
    
    def test_project
      tmp = Point3.new
      tmp.project(@p4_8_12_2)
      assert_equal(true, @p2_4_6.equals(tmp))
    end
  end
  
  class TestPoint4 < Test::Unit::TestCase
    def setup
      @p2_4_6_1  = Point4.new(2,4,6,1)
      @p4_8_12_2 = Point4.new(4,8,12,2)
    end
    
    def test_project
      tmp = Point4.new
      tmp.project(@p4_8_12_2)
      assert_equal(true, @p2_4_6_1.equals(tmp))
    end
  end
end


