require "math"
require "./MathConst"
require "./Vector"
require "./Ray"
require "./Camera"
require "./Hittable"
require "./Sphere"
require "./Utils"

# raytracer
# レイトレーシング用のメインメソッド
def raytracer(image_width : Int32)
  # 画像の大きさ
  # アスペクト比を計算
  aspect_ratio : Float64 = 16.0 / 9.0
  # アスペクト比から画像の高さを計算
  image_height : Int32 = (image_width / aspect_ratio).round.to_i
  # カメラ
  lookfrom = Point3.new(3, 3, 2)
  lookat = Point3.new(0, 0, -1)
  vup = Vec3.new(0, 1, 0)
  dist_to_focus = (lookfrom - lookat).length
  aperture = 2.0

  cam = Camera.new(lookfrom, lookat, vup, 20, aspect_ratio, aperture, dist_to_focus)

  # 設定
  samples_per_pixel = 100
  max_depth = 50
  # 画像サイズの出力
  puts "P3\n#{image_width} #{image_height}\n255\n"

  # マテリアルの作成
  material_ground = Lambertian.new(Color.new(0.8, 0.8, 0.0))
  material_center = Lambertian.new(Color.new(0.1, 0.2, 0.5))
  material_left = Dielectric.new(1.5)
  material_right = Metal.new(Color.new(0.8, 0.6, 0.2), 0.0)

  # 世界を創る
  world = HittableList.new
  world.add(Sphere.new(Point3.new(0.0, -100.5, -1.0), 100.0, material_ground))
  world.add(Sphere.new(Point3.new(0.0, 0.0, -1.0), 0.5, material_center))
  world.add(Sphere.new(Point3.new(-1.0, 0.0, -1.0), 0.5, material_left))
  world.add(Sphere.new(Point3.new(-1.0, 0.0, -1.0), -0.4, material_left))
  world.add(Sphere.new(Point3.new(1.0, 0.0, -1.0), 0.5, material_right))

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
