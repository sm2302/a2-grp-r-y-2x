## Group y+2x

library(tidyverse)
library(ggforce)
library(patchwork)
theme_set(theme_void())

# Coordinates of equilateral triangle
eqtri_df <- tibble(
  x    = c(0, sqrt(3) / 2, -sqrt(3) / 2),
  y    = c(1, -0.5, -0.5),
  xend = c(sqrt(3) / 2, -sqrt(3) / 2, 0),
  yend = c(-0.5, -0.5, 1)
)

# Input
x0 = 0 # x-coordinate of center
y0 = 0 # y-coordinate of center
r  = 1 # length of radius
n  = 50 # number of chords
l = r*sqrt(3) # length of side of triangle



# Method A ---------------------------------------------------------------------

angle_ep1 = 2*pi*runif(n) # random uniform angle of endpoint 1
angle_ep2 = 2*pi*runif(n) # random uniform angle of endpoint 1

# Endpoint coordinates
x1 = x0 + r*cos(angle_ep1)
y1 = y0 + r*sin(angle_ep1)

x2 = x0 + r*cos(angle_ep2)
y2 = y0 + r*sin(angle_ep2)


MethodA_df <- tibble(
  x     = x1,
  y     = y1,
  xend  = x2,
  yend  = y2,
  chord = sqrt((xend - x)^2 + (yend - y)^2 )
)

# Plot
p1a <- ggplot() +
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray50") +
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend)) + 
  geom_point(data = MethodA_df, aes(x = x1, y = y1), col = "lightpink2") +
  geom_point(data = MethodA_df, aes(x = x2, y = y2), col = "lightpink2") +
  coord_equal() +
  labs(title = "Method A", subtitle = paste("Random Endpoints"))

p1b <- ggplot() +
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray50") +
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend)) + 
  geom_segment(data = MethodA_df, aes(x = x, y = y, xend = xend, yend = yend), col = "lightpink2") +
  coord_equal()

p1a + p1b + plot_layout(nrow = 1)

# Probability of chord length longer than side of triangle
MethodA_count <- count(MethodA_df, chord > l)
MethodA_prob = MethodA_count[2,2] / n


# Method B ---------------------------------------------------------------------

angle_rd = 2*pi*runif(n) # random uniform angle of radius
u        = r*runif(n) # random uniform location of point on radius
v        = sqrt(r^2 - u^2) # half of chord length

# Endpoint coordinates
x3 = u*cos(angle_rd) + v*sin(angle_rd)
y3 = u*sin(angle_rd) - v*cos(angle_rd)

x4 = u*cos(angle_rd) - v*sin(angle_rd)
y4 = u*sin(angle_rd) + v*cos(angle_rd)

# Point on radius
rx = (x3 + x4) / 2
ry = (y3 + y4) / 2

# Radius endpoint coordinates
rxend = r*cos(angle_rd)
ryend = r*sin(angle_rd)

MethodB_df <- tibble(
  rx    = rx,
  ry    = ry,
  x     = x3,
  y     = y3,
  xend  = x4,
  yend  = y4,
  x0    = 0,
  y0    = 0,
  rxend = rxend,
  ryend = ryend,
  chord = sqrt((xend - x)^2 + (yend - y)^2 )
)

# Plot
p2a <- ggplot() +
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray50") +
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_segment(data = MethodB_df, aes(x = x0, y = y0, xend = rxend, yend = ryend), col = "plum") +
  geom_point(data = MethodB_df, aes(x = rx, y = ry), col = "plum") +
  coord_equal() +
  labs(title = "Method B", subtitle = paste("Random Radius"))

p2b <- ggplot() +
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray50") +
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_segment(data = MethodB_df, aes(x = x, y = y, xend = xend, yend = yend), col = "plum") +
  coord_equal()

p2a + p2b + plot_layout(nrow = 1)

# Probability of chord length longer than side of triangle
MethodB_count <- count(MethodB_df, chord > l)
MethodB_prob = MethodB_count[2,2] / n


# Method C ---------------------------------------------------------------------

angle_mdpt = 2*pi*runif(n) # random uniform angle of midpoint
a          = r*sqrt(runif(n)) # random location of midpoint
d          = sqrt(r^2 - a^2) # half of chord length

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
  x     = x5,
  y     = y5,
  xend  = x6,
  yend  = y6,
  chord = sqrt((xend - x)^2 + (yend - y)^2 )
)

# Plot
p3a <- ggplot() +
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray50") +
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_point(data = MethodC_df, aes(x = mdptx, y = mdpty), col = "lightblue") +
  coord_equal() +
  labs(title = "Method C", subtitle = paste("Random Midpoint"))

p3b <- ggplot() +
  ggforce::geom_circle(aes(x0 = 0, y0 = 0, r = 1), col = "gray50") +
  geom_segment(data = eqtri_df, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_segment(data = MethodC_df, aes(x = x, y = y, xend = xend, yend = yend), col = "lightblue") +
  coord_equal()

p3a + p3b + plot_layout(nrow = 1)

# Probability of chord length longer than side of triangle
MethodC_count <- count(MethodC_df, chord > l)
MethodC_prob = MethodC_count[2,2] / n


# Results ----------------------------------------------------------------------

p1a + p1b + p2a + p2b + p3a + p3b + plot_layout(nrow = 3)

all_prob <- tibble(
  MethodA = MethodA_prob,
  MethodB = MethodB_prob,
  MethodC = MethodC_prob
)

print(all_prob)
