class Vec
  #.x
  #.y
  #.z
  attr_accessor :x, :y, :z, :arr

  def initialize(arr)
    @arr = arr
    @x, @y, @z = arr
  end
  # -A
  def -@
    self*-1
  end
  # A + B
  def +(other)
    Vec.new(arr.zip(other.arr).map{|i,j| i+j})
  end
  # A - B
  def -(other)
    self + (-other)
  end
  # A * B
  # A * k
  def *(other)
    if other.is_a?(Numeric)
      Vec.new(arr.map{|e| e*other})
    elsif other.is_a?(Vec)
      Vec.new(arr.zip(other.arr).map{|i,j| i*j})
    end
  end
  # A/k
  def /(other)
    Vec.new(arr.map{|e| e/other.to_f})
  end
  # |A|
  def abs
    Math::sqrt(square_length)
  end
  alias_method :length, :abs
  # A .* B
  def inner_prod(other)
    arr.zip(other.arr).map{|i,j| i*j}.inject(:+)
  end
  # A X B
  def outer_prod(other)
    a =  y*other.z - z*other.y
    b = -x*other.z + z*other.x
    c =  x*other.y - y*other.x

    Vec.new([a,b,c])
  end
  # |A|**2
  def square_length
    inner_prod(self)
  end
end
