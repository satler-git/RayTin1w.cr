struct Float64
  def *(e : Vec3) : Vec3
    Vec3.new(e[0] * self, e[1] * self, e[2] * self)
  end
end

class Vec3
  #引数なしinit
  def initialize
    #init
    @e : Array(Float64) = [0.0, 0.0, 0.0]
  end
  #引数ありinit
  def initialize(e0 : Float64, e1 : Float64, e2 : Float64)
    @e = [e0, e1, e2]
  end

  def *(t : Float64) : Vec3
    Vec3.new(@e[0] * t, @e[1] * t, @e[2] * t)
  end

  def [](i : Int32) : Float64
    @e[i]
  end
end

# 使用例
v = Vec3.new(1.0, 2.0, 3.0)
t = 2.0

# v * t の形式で呼び出す
result1 = v * t
puts result1 # => Vec3(@x: 2.0, @y: 4.0, @z: 6.0)
# t * v の形式で呼び出す
result2 = t * v
puts result2 # => Vec3(@x: 2.0, @y: 4.0, @z: 6.0)