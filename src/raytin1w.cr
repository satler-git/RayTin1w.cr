# インポート
require "math"
# 数学定数
require "./MathConst"
# 光と色と位置
require "./Vector"
require "./Ray"
# 当たり判定
require "./Hittable"
require "./Sphere"
# ユーティリティ関数
require "./Utils"

# raytracer
# レイトレーシング用のメインメソッド
def raytracer(image_width : Int32)
  # 画像の大きさ
  # アスペクト比を計算
  aspect_ratio : Float64 = 16.0 / 9.0
  # アスペクト比から画像の高さを計算
  image_height : Int32 = (image_width / aspect_ratio).round.to_i
  # 画像サイズの出力
  puts "P3\n#{image_width} #{image_height}\n255\n"

  # 視線の高さ
  viewport_height : Float64 = 2.0
  viewport_width : Float64 = aspect_ratio * viewport_height
  focal_length : Float64 = 1.0

  # 原点
  origin = Point3.new(0, 0, 0)
  horizontal = Vec3.new(viewport_width, 0, 0)
  vertical = Vec3.new(0, viewport_height, 0)
  lower_left_corner = origin - horizontal/2 - vertical/2 - Vec3.new(0, 0, focal_length)
  # 世界を創る
  world = HittableList.new
  world.add(Sphere.new(Point3.new(0, 0, -1), 0.5))
  world.add(Sphere.new(Point3.new(0, -100.5, -1), 100))

  # 高さ文繰り返す
  (image_height - 1).downto(0) do |j|
    # 残りのラインの出力
    STDERR.puts "\rScanlines remaining: #{j}"
    # 横幅分繰り返す
    image_width.times do |i|
      u : Float64 = i.to_f64 / (image_width - 1).to_f64
      v : Float64 = j.to_f64 / (image_height - 1).to_f64

      r = Ray.new(origin, lower_left_corner + u*horizontal + v*vertical - origin)
      pixel_color : Color = ray_color(r, world)
      write_color(pixel_color)
    end
  end
  STDERR.puts "\nDone.\n"
end

# メインモジュール
module Raytin1w
  VERSION = "0.1.0"

  def self.main
    raytracer(384)
  end

  self.main
end
