if __FILE__ == $0
  require 'tuple'
  require 'vector'
  require 'quaternion'
end

module Rubyx
  
  module Vecmath
    
    include Math
    
    module Mat3
      attr_accessor :m00,:m01,:m02,
                    :m10,:m11,:m12,
                    :m20,:m21,:m22
      
      alias_method :mm00,:m00; alias_method :mm01,:m01; alias_method :mm02,:m02;
      alias_method :mm10,:m10; alias_method :mm11,:m11; alias_method :mm12,:m12;
      alias_method :mm20,:m20; alias_method :mm21,:m21; alias_method :mm22,:m22;

      alias_method :mm00=,:m00=; alias_method :mm01=,:m01=; alias_method :mm02=,:m02=;
      alias_method :mm10=,:m10=; alias_method :mm11=,:m11=; alias_method :mm12=,:m12=;
      alias_method :mm20=,:m20=; alias_method :mm21=,:m21=; alias_method :mm22=,:m22=;
      
      def initialize m00=0,m01=0,m02=0,
                     m10=0,m11=0,m12=0,
                     m20=0,m21=0,m22=0
        set m00,m01,m02,
            m10,m11,m12,
            m20,m21,m22
      end
      
      ###
      #  set methods
      ###
      def set m00=nil,m01=nil,m02=nil,
              m10=nil,m11=nil,m12=nil,
              m20=nil,m21=nil,m22=nil
        
        unless m01 || m02 || m10 || m11 || m12 || m20 || m21 || m22
          mat = m00
          @m00 = mat.mm00;@m01 = mat.mm01;@m02 = mat.mm02;
          @m10 = mat.mm10;@m11 = mat.mm11;@m12 = mat.mm12;
          @m20 = mat.mm20;@m21 = mat.mm21;@m22 = mat.mm22;
        else
          @m00,@m01,@m02 = m00,m01,m02
          @m10,@m11,@m12 = m10,m11,m12
          @m20,@m21,@m22 = m20,m21,m22
        end
      end
      
      def set_identity
        @m00,@m01,@m02 = 1,0,0
        @m10,@m11,@m12 = 0,1,0
        @m20,@m21,@m22 = 0,0,1
      end
      
      def set_zero
        @m00,@m01,@m02 = 0,0,0
        @m10,@m11,@m12 = 0,0,0
        @m20,@m21,@m22 = 0,0,0
      end
      
      def set_scale scale
        @m00 *= scale; @m11 *= scale; @m22 *= scale
      end
      
      def get_scale
        sqrt((
          @m00*@m00 + @m10*@m10 + @m20*@m20 + 
          @m01*@m01 + @m11*@m11 + @m21*@m21 +
          @m02*@m02 + @m12*@m12 + @m22*@m22)/3.0
        )
      end
      
      def set_quat quat
        set_from_quat(quat.qx,quat.qy,quat.qz,quat.qw)
      end
      
      def set_axis axis
        set_from_axis_angle(axis.ax,axis.ay,axis.az,axis.angle)
      end
      
      ###
      #  equals methods
      ###
      def equals mat
        @m00 == mat.mm00 && @m01 == mat.mm01 && @m02 == mat.mm02 &&
        @m10 == mat.mm10 && @m11 == mat.mm11 && @m12 == mat.mm12 &&
        @m20 == mat.mm20 && @m21 == mat.mm21 && @m22 == mat.mm22
      end
      
      def == mat;equals(mat);end
      
      def epsilon_equals mat,epsilon
        ((m00 - mat.m00).abs <= epsilon) &&
        ((m01 - mat.m01).abs <= epsilon) &&
        ((m02 - mat.m02).abs <= epsilon) &&
        ((m10 - mat.m10).abs <= epsilon) &&
        ((m11 - mat.m11).abs <= epsilon) &&
        ((m12 - mat.m12).abs <= epsilon) &&
        ((m20 - mat.m20).abs <= epsilon) &&
        ((m21 - mat.m21).abs <= epsilon) &&
        ((m22 - mat.m22).abs <= epsilon)
      end
      
      def to_s
        [[@m00,@m01,@m02],
        [@m10,@m11,@m12],
        [@m20,@m21,@m22]]
      end
    end
    
    module Mat4
      include Mat3
      
      attr_accessor                :m03,
                                   :m13,
                                   :m23,
                    :m30,:m31,:m32,:m33
        
                                                                                 alias_method :mm03,:m03;
                                                                                 alias_method :mm13,:m13;
                                                                                 alias_method :mm23,:m23;
      alias_method :mm30,:m30; alias_method :mm31,:m31; alias_method :mm32,:m32; alias_method :mm33,:m33;

                                                                                       alias_method :mm03=,:m03=;
                                                                                       alias_method :mm13=,:m13=;
                                                                                       alias_method :mm23=,:m23=;
      alias_method :mm30=,:m30=; alias_method :mm31=,:m31=; alias_method :mm32=,:m32=; alias_method :mm33=,:m33=;
      
      def initialize m00=0,m01=0,m02=0,m03=0,
                     m10=0,m11=0,m12=0,m13=0,
                     m20=0,m21=0,m22=0,m23=0,
                     m30=0,m31=0,m32=0,m33=0
        set m00,m01,m02,m03,
            m10,m11,m12,m13,
            m20,m21,m22,m23,
            m30,m31,m32,m33
      end
      
      def set m00=nil,m01=nil,m02=nil,m03=nil,
              m10=nil,m11=nil,m12=nil,m13=nil,
              m20=nil,m21=nil,m22=nil,m23=nil,
              m30=nil,m31=nil,m32=nil,m33=nil
        
        unless m01 || m02 || m03 ||
               m10 || m11 || m12 || m13 ||
               m20 || m21 || m22 || m23 ||
               m30 || m31 || m32 || m33
          mat = m00
          @m00 = mat.mm00;@m01 = mat.mm01;@m02 = mat.mm02;@m03 = mat.mm03;
          @m10 = mat.mm10;@m11 = mat.mm11;@m12 = mat.mm12;@m13 = mat.mm13;
          @m20 = mat.mm20;@m21 = mat.mm21;@m22 = mat.mm22;@m23 = mat.mm23;
          @m30 = mat.mm30;@m31 = mat.mm31;@m32 = mat.mm32;@m33 = mat.mm33;
        else
          @m00,@m01,@m02,@m03 = m00,m01,m02,m03
          @m10,@m11,@m12,@m13 = m10,m11,m12,m13
          @m20,@m21,@m22,@m23 = m20,m21,m22,m23
          @m30,@m31,@m32,@m33 = m30,m31,m32,m33
        end
      end
      
      def set_identity
        @m00,@m01,@m02,@m03 = 1,0,0,0
        @m10,@m11,@m12,@m13 = 0,1,0,0
        @m20,@m21,@m22,@m23 = 0,0,1,0
        @m30,@m31,@m32,@m33 = 0,0,0,1
      end
      
      def set_zero
        @m00,@m01,@m02,@m03 = 0,0,0,0
        @m10,@m11,@m12,@m13 = 0,0,0,0
        @m20,@m21,@m22,@m23 = 0,0,0,0
        @m30,@m31,@m32,@m33 = 0,0,0,0
      end
      
      def set_scale scale
        @m00 *= scale; @m11 *= scale; @m22 *= scale; @m33 *= scale
      end
      
      def set_quat quat
        set_from_quat(quat.qx,quat.qy,quat.qz,quat.qw)
      end
      
      def set_axis axis
        set_from_axis_angle(axis.ax,axis.ay,axis.az,axis.angle)
      end
      
      def equals mat
        super &&       @m03 == mat.mm03 &&
                       @m13 == mat.mm13 &&
                       @m23 == mat.mm23 &&
        @m30 == mat.mm30 &&
        @m31 == mat.mm31 &&
        @m32 == mat.mm32 &&
        @m33 == mat.mm33 
      end
      
      def == mat;equals(mat);end
      
      def epsilon_equals mat,epsilon
        super                            &&
        ((m03 - mat.m03).abs <= epsilon) &&
        ((m13 - mat.m13).abs <= epsilon) &&
        ((m23 - mat.m23).abs <= epsilon) &&
        ((m30 - mat.m30).abs <= epsilon) &&
        ((m31 - mat.m31).abs <= epsilon) &&
        ((m32 - mat.m32).abs <= epsilon) &&
        ((m33 - mat.m33).abs <= epsilon)
      end
      
      def to_s
        [[@m00,@m01,@m02,@m03],
        [@m10,@m11,@m12,@m13],
        [@m20,@m21,@m22,@m23],
        [@m30,@m31,@m32,@m33]]
      end
    end
    
    
    class Matrix3##############################################################
      include Mat3

      
      def set_element row,col,value
        raise "" unless row < 3
        raise "" unless col < 3
        
        case row
        when 0
          case col
          when 0 then @m00 = value
          when 1 then @m01 = value
          when 2 then @m02 = value
          end
        when 1
          case col
          when 0 then @m10 = value
          when 1 then @m11 = value
          when 2 then @m12 = value
          end
        when 2
          case col
          when 0 then @m20 = value
          when 1 then @m21 = value
          when 2 then @m22 = value
          end
        end
      end
      
      def []= row,col,value;   set_element row,col,value;    end
      
      def get_element row,col
        raise "" unless row < 3
        raise "" unless col < 3
        
        case row
        when 0
          case col
          when 0 then @m00
          when 1 then @m01
          when 2 then @m02
          end
        when 1
          case col
          when 0 then @m10
          when 1 then @m11
          when 2 then @m12
          end
        when 2
          case col
          when 0 then @m20
          when 1 then @m21
          when 2 then @m22
          end
        end
      end
      
      def [] row,col;   get_element row,col;   end
      
      def set_row row,x,y=0,z=0
        raise "" unless row < 3
        
        if y == 0 && z == 0
          vec = x
          x,y,z = vec.vx,vec.vy,vec.vz
        end
        
        case row
        when 0
          @m00 = x
          @m01 = y
          @m02 = z
        when 1
          @m10 = x
          @m11 = y
          @m12 = z
        when 2
          @m20 = x
          @m21 = y
          @m22 = z
        end
      end
      
      def get_row row,vec
        raise "" unless row < 3
        
        case row
        when 0
          vec.vx = @m00
          vec.vy = @m01
          vec.vz = @m02
        when 1
          vec.vx = @m10
          vec.vy = @m11
          vec.vz = @m12
        when 2
          vec.vx = @m20
          vec.vy = @m21
          vec.vz = @m22
        end
        
        vec
      end
      
      def set_column col,x,y=0,z=0
        raise "" unless col < 3
        
        if y == 0 && z == 0
          vec = x
          x,y,z = vec.vx,vec.vy,vec.vz
        end
        
        case col
        when 0
          @m00 = x
          @m10 = y
          @m20 = z
        when 1
          @m01 = x
          @m11 = y
          @m21 = z
        when 2
          @m02 = x
          @m12 = y
          @m22 = z
        end
      end
      
      def get_column col,vec
        raise "" unless col < 3
        
        case col
        when 0
          vec.vx = @m00
          vec.vy = @m10
          vec.vz = @m20
        when 1
          vec.vx = @m01
          vec.vy = @m11
          vec.vz = @m21
        when 2
          vec.vx = @m02
          vec.vy = @m12
          vec.vz = @m22
        end
        
        vec
      end
      
      def add mat1=nil,mat2=nil
        unless mat2
          mat = mat1
          @m00 += mat.mm00;@m01 += mat.mm01;@m02 += mat.mm02;
          @m10 += mat.mm10;@m11 += mat.mm11;@m12 += mat.mm12;
          @m20 += mat.mm20;@m21 += mat.mm21;@m22 += mat.mm22;
        else
          set(
          mat1.mm00 + mat2.mm00,mat1.mm01 + mat2.mm01,mat1.mm02 + mat2.mm02,
          mat1.mm10 + mat2.mm10,mat1.mm11 + mat2.mm11,mat1.mm12 + mat2.mm12,
          mat1.mm20 + mat2.mm20,mat1.mm21 + mat2.mm21,mat1.mm22 + mat2.mm22
          )
        end
      end
      
      def sub mat1=nil,mat2=nil
        unless mat2
          mat = mat1
          @m00 -= mat.mm00;@m01 -= mat.mm01;@m02 -= mat.mm02;
          @m10 -= mat.mm10;@m11 -= mat.mm11;@m12 -= mat.mm12;
          @m20 -= mat.mm20;@m21 -= mat.mm21;@m22 -= mat.mm22;
        else
          set(
          mat1.mm00 - mat2.mm00,mat1.mm01 - mat2.mm01,mat1.mm02 - mat2.mm02,
          mat1.mm10 - mat2.mm10,mat1.mm11 - mat2.mm11,mat1.mm12 - mat2.mm12,
          mat1.mm20 - mat2.mm20,mat1.mm21 - mat2.mm21,mat1.mm22 - mat2.mm22
          )
        end
      end
      
      def mul mat1=nil,mat2=nil
        unless mat2
          mat = mat1
          mul(self,mat)
        else
          set(
          mat1.m00*mat2.m00 + mat1.m01*mat2.m10 + mat1.m02*mat2.m20,
          mat1.m00*mat2.m01 + mat1.m01*mat2.m11 + mat1.m02*mat2.m21,
          mat1.m00*mat2.m02 + mat1.m01*mat2.m12 + mat1.m02*mat2.m22,
          
          mat1.m10*mat2.m00 + mat1.m11*mat2.m10 + mat1.m12*mat2.m20,
          mat1.m10*mat2.m01 + mat1.m11*mat2.m11 + mat1.m12*mat2.m21,
          mat1.m10*mat2.m02 + mat1.m11*mat2.m12 + mat1.m12*mat2.m22,
          
          mat1.m20*mat2.m00 + mat1.m21*mat2.m10 + mat1.m22*mat2.m20,
          mat1.m20*mat2.m01 + mat1.m21*mat2.m11 + mat1.m22*mat2.m21,
          mat1.m20*mat2.m02 + mat1.m21*mat2.m12 + mat1.m22*mat2.m22
          )
        end
      end
      
      def transpose mat=nil
        unless mat
          @m01,@m10 = @m10,@m01
          @m02,@m20 = @m20,@m02
          @m12,@m21 = @m21,@m12
        else
          set mat
          transpose
        end
      end
      
      def invert mat=nil
        unless mat
          s = 1/determinant
          
          set(
          (@m11*@m22 - @m12*@m21)*s, (@m02*@m21 - @m01*@m22)*s, (@m01*@m12 - @m02*@m11)*s,
          (@m12*@m20 - @m10*@m22)*s, (@m00*@m22 - @m02*@m20)*s, (@m02*@m10 - @m00*@m12)*s,
          (@m10*@m21 - @m11*@m20)*s, (@m01*@m20 - @m00*@m21)*s, (@m00*@m11 - @m01*@m10)*s
          )
        else
          set mat
          invert
        end
      end
      
      def determinant
        @m00*(@m11*@m22 - @m21*@m12) - @m01*(@m10*@m22 - @m20*@m12) + @m02*(@m10*@m21 - @m20*@m11)
      end
      
      def mul_transpose_right; raise "not implement";end
      def mul_transpose_left; raise "not implement";end
      
      def transform; raise "not implement";end
      
      def negate
        @m00 = -@m00;@m01 = -@m01;@m02 = -@m02;
        @m10 = -@m10;@m11 = -@m11;@m12 = -@m12;
        @m20 = -@m20;@m21 = -@m21;@m22 = -@m22;
      end
      
      def rot_x angle
        s = sin angle
        c = cos angle
        
        @m00 =  1;@m01 =  0;@m02 =  0;
        @m10 =  0;@m11 =  c;@m12 = -s;
        @m20 =  0;@m21 =  s;@m22 =  c;
      end
      
      def rot_y angle
        s = snin angle
        c = cos angle
        
        @m00 =  c;@m01 =  0;@m02 =  s;
        @m10 =  0;@m11 =  1;@m12 =  0;
        @m20 = -s;@m21 =  0;@m22 =  c;
      end
      
      def rot_z angle
        s = snin angle
        c = cos angle
        
        @m00 =  c;@m01 = -s;@m02 =  0;
        @m10 =  s;@m11 =  c;@m12 =  0;
        @m20 =  0;@m21 =  0;@m22 =  1;
      end
      
      def svd
        s = get_scale
        
        rot = Matrix3.new
        
        #zero-div may occur.
        ###n = 1 / sqrt(m00*m00 + m10*m10 + m20*m20)
        ###rot->m00 = @m00*n
        ###rot->m10 = @m10*n
        ###rot->m20 = @m20*n
        ###  
        ###n = 1 / sqrt(m01*m01 + m11*m11 + m21*m21)
        ###rot->m01 = @m01*n
        ###rot->m11 = @m11*n
        ###rot->m21 = @m21*n
        ###  
        ###n = 1 / sqrt(m02*m02 + m12*m12 + m22*m22)
        ###rot->m02 = @m02*n
        ###rot->m12 = @m12*n
        ###rot->m22 = @m22*n
        
        s
      end

      def set_from_quat x,y,z,w
        n = x*x+y*y+z*z+w*w
        s = (n > 0.0) ? 2.0/n : 0.0

        xs = x*s,  ys = y*s,  zs = z*s;
        wx = w*xs, wy = w*ys, wz = w*zs;
        xx = x*xs, xy = x*ys, xz = x*zs;
        yy = y*ys, yz = y*zs, zz = z*zs;

        @m00 = 1.0 - (yy + zz); @m01 = xy - wz;         @m02 = xz + wy;
        @m10 = xy + wz;         @m11 = 1.0 - (xx + zz); @m12 = yz - wx;
        @m20 = xz - wy;         @m21 = yz + wx;         @m22 = 1.0 - (xx + yy);
      end

      def set_from_axis_angle; "not implement"; end
    end
    
    class Matrix4 < Matrix3####################################################
      include Mat4
      def set_identity
        super();       @m03 = 0
                       @m13 = 0
                       @m23 = 0
        @m30,@m31,@m32,@m33 = 0,0,0,1
      end
      
      def set_zero
        super();       @m03 = 0
                       @m13 = 0
                       @m23 = 0
        @m30,@m31,@m32,@m33 = 0,0,0,0
      end
      
      def set_scale scale
        super(scale)
        @m33 *= scale
      end
      
      def set_element row,col,value
        raise "" unless row < 4
        raise "" unless col < 4
        
        case row
        when 0
          case col
          when 0 then @m00 = value
          when 1 then @m01 = value
          when 2 then @m02 = value
          when 3 then @m03 = value
          end
        when 1
          case col
          when 0 then @m10 = value
          when 1 then @m11 = value
          when 2 then @m12 = value
          when 3 then @m13 = value
          end
        when 2
          case col
          when 0 then @m20 = value
          when 1 then @m21 = value
          when 2 then @m22 = value
          when 3 then @m23 = value
          end
        when 3
          case col
          when 0 then @m30 = value
          when 1 then @m31 = value
          when 2 then @m32 = value
          when 3 then @m33 = value
          end
        end
      end
      
      
      def []= row,col,value;   set_element row,col,value;    end
      
      def get_element row,col
        raise "" unless row < 4
        raise "" unless col < 4
        
        case row
        when 0
          case col
          when 0 then @m00
          when 1 then @m01
          when 2 then @m02
          when 3 then @m03
          end
        when 1
          case col
          when 0 then @m10
          when 1 then @m11
          when 2 then @m12
          when 3 then @m13
          end
        when 2
          case col
          when 0 then @m20
          when 1 then @m21
          when 2 then @m22
          when 3 then @m23
          end
        when 3
          case col
          when 0 then @m30
          when 1 then @m31
          when 2 then @m32
          when 3 then @m33
          end
        end
      end
      
      def [] row,col;   get_element row,col;   end
      
      
      def set_row row,x,y=0,z=0,w=0
        raise "" unless row < 4
        
        if y == 0 && z == 0 && w == 0
          vec = x
          x,y,z,w = vec.vx,vec.vy,vec.vz,vec.vw
        end
        
        case row
        when 0
          @m00 = x
          @m01 = y
          @m02 = z
          @m03 = w
        when 1
          @m10 = x
          @m11 = y
          @m12 = z
          @m13 = w
        when 2
          @m20 = x
          @m21 = y
          @m22 = z
          @m23 = w
        when 3
          @m30 = x
          @m31 = y
          @m32 = z
          @m33 = w
        end
      end
      
      def get_row row,vec
        raise "" unless row < 4
        
        case row
        when 0
          vec.vx = @m00
          vec.vy = @m01
          vec.vz = @m02
          vec.vw = @m03
        when 1
          vec.vx = @m10
          vec.vy = @m11
          vec.vz = @m12
          vec.vw = @m13
        when 2
          vec.vx = @m20
          vec.vy = @m21
          vec.vz = @m22
          vec.vw = @m23
        when 3
          vec.vx = @m30
          vec.vy = @m31
          vec.vz = @m32
          vec.vw = @m33
        end
        
        vec
      end
      
      def set_column col,x,y=0,z=0,w=0
        raise "" unless col < 4
        
        if y == 0 && z == 0 && w == 0
          vec = x
          x,y,z,w = vec.vx,vec.vy,vec.vz,vec.vw
        end
        
        case col
        when 0
          @m00 = x
          @m10 = y
          @m20 = z
          @m30 = w
        when 1
          @m01 = x
          @m11 = y
          @m21 = z
          @m31 = w
        when 2
          @m02 = x
          @m12 = y
          @m22 = z
          @m32 = w
        when 3
          @m03 = x
          @m13 = y
          @m23 = z
          @m33 = w
        end
      end
      
      def get_column col,vec
        raise "" unless col < 4
        
        case col
        when 0
          vec.vx = @m00
          vec.vy = @m10
          vec.vz = @m20
          vec.vw = @m30
        when 1
          vec.vx = @m01
          vec.vy = @m11
          vec.vz = @m21
          vec.vw = @m31
        when 2
          vec.vx = @m02
          vec.vy = @m12
          vec.vz = @m22
          vec.vw = @m32
        when 3
          vec.vx = @m03
          vec.vy = @m13
          vec.vz = @m23
          vec.vw = @m33
        end
        
        vec
      end
      
      def add mat1=nil,mat2=nil
        unless mat2
          mat = mat1
          @m00 += mat.mm00;@m01 += mat.mm01;@m02 += mat.mm02;@m03 += mat.mm03;
          @m10 += mat.mm10;@m11 += mat.mm11;@m12 += mat.mm12;@m13 += mat.mm13;
          @m20 += mat.mm20;@m21 += mat.mm21;@m22 += mat.mm22;@m23 += mat.mm23;
          @m30 += mat.mm30;@m31 += mat.mm31;@m32 += mat.mm32;@m33 += mat.mm33;
        else
          set(
          mat1.mm00 + mat2.mm00,mat1.mm01 + mat2.mm01,mat1.mm02 + mat2.mm02,mat1.mm03 + mat2.mm03,
          mat1.mm10 + mat2.mm10,mat1.mm11 + mat2.mm11,mat1.mm12 + mat2.mm12,mat1.mm13 + mat2.mm13,
          mat1.mm20 + mat2.mm20,mat1.mm21 + mat2.mm21,mat1.mm22 + mat2.mm22,mat1.mm23 + mat2.mm23,
          mat1.mm30 + mat2.mm30,mat1.mm31 + mat2.mm31,mat1.mm32 + mat2.mm32,mat1.mm33 + mat2.mm33
          )
        end
      end
      
      def sub mat1=nil,mat2=nil
        unless mat2
          mat = mat1
          @m00 -= mat.mm00;@m01 -= mat.mm01;@m02 -= mat.mm02;@m03 -= mat.mm03;
          @m10 -= mat.mm10;@m11 -= mat.mm11;@m12 -= mat.mm12;@m13 -= mat.mm13;
          @m20 -= mat.mm20;@m21 -= mat.mm21;@m22 -= mat.mm22;@m23 -= mat.mm23;
          @m30 -= mat.mm30;@m31 -= mat.mm31;@m32 -= mat.mm32;@m33 -= mat.mm33;
        else
          set(
          mat1.mm00 - mat2.mm00,mat1.mm01 - mat2.mm01,mat1.mm02 - mat2.mm02,mat1.mm03 - mat2.mm03,
          mat1.mm10 - mat2.mm10,mat1.mm11 - mat2.mm11,mat1.mm12 - mat2.mm12,mat1.mm13 - mat2.mm13,
          mat1.mm20 - mat2.mm20,mat1.mm21 - mat2.mm21,mat1.mm22 - mat2.mm22,mat1.mm23 - mat2.mm23,
          mat1.mm30 - mat2.mm30,mat1.mm31 - mat2.mm31,mat1.mm32 - mat2.mm32,mat1.mm33 - mat2.mm33
          )
        end
      end
      
      def mul mat1=nil,mat2=nil
        unless mat2
          mat = mat1
          mul(self,mat)
        else
          set(
	    mat1.mm00*mat2.mm00 + mat1.mm01*mat2.mm10 + mat1.mm02*mat2.mm20 + mat1.mm03*mat2.mm30,
	    mat1.mm00*mat2.mm01 + mat1.mm01*mat2.mm11 + mat1.mm02*mat2.mm21 + mat1.mm03*mat2.mm31,
	    mat1.mm00*mat2.mm02 + mat1.mm01*mat2.mm12 + mat1.mm02*mat2.mm22 + mat1.mm03*mat2.mm32,
	    mat1.mm00*mat2.mm03 + mat1.mm01*mat2.mm13 + mat1.mm02*mat2.mm23 + mat1.mm03*mat2.mm33,

	    mat1.mm10*mat2.mm00 + mat1.mm11*mat2.mm10 + mat1.mm12*mat2.mm20 + mat1.mm13*mat2.mm30,
	    mat1.mm10*mat2.mm01 + mat1.mm11*mat2.mm11 + mat1.mm12*mat2.mm21 + mat1.mm13*mat2.mm31,
	    mat1.mm10*mat2.mm02 + mat1.mm11*mat2.mm12 + mat1.mm12*mat2.mm22 + mat1.mm13*mat2.mm32,
	    mat1.mm10*mat2.mm03 + mat1.mm11*mat2.mm13 + mat1.mm12*mat2.mm23 + mat1.mm13*mat2.mm33,

	    mat1.mm20*mat2.mm00 + mat1.mm21*mat2.mm10 + mat1.mm22*mat2.mm20 + mat1.mm23*mat2.mm30,
	    mat1.mm20*mat2.mm01 + mat1.mm21*mat2.mm11 + mat1.mm22*mat2.mm21 + mat1.mm23*mat2.mm31,
	    mat1.mm20*mat2.mm02 + mat1.mm21*mat2.mm12 + mat1.mm22*mat2.mm22 + mat1.mm23*mat2.mm32,
	    mat1.mm20*mat2.mm03 + mat1.mm21*mat2.mm13 + mat1.mm22*mat2.mm23 + mat1.mm23*mat2.mm33,

	    mat1.mm30*mat2.mm00 + mat1.mm31*mat2.mm10 + mat1.mm32*mat2.mm20 + mat1.mm33*mat2.mm30,
	    mat1.mm30*mat2.mm01 + mat1.mm31*mat2.mm11 + mat1.mm32*mat2.mm21 + mat1.mm33*mat2.mm31,
	    mat1.mm30*mat2.mm02 + mat1.mm31*mat2.mm12 + mat1.mm32*mat2.mm22 + mat1.mm33*mat2.mm32,
	    mat1.mm30*mat2.mm03 + mat1.mm31*mat2.mm13 + mat1.mm32*mat2.mm23 + mat1.mm33*mat2.mm33
          )
        end
      end
      
      def transpose mat=nil
        unless mat
          @m01,@m10 = @m10,@m01
          @m02,@m20 = @m20,@m02
          @m03,@m30 = @m30,@m03
          @m12,@m21 = @m21,@m12
          @m13,@m31 = @m31,@m13
          @m23,@m32 = @m32,@m23
        else
          set mat
          transpose
        end
      end
      
      def invert mat=nil
        unless mat
          s = 1/determinant
          
          return if s == 0.0
          
          set(
          (@m11*(@m22*@m33 - @m23*@m32) + @m12*(@m23*@m31 - @m21*@m33) + @m13*(@m21*@m32 - @m22*@m31))*s,
          (@m21*(@m02*@m33 - @m03*@m32) + @m22*(@m03*@m31 - @m01*@m33) + @m23*(@m01*@m32 - @m02*@m31))*s,
          (@m31*(@m02*@m13 - @m03*@m12) + @m32*(@m03*@m11 - @m01*@m13) + @m33*(@m01*@m12 - @m02*@m11))*s,
          (@m01*(@m13*@m22 - @m12*@m23) + @m02*(@m11*@m23 - @m13*@m21) + @m03*(@m12*@m21 - @m11*@m22))*s,
          
          (@m12*(@m20*@m33 - @m23*@m30) + @m13*(@m22*@m30 - @m20*@m32) + @m10*(@m23*@m32 - @m22*@m33))*s,
          (@m22*(@m00*@m33 - @m03*@m30) + @m23*(@m02*@m30 - @m00*@m32) + @m20*(@m03*@m32 - @m02*@m33))*s,
          (@m32*(@m00*@m13 - @m03*@m10) + @m33*(@m02*@m10 - @m00*@m12) + @m30*(@m03*@m12 - @m02*@m13))*s,
          (@m02*(@m13*@m20 - @m10*@m23) + @m03*(@m10*@m22 - @m12*@m20) + @m00*(@m12*@m23 - @m13*@m22))*s,
          
          (@m13*(@m20*@m31 - @m21*@m30) + @m10*(@m21*@m33 - @m23*@m31) + @m11*(@m23*@m30 - @m20*@m33))*s,
          (@m23*(@m00*@m31 - @m01*@m30) + @m20*(@m01*@m33 - @m03*@m31) + @m21*(@m03*@m30 - @m00*@m33))*s,
          (@m33*(@m00*@m11 - @m01*@m10) + @m30*(@m01*@m13 - @m03*@m11) + @m31*(@m03*@m10 - @m00*@m13))*s,
          (@m03*(@m11*@m20 - @m10*@m21) + @m00*(@m13*@m21 - @m11*@m23) + @m01*(@m10*@m23 - @m13*@m20))*s,
          
          (@m10*(@m22*@m31 - @m21*@m32) + @m11*(@m20*@m32 - @m22*@m30) + @m12*(@m21*@m30 - @m20*@m31))*s,
          (@m20*(@m02*@m31 - @m01*@m32) + @m21*(@m00*@m32 - @m02*@m30) + @m22*(@m01*@m30 - @m00*@m31))*s,
          (@m30*(@m02*@m11 - @m01*@m12) + @m31*(@m00*@m12 - @m02*@m10) + @m32*(@m01*@m10 - @m00*@m11))*s,
          (@m00*(@m11*@m22 - @m12*@m21) + @m01*(@m12*@m20 - @m10*@m22) + @m02*(@m10*@m21 - @m11*@m20))*s
          )
        else
          set mat
          invert
        end
      end
      
      def determinant
        ((@m00*@m11 - @m01*@m10)*(@m22*@m33 - @m23*@m32)
        -(@m00*@m12 - @m02*@m10)*(@m21*@m33 - @m23*@m31)
        +(@m00*@m13 - @m03*@m10)*(@m21*@m32 - @m22*@m31)
        +(@m01*@m12 - @m02*@m11)*(@m20*@m33 - @m23*@m30)
        -(@m01*@m13 - @m03*@m11)*(@m20*@m32 - @m22*@m30)
        +(@m02*@m13 - @m03*@m12)*(@m20*@m31 - @m21*@m30))
      end
      
      def rot_x angle
        s = sin angle
        c = cos angle
        
        @m00 =  1;@m01 =  0;@m02 =  0; @m03 = 0
        @m10 =  0;@m11 =  c;@m12 = -s; @m13 = 0
        @m20 =  0;@m21 =  s;@m22 =  c; @m23 = 0
        @m20 =  0;@m21 =  0;@m22 =  0; @m23 = 0
      end
      
      def rot_y angle
        s = snin angle
        c = cos angle
        
        @m00 =  c;@m01 =  0;@m02 =  s; @m03 = 0
        @m10 =  0;@m11 =  1;@m12 =  0; @m13 = 0
        @m20 = -s;@m21 =  0;@m22 =  c; @m23 = 0
        @m20 =  0;@m21 =  0;@m22 =  0; @m23 = 0
      end
      
      def rot_z angle
        s = snin angle
        c = cos angle
        
        @m00 =  c;@m01 = -s;@m02 =  0; @m03 = 0
        @m10 =  s;@m11 =  c;@m12 =  0; @m13 = 0
        @m20 =  0;@m21 =  0;@m22 =  1; @m23 = 0
        @m20 =  0;@m21 =  0;@m22 =  0; @m23 = 0
      end
      
      def set_from_quat x,y,z,w
        n = x*x+y*y+z*z+w*w
        s = (n > 0.0) ? 2.0/n : 0.0

        xs = x*s,  ys = y*s,  zs = z*s;
        wx = w*xs, wy = w*ys, wz = w*zs;
        xx = x*xs, xy = x*ys, xz = x*zs;
        yy = y*ys, yz = y*zs, zz = z*zs;
        
        set_identity
        
        @m00 = 1.0 - (yy + zz); @m01 = xy - wz;         @m02 = xz + wy;
        @m10 = xy + wz;         @m11 = 1.0 - (xx + zz); @m12 = yz - wx;
        @m20 = xz - wy;         @m21 = yz + wx;         @m22 = 1.0 - (xx + yy);
      end
    end
    
  end
end


if __FILE__ == $0
  require 'vector'
  require 'quaternion'
  require 'test/unit'
  

  include Rubyx::Vecmath
  include Math
  
  class TestMatrix3 < Test::Unit::TestCase
    def setup
      @m0 = Matrix3.new(1,2,3,4,5,6,7,8,9)
      @m0.set_zero
      @m1 = Matrix3.new()
      @m2 = Matrix3.new(1,2,3,4,5,6,7,8,9)
      @mi = Matrix3.new
      @mi.set_identity
    end
    
    def test_equals
      assert_equal(true,@m0.equals(@m1))
      assert_equal(false,@m0.equals(@m2))
      assert_equal(false,@mi.equals(@m2))
    end
    
    def test_alias_equals
      assert_equal(true,@m0 == @m1)
      assert_equal(false,@m0 == @m2)
      assert_equal(false,@mi == @m2)
    end
    
    def test_set_scale
      @m2.set_scale 3
      assert_equal(3,  @m2.m00)
      assert_equal(15, @m2.m11)
      assert_equal(27, @m2.m22)
    end
    
    def test_set_quat
    end
    
    def test_set_axis
    end
    
    def test_set_element_and_get_element
      3.times{|r|
        3.times{|c|
          assert_equal(((r*3)+(c+1)) ,@m2.get_element(r,c))
          @m2.set_element(r,c,(2+r*3+c*5))
          assert_equal((2+r*3+c*5) ,@m2.get_element(r,c))
        }
      }
      
      3.times{|r|
        3.times{|c|
          assert_equal((2+r*3+c*5) ,@m2[r,c] )
          @m2[r,c] = (3+r*5+c*7)
          assert_equal((3+r*5+c*7) ,@m2[r,c] )
        }
      }
    end
    
    def test_add
      m1 = Matrix3.new
      m1.add(@m1,@m2)
      @m1.add(@m2)
      
      assert_equal(1,@m1.m00);   assert_equal(1,m1.m00)
      assert_equal(2,@m1.m01);   assert_equal(2,m1.m01)
      assert_equal(3,@m1.m02);   assert_equal(3,m1.m02)
      assert_equal(4,@m1.m10);   assert_equal(4,m1.m10)
      assert_equal(5,@m1.m11);   assert_equal(5,m1.m11)
      assert_equal(6,@m1.m12);   assert_equal(6,m1.m12)
      assert_equal(7,@m1.m20);   assert_equal(7,m1.m20)
      assert_equal(8,@m1.m21);   assert_equal(8,m1.m21)
      assert_equal(9,@m1.m22);   assert_equal(9,m1.m22)
    end
    
    def test_transpose
      @m1.transpose(@m2)
      @m2.transpose
      
      assert_equal(1,@m1.m00)
      assert_equal(4,@m1.m01)
      assert_equal(7,@m1.m02)
      assert_equal(2,@m1.m10)
      assert_equal(5,@m1.m11)
      assert_equal(8,@m1.m12)
      assert_equal(3,@m1.m20)
      assert_equal(6,@m1.m21)
      assert_equal(9,@m1.m22)
      
      assert_equal(1,@m2.m00)
      assert_equal(4,@m2.m01)
      assert_equal(7,@m2.m02)
      assert_equal(2,@m2.m10)
      assert_equal(5,@m2.m11)
      assert_equal(8,@m2.m12)
      assert_equal(3,@m2.m20)
      assert_equal(6,@m2.m21)
      assert_equal(9,@m2.m22)
    end
    
    def test_sub
      m1 = Matrix3.new
      m1.sub(@m1,@m2)
      @m1.sub(@m2)
      
      assert_equal(-1,@m1.m00);   assert_equal(-1,@m1.m00)
      assert_equal(-2,@m1.m01);   assert_equal(-2,@m1.m01)
      assert_equal(-3,@m1.m02);   assert_equal(-3,@m1.m02)
      assert_equal(-4,@m1.m10);   assert_equal(-4,@m1.m10)
      assert_equal(-5,@m1.m11);   assert_equal(-5,@m1.m11)
      assert_equal(-6,@m1.m12);   assert_equal(-6,@m1.m12)
      assert_equal(-7,@m1.m20);   assert_equal(-7,@m1.m20)
      assert_equal(-8,@m1.m21);   assert_equal(-8,@m1.m21)
      assert_equal(-9,@m1.m22);   assert_equal(-9,@m1.m22)
    end
    
    def test_mul
      @m2.mul(@mi)
      
      assert_equal(1,@m2.m00)
      assert_equal(2,@m2.m01)
      assert_equal(3,@m2.m02)
      assert_equal(4,@m2.m10)
      assert_equal(5,@m2.m11)
      assert_equal(6,@m2.m12)
      assert_equal(7,@m2.m20)
      assert_equal(8,@m2.m21)
      assert_equal(9,@m2.m22)
    end
    
    def test_set_and_get_row
      (0..2).each{|row|
        vec1 = Vector3.new(1*row,2*row,3*row)
        vec2 = Vector3.new
        @m2.set_row(row,vec1)
        @m2.get_row(row,vec2)
        assert_equal(true,vec1.equals(vec2))
      }
    end
    
    def test_set_and_get_column
      (0..2).each{|col|
        vec1 = Vector3.new(3*col,2*col,1*col)
        vec2 = Vector3.new
        @m2.set_column(col,vec1)
        @m2.get_column(col,vec2)
        assert_equal(true,vec1.equals(vec2))
      }
    end
    
    def test_invert
      m = @mi.clone
      m.invert
      
      assert_equal(true,@mi.equals(m))
      assert_equal(true,m.equals(@mi))
    end

  end
  
  class TestMatrix4 < Test::Unit::TestCase
    def setup
      @m0 = Matrix4.new(1,2,3,4,
                        5,6,7,8,
                        9,10,11,12,
                        13,14,15,16)
      @m0.set_zero
      @m1 = Matrix4.new
      @m2 = Matrix4.new(1,2,3,4,
                        5,6,7,8,
                        9,10,11,12,
                        13,14,15,16)
      @mi = @m2.clone
      @mi.set_identity
    end
    
    def test_add
      m = Matrix4.new
      m.add(@m0,@m2)
      
      assert_equal(1,m.m00);assert_equal(2,m.m01);assert_equal(3,m.m02);assert_equal(4,m.m03);
      assert_equal(5,m.m10);assert_equal(6,m.m11);assert_equal(7,m.m12);assert_equal(8,m.m13);
      assert_equal(9,m.m20);assert_equal(10,m.m21);assert_equal(11,m.m22);assert_equal(12,m.m23);
      assert_equal(13,m.m30);assert_equal(14,m.m31);assert_equal(15,m.m32);assert_equal(16,m.m33);
    end
    
    def test_sub
      m = @m2.clone
      m.sub(@m2)
      
      assert_equal(0,m.m00);assert_equal(0,m.m01);assert_equal(0,m.m02);assert_equal(0,m.m03);
      assert_equal(0,m.m10);assert_equal(0,m.m11);assert_equal(0,m.m12);assert_equal(0,m.m13);
      assert_equal(0,m.m20);assert_equal(0,m.m21);assert_equal(0,m.m22);assert_equal(0,m.m23);
      assert_equal(0,m.m30);assert_equal(0,m.m31);assert_equal(0,m.m32);assert_equal(0,m.m33);
    end
    
    def test_mul
      m = Matrix4.new
      m.set_identity
      m.mul(@m2)
      
      assert_equal(1,m.m00);assert_equal(2,m.m01);assert_equal(3,m.m02);assert_equal(4,m.m03);
      assert_equal(5,m.m10);assert_equal(6,m.m11);assert_equal(7,m.m12);assert_equal(8,m.m13);
      assert_equal(9,m.m20);assert_equal(10,m.m21);assert_equal(11,m.m22);assert_equal(12,m.m23);
      assert_equal(13,m.m30);assert_equal(14,m.m31);assert_equal(15,m.m32);assert_equal(16,m.m33);
    end
    
    def test_set_and_get_row
      (0..3).each{|row|
        vec1 = Vector4.new(1*row,2*row,3*row,4*row)
        vec2 = Vector4.new
        @m2.set_row(row,vec1)
        @m2.get_row(row,vec2)
        assert_equal(true,vec1.equals(vec2))
      }
    end
    
    def test_set_and_get_column
      (0..3).each{|col|
        vec1 = Vector4.new(4*col,3*col,2*col,1*col)
        vec2 = Vector4.new
        @m2.set_column(col,vec1)
        @m2.get_column(col,vec2)
        assert_equal(true,vec1.equals(vec2))
      }
    end
  end
end
