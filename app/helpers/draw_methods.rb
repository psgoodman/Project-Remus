  SCREEN_WIDTH = 1028
  SCREEN_HEIGHT = 720


def convert_coords(ring, angle)
  complex = Complex.polar(ring, angle*2*Math::PI)
  x = complex.real * 100 + SCREEN_WIDTH/2
  y = complex.imag * 100 + SCREEN_HEIGHT/2
  [x,y]
end
