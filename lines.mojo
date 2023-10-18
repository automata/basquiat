import math
from random import random_float64
from basquiat.render import Renderer

@value
@register_passable("trivial")
struct Point:
  var x: Float64
  var y: Float64

fn draw_lines(filename: String="lines.png") raises:
  let size = 1024
  let r = Renderer(size, size)
  r.clear_canvas(0, 0, 0)
  let step = 30
  var points: DynamicVector[Point] = DynamicVector[Point](0)
  var n_points_per_line = 0
  var n_lines = 0

  for i in range(step*6, size - step, step):
    n_points_per_line = 0
    for j in range(step, size - step, step):
      let distance_to_center = math.abs(j - size / 2)
      let variance = math.max(size / 2 - 50 - distance_to_center, 0)
      let random = random_float64(0, 1) * variance / 2.5 * -1
      let point = Point((j+20) / size, (i + random) / size)
      points.push_back(point)
      n_points_per_line += 1
    n_lines += 1

  var w = 0.001
  var c = 0.5
  for i in range(n_lines):
    let first_point = points[i*n_points_per_line]
    r.line_width(w)
    w += 0.0001
    r.color(c, c, c)
    c += 0.01
    r.move_to(first_point.x, first_point.y)
    for j in range(5, n_points_per_line - 2):
      let mid_point_a = points[i*n_points_per_line + j]
      let mid_point_b = points[i*n_points_per_line + j + 1]
      let xc = (mid_point_a.x + mid_point_b.x) / 2
      let yc = (mid_point_a.y + mid_point_b.y) / 2
      r.curve_to(mid_point_a.x, mid_point_a.y, xc, yc, xc, yc)
    r.stroke()    
  r.to_png(filename)

fn main() raises:
  draw_lines()

