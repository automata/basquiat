from python import Python
from python.object import PythonObject

struct Renderer:
    var width: Int
    var height: Int
    var cairo: PythonObject
    var surface: PythonObject
    var ctx: PythonObject

    fn __init__(inout self, width: Int, height: Int) raises:
        self.width = width
        self.height = height
        let cairo = Python.import_module("cairo")
        self.cairo = cairo
        self.surface = cairo.ImageSurface(cairo.FORMAT_ARGB32, self.width, self.height)
        self.ctx = cairo.Context(self.surface)
        self.normalize_canvas()
        self.clear_canvas()

    fn normalize_canvas(self) raises:
        _ = self.ctx.scale(self.width, self.height)

    fn clear_canvas(self, r: Float64=1., g: Float64=1., b: Float64=1.) raises:
        _ = self.ctx.set_source_rgb(r, g , b)
        _ = self.ctx.rectangle(0, 0, 1, 1)
        _ = self.ctx.fill()

    fn to_png(self, file_name: String) raises:
        _ = self.surface.write_to_png(file_name)

    fn line(self, x1: Float64, y1: Float64, x2: Float64, y2: Float64, stroke: Bool = False, fill: Bool = False) raises:
        _ = self.ctx.move_to(x1, y1)
        _ = self.ctx.line_to(x2, y2)
        if stroke:
          _ = self.ctx.stroke()
        if fill:
          _ = self.ctx.fill()

    fn circle(self, x: Float64, y: Float64, radius: Float64, stroke: Bool = False, fill: Bool = False) raises:
        _ = self.ctx.arc(x, y, radius, 0, 3.14*2.0)
        if stroke:
          _ = self.ctx.stroke()
        if fill:
          _ = self.ctx.fill()

    fn move_to(self, x: Float64, y: Float64) raises:
        _ = self.ctx.move_to(x, y)

    fn curve_to(self, x1: Float64, y1: Float64, x2: Float64, y2: Float64, x3: Float64, y3: Float64) raises:
        _ = self.ctx.curve_to(x1, y1, x2, y2, x3, y3)

    fn stroke(self) raises:
        _ = self.ctx.stroke()

    fn fill(self) raises:
        _ = self.ctx.fill()

    fn line_width(self, w: Float64) raises:
        _ = self.ctx.set_line_width(w)

    fn color(self, r: Float64, g: Float64, b: Float64) raises:
        _ = self.ctx.set_source_rgb(r, g, b)

    fn color(self, r: Float64, g: Float64, b: Float64, a: Float64) raises:
        _ = self.ctx.set_source_rgba(r, g, b, a)