import os

from basquiat.render import Renderer
from basquiat.utils import rand

# Random Walk

def random_walk(num_walkers=5, filename="out.png"):
    size = 500
    r = Renderer(size)

    for n in range(num_walkers):
        x = size/2
        y = size/2
        border = 50
        step_back = 5
        for i in range(5000):
            prevx = x
            prevy = y
            randx = rand(1, -3, 3)
            if (x+randx) >= (size-border):
                x -= randx * step_back
            elif (x+randx) <= border:
                x -= randx * step_back
            else:
                x += randx

            randy = rand(1, -3, 3)
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
    num_pieces = 10
    for i in range(num_pieces):
        random_walk(filename=os.path.join(root_folder, f"rw_{i}.png"))