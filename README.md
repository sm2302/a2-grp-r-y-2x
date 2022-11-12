# R Group Assignment by Group y+2x

## Introduction

The Bertrand paradox looks at the probablitity that a random chord is longer than the side of a triangle inscribed into the same circle.

![](plot.png)

Three different solutions are presented, each depending on the method of generating the random chord:

- **METHOD A (Random Endpoints)**: Choose two random points on the circumference of the circle, and draw the chord joining them.

- **METHOD B (Random Radial Points)**: Choose a random radius of the circle, and a random point on this radius, and draw the chord through this point and perpendicular to the radius.

- **METHOD C (Random Midpoints)**: Choose a point anywhere within the circle, and construct the chord such that the point chosen is the midpoint of the chord.

## Simulation
By running our R script labelled `solutions.R`, you will see 6 plots in total, two for each method. The plots on the left will show the randomly generated points whereas the plots on the right will show the corresponding chords. A tibble of the probablity for each respective method will also be printed out. Feel free to change the number of chords to see different outcomes. Below you will find a brief explanation of how we generated the random points.

### METHOD A (Random Endpoints)
To obtain the random endpoints, we first generate random uniform angles (where the endpoints will be). Next, we calculate the corresponding endpoint coordinates as below:
```
r  = 1 # length of radius
x0 = 0 # x-coordinate of centre
y0 = 0 # y-coordinate of centre

angle_ep1 = 2*pi*runif(n) # random uniform angle of endpoint 1
angle_ep2 = 2*pi*runif(n) # random uniform angle of endpoint 1

# Endpoint coordinates
x1 = x0 + r*cos(angle_ep1)
y1 = y0 + r*sin(angle_ep1)

x2 = x0 + r*cos(angle_ep2)
y2 = y0 + r*sin(angle_ep2)
```

### METHOD B (Random Radial Points)
For this method we generate random uniform angles which corresponds to the location of each radius. Next, we randomly determine the distance of the point on each radius from the center. We then calculate the corresponding endpoint coordinates. Finally, to obtain the coordinates of the random point on each radius we simply take the midpoint of each chord.
```
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
```

### METHOD C (Random Midpoints)
For this last method, we generate random uniform angles (where the midpoints will be). We then determine the area of which the midpoint lies. With this, we are able to calculate the coordinates of the endpoints for each chord as well as its midpoint.

```
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
```















