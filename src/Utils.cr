require "math"
require "random"

def random_double : Float64
  # ランダムな数を返す
  random = Random.new
  rand = random.rand
  rand
end

def random_double(min : Float64, max : Float64)
  min + (max - min)*random_double()
end

def clamp(x : Float64, min : Float64, max : Float64)
  if x < min
    return min
  elsif x > max
    return max
  else
    return x
  end
end

# 色のユーティリティ関数
def write_color(pixel_color : Color, samples_per_pixel : Int32)
  r = pixel_color.x
  g = pixel_color.y
  b = pixel_color.z

  scale = 1.0 / samples_per_pixel

  r = Math.sqrt(r * scale)
  g = Math.sqrt(g * scale)
  b = Math.sqrt(b * scale)

  color_space : Float64 = 256
  ir = (color_space * clamp(r, 0.0, 0.999)).round.to_i
  ig = (color_space * clamp(g, 0.0, 0.999)).round.to_i
  ib = (color_space * clamp(b, 0.0, 0.999)).round.to_i
  puts "#{ir} #{ig} #{ib} \n"
end
