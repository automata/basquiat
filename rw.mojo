import math
from random import random_float64
from basquiat.render import Renderer

fn random_walk(num_walkers: Int=5, filename: String="rw.png") raises:
    let size = 1024
    let border = 50
    let step_back = 5
    let r = Renderer(size, size)
    r.clear_canvas(0, 0, 0)
    r.line_width(0.001)

    for n in range(num_walkers):
        var x = size/2
        var y = size/2
        var prevx = x
        var prevy = y
        r.color(random_float64(0, 1), random_float64(0, 1), random_float64(0, 1), random_float64(0, 0.5))

        for i in range(20000):

            let randx = random_float64(-5, 5)
            if (x+randx) >= (size-border):
                x -= randx * step_back
            elif (x+randx) <= border:
                x -= randx * step_back
            else:
                x += randx

            let randy = random_float64(-5, 5)
            if (y+randy) >= (size-border):
                y -= randy * step_back
            elif (y+randy) <= border:
                y -= randy * step_back
            else:
                y += randy

            r.line(prevx/size, prevy/size, x/size, y/size)
            prevx = x
            prevy = y
        r.stroke()
    r.to_png(filename)

fn main() raises:
  random_walk(20)

