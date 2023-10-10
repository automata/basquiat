import math
import random
import numpy as np
import cairo

class Renderer:
    def __init__(self, width, height=None):
        self.width = width
        if not height:
            self.height = width
        self.surface = cairo.ImageSurface(cairo.FORMAT_ARGB32, self.width, self.height)
        self.ctx = cairo.Context(self.surface)
        # Normalize canvas
        self.ctx.scale(self.width, self.height)
        # Clear canvas
        self.ctx.set_source_rgb(1., 1. , 1.)
        self.ctx.rectangle(0, 0, 1, 1)
        self.ctx.fill()

    def to_png(self, file_name):
        self.surface.write_to_png(file_name)

    def line(self, x1, y1, x2, y2, r=.0, g=.0, b=.0, width=0.001):
        self.ctx.set_line_width(width)
        self.ctx.set_source_rgb(r, g , b)
        self.ctx.move_to(x1, y1)
        self.ctx.line_to(x2, y2)
        self.ctx.stroke()

    def circle(self, x, y, radius, r=.0, g=.0, b=.0, width=0.001, fill=False):
        self.ctx.set_line_width(width)
        self.ctx.set_source_rgb(r, g , b)
        self.ctx.arc(x, y, radius, 0, math.pi*2.0)
        if fill:
            self.ctx.fill()
        else:
            self.ctx.stroke()

    def linear_gradient(self):
        pat = cairo.LinearGradient(0.0, 0.0, 0.0, 1.0)
        pat.add_color_stop_rgba(1, 0.7, 0, 0, 0.5)  # First stop, 50% opacity
        pat.add_color_stop_rgba(0, 0.9, 0.7, 0.2, 1)  # Last stop, 100% opacity
        self.ctx.rectangle(0, 0, 1, 1)
        self.ctx.set_source(pat)
        self.ctx.fill()