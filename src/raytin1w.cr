# インポート
require "math"
# 数学定数
require "./MathConst"
# 光と色と位置
require "./Vector"
require "./Ray"
# カメラ
require "./Camera"
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

  # 設定
  samples_per_pixel = 100
  max_depth = 50
  # 画像サイズの出力
  puts "P3\n#{image_width} #{image_height}\n255\n"

  # 世界を創る
  world = HittableList.new
  world.add(Sphere.new(Point3.new(0, 0, -1), 0.5, Lambertian.new(Color.new(0.7, 0.3, 0.3))))
  world.add(Sphere.new(Point3.new(0, -100.5, -1), 100, Lambertian.new(Color.new(0.8, 0.8, 0.0))))
  world.add(Sphere.new(Point3.new(1, 0, -1), 0.5, Metal.new(Color.new(0.8, 0.6, 0.2))))
  world.add(Sphere.new(Point3.new(-1, 0, -1), 0.5, Metal.new(Color.new(0.8, 0.8, 0.8))))

  cam = Camera.new

  # 高さ文繰り返す
  (image_height - 1).downto(0) do |j|
    # 残りのラインの出力
    STDERR.puts "\rScanlines remaining: #{j}"
    # 横幅分繰り返す
    image_width.times do |i|
      # サンプリング
      pixel_color = Color.new(0, 0, 0)
      samples_per_pixel.times do |_|
        u = (i + random_double()) / (image_width - 1)
        v = (j + random_double()) / (image_height - 1)

        r = cam.get_ray(u, v)
        pixel_color += ray_color(r, world, max_depth)
      end
      write_color(pixel_color, samples_per_pixel)
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
