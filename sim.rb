require 'gosu'
require './particle'
class SimWindow < Gosu::Window
  @@w = 640
  @@h = 480

  attr_reader :t, :particles
  private :t, :particles

  def initialize(n)
    super @@w, @@h
    self.caption = 'Ruby :: Gosu :: Gravity'
    @t = 0.05
    @particles = generate_particles(n)
  end

  def generate_particles(n)
    Array.new(n) { random_particle }
  end

  private

  def update
    particles.each(&:update)
  end

  def draw
    particles.each(&:draw)
  end

  def random_initial_status
    # initial position
    x = prng.rand(@@w)
    y = prng.rand(@@h)
    # initial velocity
    vx = (-1)**x*prng.rand(30)
    vy = (-1)**y*prng.rand(30)
    # initial acceleration
    ax = 0
    ay = 9.8
    # initial status
    [x, y, vx, vy, ax, ay]
  end

  def prng
    @prng ||= Random.new
  end

  def random_particle
    Particle.new(random_initial_status, self, t)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

if __FILE__ == $0
  DEFAULT = 10

  def nvl(val, default, method)
    if val.nil?
      default
    else
      val.send(method)
    end
  end

  def number_of_particles
    nvl(ARGV[0], DEFAULT, :to_i)
  end

  SimWindow.new(number_of_particles).show
end
