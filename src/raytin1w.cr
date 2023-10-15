
#raytracer
#レイトレーシング用のメインメソッド

class Vec3
  
  #3座標のベクタークラスをinit
  def initialize
    #init
    @e : Array(Int32) = [0.0, 0.0, 0.0]
  end

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
  def - : Vec3
    Vec3.new(-@e[0], -@e[1], -@e[2])
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

  def length : Float64
    #return sqrt(length_squared());
    0.0
  end
end

def raytracer()
  #画像の大きさ
  image_width = 256
  image_height = 256

  #画像サイズの出力
  puts "P3\n#{image_width} #{image_height}\n255\n"
  
  #高さ文繰り返す
  (image_height - 1).downto(0) do |j|
    STDERR.puts "\rScanlines remaining: #{j} "
    STDERR.flush
    # 横幅分繰り返す
    image_width.times do |i|
      #色
      r = i.to_f / (image_width - 1)
      g = j.to_f / (image_height -1)
      b = 0.25

      ir = (255.999 * r).round.to_i
      ig = (255.999 * g).round.to_i
      ib = (255.999 * b).round.to_i
      # ChatGPTによると以下でも同じ処理。
      # ir, ig, ib = [r, g, b].map { |component| (255.999 * component).round.to_i }

      puts "#{ir} #{ig} #{ib} \n"
    end
  end
  STDERR.puts "\nDone.\n"
end

#メインモジュール
module Raytin1w
  VERSION = "0.1.0"

  def self.main
    raytracer()
  end

  self.main
end
