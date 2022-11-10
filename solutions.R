# Instruction to students: You may clear the code in this file and replace it
# with your own.

library(tidyverse)
library(ggforce)


# Draw a random chord in a unit circle centred at origin -----------------------

# Coordinates of equilateral triangle
eqtri_df <- tibble(
  x    = c(0, sqrt(3) / 2, -sqrt(3) / 2),
  y    = c(1, -0.5, -0.5),
  xend = c(sqrt(3) / 2, -sqrt(3) / 2, 0),
  yend = c(-0.5, -0.5, 1)
)

# Coordinates of random chord
x0 = 0
y0 = 0
r = 1
n = 10

# Method A

angle_ep1 = 2*pi*runif(n)
angle_ep2 = 2*pi*runif(n)

# Endpoint coordinates
x1 = x0 + r*cos(angle_ep1)
y1 = y0 + r*sin(angle_ep1)

x2 = x0 + r*cos(angle_ep2)
y2 = y0 + r*sin(angle_ep2)


MethodA_df <- tibble(
  x    = x1,
  y    = y1,
  xend = x2,
  yend = y2
)

# Plot
p1 <- ggplot() +
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray50") +
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend)) + 
  geom_point(data = MethodA_df, aes(x = x1, y = y1)) +
  geom_point(data = MethodA_df, aes(x = x2, y = y2)) +
  geom_segment(data = MethodA_df, aes(x = x, y = y, xend = xend, yend = yend), col = "red") +
  coord_equal()


# Method C

angle_mdpt = 2*pi*runif(n)
a = r*sqrt(runif(n))
d = sqrt(r^2 - a^2)

# Endpoint coordinates
x5 = x0 + a*cos(angle_mdpt) + d*sin(angle_mdpt)
y5 = x0 + a*sin(angle_mdpt) - d*cos(angle_mdpt)
x6 = x0 + a*cos(angle_mdpt) - d*sin(angle_mdpt)
y6 = x0 + a*sin(angle_mdpt) + d*cos(angle_mdpt)

# Midpoint of segments
mdptx = (x5 + x6) / 2
mdpty = (y5 + y6) / 2

MethodC_df <- tibble(
  mdptx = mdptx,
  mdpty = mdpty,
  x    = x5,
  y    = y5,
  xend = x6,
  yend = y6
)

p3 <- ggplot() +
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray50") +
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_point(data = MethodC_df, aes(x = mdptx, y = mdpty)) +
  geom_segment(data = MethodC_df, aes(x = x, y = y, xend = xend, yend = yend), col = "blue") +
  coord_equal()
