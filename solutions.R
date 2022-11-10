# Instruction to students: You may clear the code in this file and replace it
# with your own.

library(tidyverse)
library(ggforce)
theme_set(theme_void())

# Draw a random chord in a unit circle centred at origin -----------------------

# Coordinates of equilateral triangle
eqtri_df <- tibble(
  x    = c(0, sqrt(3) / 2, -sqrt(3) / 2),
  y    = c(1, -0.5, -0.5),
  xend = c(sqrt(3) / 2, -sqrt(3) / 2, 0),
  yend = c(-0.5, -0.5, 1)
)

# Coordinates of random chord
x0 = 0;
y0 = 0;
r = 1;
n = 10;

# Method A

angle_ep1 = 2*pi*runif(n);
angle_ep2 = 2*pi*runif(n);

# Endpoint coordinates
x1 = x0 + r*cos(angle_ep1);
y1 = y0 + r*cos(angle_ep1);

x2 = x0 + r*cos(angle_ep2);
y2 = y0 + r*cos(angle_ep2);


MethodA_df <- tibble(
  x    = x1,
  y    = y1,
  xend = x2,
  yend = y2
)

# Plot
p <- ggplot() +
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray50") +
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_segment(data = MethodA_df, aes(x = x, y = y, xend = xend, yend = yend),
               col = "red3") +
  coord_equal()

#ggsave(p, file = "plot.png", height = 5, width = 7)
