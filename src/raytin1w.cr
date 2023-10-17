#インポート
require "math"
require "./Vector"

#raytracer
#レイトレーシング用のメインメソッド
def raytracer(image_width : Int32, image_height : Int32)
  #画像の大きさ

  #画像サイズの出力
  puts "P3\n#{image_width} #{image_height}\n255\n"
  
  #高さ文繰り返す
  image_height.times do |j|
    STDERR.puts "\rScanlines remaining: #{j} "
    # 横幅分繰り返す
    image_width.times do |i|
      pixel_color : Color =  Color.new(i/(image_width - 1).to_f64, j/(image_height - 1).to_f64, 0.25)
      write_color(pixel_color)
    end
  end
  STDERR.puts "\nDone.\n"
end

#型エイリアス


#メインモジュール
module Raytin1w
  VERSION = "0.1.0"

  def self.main
    raytracer(256, 256)
  end

  self.main
end
