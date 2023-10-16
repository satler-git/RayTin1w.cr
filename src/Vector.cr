#インポート
require "math"


#3座標のベクトル型
class Vec3
  #ゲッターとセッター
  property e
  getter  e 

  #3座標のベクタークラスをinit
  #引数なしinit
  def initialize
    #init
    @e : Array(Float64) = [0.0, 0.0, 0.0]
  end
  #引数ありinit
  def initialize(e0 : Float64, e1 : Float64, e2 : Float64)
    @e = [e0, e1, e2]
  end
  #インデックスのベクトルとしての参照
  def x : Float64
    @e[0]
  end
  
  def y : Float64
    @e[1]
  end

  def z : Float64
    @e[2]
  end

  #オーバーロードの定義
  #負の数にする演算子のオーバーロード
  def - : Vec3
    Vec3.new(-@e[0], -@e[1], -@e[2])
  end

  #算術演算子の-
  def -(u : Vec3,v : Vec3) : Vec3
    Vec3.new(u.e[0] - v.e[0], u.e[1] - v.e[1], u.e[2] - v.e[2])
  end

  #算術演算子の+
  def +(u : Vec3,v : Vec3) : Vec3
    Vec3.new(u.e[0] + v.e[0], u.e[1] + v.e[1], u.e[2] + v.e[2])
  end

  #算術演算子の*
  def *(t : Float64,v : Vec3) : Vec3
    Vec3.new(t*v.e[0], t*v.e[1], t*v.e[2])
  end

  #上の*の逆の時用
  def *(v : Vec3,t : Float64) : Vec3
    t * v
  end

  #算術演算子の/
  def /(v : Vec3,t : Float64) : Vec3
    (1/t) * v
  end

  def [](i : Int32) : Float64
    @e[i]
  end

  #+=のかわりメソッド
  #add equal
  def ae(v : Vec3) : Vec3
    @e[0] = ae(v.e[0])
    @e[1] = ae(v.e[1])
    @e[2] = ae(v.e[2])
    self
  end
  # astarisq equal
  def ase(t : Float64) : Vec3
    @e[0] = ase(t)
    @e[1] = ase(t)
    @e[2] = ase(t)
    self
  end

  #slash equal
  def se(t : Float64) : Vec3
    ase(1/t)
  end

  #ユーティリティ関数
  #<<のオーバーロードのかわり
  def to_s(io)
    io << "#{@e[0]} #{@e[1]} #{@e[2]}"
  end

  def dot(u : Vec3,v : Vec3) : Float64
    u.e[0] * v.e[0] + u.e[1] * v.e[1] + u.e[2] * v.e[2]
  end

  def cross(u : Vec3,v : Vec3) : Vec3
    Vec3.new(u.e[1] * v.e[2] - u.e[2] * v.e[1],
    u.e[2] * v.e[0] - u.e[0] * v.e[2],
    u.e[0] * v.e[1] - u.e[1] * v.e[0])
  end

  def unit_vector(v : Vec3)
    v / v.length()
  end

  def length_squared() : Float64
    e[0]*e[0] + e[1]*e[1] + e[2]*e[2]
  end

  def length : Float64
    Math.sqrt(length_squared())
  end
end

alias Point3 = Vec3
alias Color = Vec3

def write_color(pixel_color : Color)
  color_space : Float64 = 255.999
  ir = (color_space * pixel_color.x()).round.to_i
  ig = (color_space * pixel_color.y()).round.to_i
  ib = (color_space * pixel_color.z()).round.to_i
  puts "#{ir} #{ig} #{ib} \n"
end
