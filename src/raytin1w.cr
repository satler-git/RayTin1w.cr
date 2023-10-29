require "math"
require "./MathConst"
require "./Vector"
require "./Ray"
require "./Camera"
require "./Hittable"
require "./Sphere"
require "./Utils"

def random_scene : HittableList
  world = HittableList.new
  ground_material = Lambertian.new(Color.new(0.5, 0.5, 0.5))
  world.add(Sphere.new(Point3.new(0, -1000, 0), 1000, ground_material))
  (-11..10).each do |a|
    (-11..10).each do |b|
      choose_mat = random_double()
      center = Point3.new(a + 0.9 * random_double(), 0.2, b + 0.9 * random_double())
      if (center - Vec3.new(4, 0.2, 0)).length > 0.9
        albedo = Color.new
        if choose_mat < 0.8
          albedo = Color.random * Color.random
          sphere_material = Lambertian.new(albedo)
          world.add(Sphere.new(center, 0.2, sphere_material))
        elsif choose_mat < 0.95
          albedo = Color.random(0.5, 1)
          fuzz = random_double(0, 0.5)
          sphere_material = Metal.new(albedo, fuzz)
          world.add(Sphere.new(center, 0.2, sphere_material))
        else
          sphere_material = Dielectric.new(1.5)
          world.add(Sphere.new(center, 0.2, sphere_material))
        end
      end
    end
  end
  material1 = Dielectric.new(1.5)
  material2 = Lambertian.new(Color.new(0.4, 0.2, 0.1))
  material3 = Metal.new(Color.new(0.7, 0.6, 0.5), 0.0)

  world.add(Sphere.new(Point3.new(0, 1, 0), 1.0, material1))
  world.add(Sphere.new(Point3.new(-4, 1, 0), 1.0, material2))
  world.add(Sphere.new(Point3.new(4, 1, 0), 1.0, material3))

  return world
end

# raytracer
# レイトレーシング用のメインメソッド
def raytracer(image_width : Int32)
  # 画像の大きさ
  # アスペクト比を計算
  aspect_ratio : Float64 = 16.0 / 9.0
  # アスペクト比から画像の高さを計算
  image_height : Int32 = (image_width / aspect_ratio).round.to_i
  # カメラ
  lookfrom = Point3.new(13, 2, 3)
  lookat = Point3.new(0, 0, 0)
  vup = Vec3.new(0, 1, 0)
  dist_to_focus = 10.0_f64
  aperture = 0.1_f64

  cam = Camera.new(lookfrom, lookat, vup, 20, aspect_ratio, aperture, dist_to_focus)

  # 設定
  samples_per_pixel = 100
  max_depth = 50
  # 画像サイズの出力
  puts "P3\n#{image_width} #{image_height}\n255\n"

  # 世界を創る
  world = random_scene()

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
    raytracer(1920)
  end

  self.main
end
