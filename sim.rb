require 'gosu'
require './planet'

class SimWindow < Gosu::Window
  @@w = 1000
  @@h = 1000

  attr_reader :t, :planets
  private :t, :planets

  def initialize
    super @@w, @@h
    self.caption = 'Ruby :: Gosu :: Gravity :: Orbit'

    @dwarf = Planet.new(dwarf_initial_status)
    @giant = Planet.new(giant_initial_status)

    @planets = [@dwarf, @giant]

    @dwarf.other = @giant
    @giant.other = @dwarf
  end

  private

  def t
    0.1
  end

  def g
    400.0
  end

  def dwarf_initial_status
    pos = Vec.new([100,490,0])
    p = -Vec.new([0,0.2,0.0])*5.0
    r = 0.04
    m = 1.0

    size = 5
    colour = Gosu::Color::YELLOW

    [pos, p, r, t, m, g, size, colour]
  end

  def giant_initial_status
    pos = Vec.new([500,500,0])
    p = Vec.new([0,0.2,0.0])*5.0
    r = 0.075
    m = 5.0

    size = 10
    colour = Gosu::Color::WHITE

    [pos, p, r, t, m, g, size, colour]
  end

  def update
    planets.each(&:update)
  end

  def draw
    planets.each(&:draw)
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end
end

if __FILE__ == $0
  SimWindow.new.show
end
