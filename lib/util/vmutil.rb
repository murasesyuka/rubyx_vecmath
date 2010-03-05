module Rubyx
  
  module Vmutil
    
    module Crossed
      def crossed_ellipse obj
      end
      def crossed_line obj
      end
    end
    
    class Ellipse2
      attr_accessor :center,:radius
      def initialize p,r
        @center,@radius = p,r
      end

      def info
        [@center.x,@center.y, @radius]
      end
      
      def cross_point_ellipse el
        
      end
      
      def cross_point line
        xc_vec = @center - line.point
        yc_vec = @center - line.end_point
        #distance
        if xc_vec.length < @radius && yc_vec.length < @radius
          #‰~‚É’[“_‚ªŠÜ‚Ü‚ê‚Ä‚¢‚é
        else
          #‚ü
          temp = line.vector.normalize
          
          normal = Vector2.new(-temp.y,temp.x)

          b = line.point - @center

          #–@ü‚Æ’¼ü‚ÌŒð“_‚ð‹‚ß‚éA‚»‚ê‚ª‚“_‚É‚È‚é
          i = normal.x * line.vector.y - normal.y * line.vector.x
          
          s = ((b.x * normal.y)     - (b.y * normal.x))     / i.to_f
          t = -(((line.vector.x * b.y) - (line.vector.y * b.x)) / i.to_f)

          perpendicular_point = line.end_point Vector2.new(line.vector.x*s,line.vector.y*s)

          #‚“_‚ª‰~‚Ì“à•”‚Ìê‡
          per_dist = perpendicular_point.distance(@center)
          if  per_dist<= @radius
            s = Math.sqrt(@radius**2 - per_dist**2)
            if s == 0
              Line2.new(@center, line.vector.normalize(s)).end_point
            else
              [Line2.new(@center, line.vector.normalize(s)).end_point,
              Line2.new(@center, line.vector.normalize(-s)).end_point]
            end
          end
          

          #‰sŠp
          #p line.vector.dot(xc_vec)
          #p line.vector.dot(xc_vec)
        end
      end
    end
    
    class Line2
      attr_accessor :point,:vector
      def initialize point,vec
        @point,@vector = point,vec
      end

      def info
        [@point.x,@point.y,@vector.x,@vector.y]
      end
      
      def equal? obj
        @point==obj.point && @vector==obj.vector
      end

      ##
      #
      def cross_point line
        i = @vector.x * line.vector.y - @vector.y * line.vector.x
        
        # don't detect parallel line
        nil if i.zero?
        
        b = line.point - @point
        
        s = ((b.x * @vector.y)     - (b.y * @vector.x))     / i.to_f
        t = -(((line.vector.x * b.y) - (line.vector.y * b.x)) / i.to_f)
        if 0<=s && s<=1 && 0<=t && t<=1
          end_point Vector2.new(@vector.x*t,@vector.y*t)
        else
          nil
        end
      end
      
      def end_point vec=@vector; Point2.new(@point.x+vec.x,@point.y+vec.y); end
    end
  end
end


if __FILE__ == $0
  require 'vecmath'
  include Rubyx::Vmutil
  include Rubyx::Vecmath
  
  p0 = Point2.new(1,1)
  ell = Ellipse2.new(p0,1)
    
  p1 = Point2.new(1,-1)
  v1 = Vector2.new(0,4)
    
  l1 = Line2.new(p1,v1)

  p2 = Point2.new(0,0)
  v2 = Vector2.new(0,4)
    
  l2 = Line2.new(p2,v2)

  
  p ell.cross_point(l1)#.should ==
  p ell.cross_point(l2)#.should == 
end
