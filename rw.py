import os

from basquiat.render import Renderer
from basquiat.utils import rand

# Random Walk

def random_walk(num_walkers=10, filename="out.png"):
    size = 1024
    border = 50
    step_back = 5
    r = Renderer(size, size)
    r.line_width(0.001)
    for n in range(num_walkers):
        x = size/2
        y = size/2
        r.color(rand(1, 0., 1.), rand(1, 0, 1), rand(1, 0, 1), rand(1, 0, 1))
        for i in range(20000):
            prevx = x
            prevy = y
            randx = rand(1, -5, 5)
            if (x+randx) >= (size-border):
                x -= randx * step_back
            elif (x+randx) <= border:
                x -= randx * step_back
            else:
                x += randx

            randy = rand(1, -5, 5)
            if (y+randy) >= (size-border):
                y -= randy * step_back
            elif (y+randy) <= border:
                y -= randy * step_back
            else:
                y += randy

            r.line(prevx/size, prevy/size, x/size, y/size)
    r.to_png(filename)

if __name__ == "__main__":
    root_folder = "./out"
    if not os.path.exists(root_folder):
        os.mkdir(root_folder)
    num_pieces = 1
    for i in range(num_pieces):
        random_walk(filename=os.path.join(root_folder, f"rw_{i}.png"))