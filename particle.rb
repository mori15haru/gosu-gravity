require 'gosu'
class Particle
  attr_accessor :x, :y, :vx, :vy
  attr_reader :ax, :ay, :x_boundry, :y_boundry, :t, :colour, :size

  def initialize(initial_status, window, t)
    # given status
    @x, @y, @vx, @vy, @ax, @ay = initial_status
    @x_boundry = window.width
    @y_boundry = window.height
    @t = t
    # fixed status
    @colour = Gosu::Color.new(*random_colour)
    @size = 10
  end

  def update
    update_velocity
    update_position
    boundry_check
  end

  def draw
    Gosu::draw_rect(x, y, size, size, colour)
  end

  private

  def boundry_check
    x_boundry_check
    y_boundry_check
  end

  def update_velocity
    @vx += ax * t
    @vy += ay * t
  end

  def update_position
    @x += vx * t
    @y += vy * t
  end

  def x_outside_boundry?
    x < 0 || x > x_boundry
  end

  def y_outside_boundry?
    y < 0 || y > y_boundry
  end

  def x_boundry_check
    if x_outside_boundry?
      # velocity_resolution
      @vx = -@vx
      # position resolution
      if x < 0
        @x = -@x
      else
        @x = 2 * x_boundry - x
      end
    end
  end

  def y_boundry_check
    if y_outside_boundry?
      # velocity_resolution
      @vy = -@vy
      # position resolution
      if y < 0
        @y = -@y
      else
        @y = 2 * y_boundry - y
      end
    end
  end

  def random_colour
    Array.new(4) { prng.rand(0..255) }
  end

  def prng
    @prng ||= Random.new
  end
end
