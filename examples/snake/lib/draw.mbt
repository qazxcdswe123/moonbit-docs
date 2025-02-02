pub type Canvas_ctx

fn set_stroke_color_ffi(self : Canvas_ctx, color : @extern.JS_String) = "canvas" "set_stroke_color"

fn set_stroke_color(self : Canvas_ctx, color : String) -> Unit {
  self.set_stroke_color_ffi(@extern.JS_String::from_string(color).unwrap())
}

fn set_line_width(self : Canvas_ctx, width : Double) = "canvas" "set_line_width"

fn stroke_rect(self : Canvas_ctx, x : Int, y : Int, width : Int, height : Int) = "canvas" "stroke_rect"

fn fill_rect(self : Canvas_ctx, x : Int, y : Int, width : Int, height : Int) = "canvas" "fill_rect"

fn set_fill_style_ffi(self : Canvas_ctx, color : @extern.JS_String) = "canvas" "set_fill_style"

fn set_fill_style(self : Canvas_ctx, color : String) -> Unit {
  self.set_fill_style_ffi(@extern.JS_String::from_string(color).unwrap())
}

fn body_color(grid : GridType) -> String {
  match grid {
    Body => "#ffb900"
    Food => "#2753f1"
    Default => "#dcdcdc"
  }
}

let border_color = "#00263f"

pub fn draw(canvas : Canvas_ctx, snake : GameState) -> Unit {
  // draw background
  for c = 0; c < grid_col_count; c = c + 1 {
    canvas.set_fill_style(body_color(Default))
    canvas.fill_rect(c, 0, 1, grid_row_count)
  }
  draw_piece(canvas, snake.grid, (0, 0))
}

fn draw_piece(
  canvas : Canvas_ctx,
  matrix : Array[GridType],
  offset : (Int, Int)
) -> Unit {
  let mut r = 0
  let mut c0 = 0
  for c = 0; c < matrix.length(); c = c + 1 {
    if matrix[c] == Default {
      continue c + 1
    }
    c0 = c % grid_col_count
    r = c / grid_col_count
    canvas.set_fill_style(body_color(matrix[c]))
    canvas.fill_rect(offset.0 + c0, r, 1, 1)
    canvas.set_stroke_color(border_color)
    canvas.set_line_width(0.1)
    canvas.stroke_rect(c0, r, 1, 1)
  }
}
