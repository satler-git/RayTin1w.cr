# TODO: Write documentation for `Raytin1w`

#ppmfileのテスト
def ppmtest()
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


  ppmtest()
  # TODO: Put your code here
end
