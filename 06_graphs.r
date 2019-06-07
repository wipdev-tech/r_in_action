library(vcd)
library(gplots)
library(plotrix)
library(sm)

# Bar Plots ---------------------------------------------------------------

# feeding counts into barplot()
counts <- table(Arthritis$Improved)
barplot(counts, horiz = TRUE)

# plotting factors directly
plot(Arthritis$Improved, horiz = TRUE)

# stacked/grouped bars
counts_2w <- table(Arthritis$Improved, Arthritis$Treatment)
barplot(counts_2w, horiz = TRUE, beside = TRUE)

# example 6.2
barplot(
  counts_2w,
  horiz = TRUE,
  beside = TRUE,
  col = c("tomato2", "darkgoldenrod2", "steelblue"),
  legend = rownames(counts_2w)
)

# bar plot for means
states <- data.frame(state.region, state.x77)
means <- aggregate(states$Illiteracy, by = list(state.region), FUN = mean)
means <- means[order(means$x), ]

barplot(means$x, names.arg = means$Group.1)

# add confidence intervals to the bar
barplot2(
  means$x,
  names.arg = means$Group.1,
  horiz = TRUE,
  plot.ci = TRUE,
  ci.l = (means$x - 0.25),
  ci.u = (means$x + 0.25)
)

# customize bar chart - example 6.4
par(mar = c(5, 8, 4, 2)) # margins
par(las = 2)             # rotates labels
counts <- table(Arthritis$Improved)
barplot(
  counts,
  horiz = TRUE,
  cex.names = 0.8, # label size
  names.arg = c(   # label text
    "No Improvement",
    "Some Improvement",
    "Marked Improvement"
  ),
  main = "Treatment Outcoumes"
)

# spinogram
spine(t(counts_2w))


# Pie Charts --------------------------------------------------------------

# data
slices <- c(10, 12, 4, 16, 8)
lbls <- c("US", "UK", "Australia", "Germany", "France")

pcts <- round(slices / sum(slices) * 100)
lbls2 <- paste0(lbls, ", ", pcts, "%")

# pie
pie(slices, lbls)
pie(slices, lbls2)
pie(table(state.region))

# fan plot
fan.plot(slices, labels = lbls2, main = "This is a fan plot.")


# Histograms --------------------------------------------------------------

# simple
hist(mtcars$mpg)

# density y-axis with rug and kernel density
hist(mtcars$mpg, freq = FALSE, breaks = 12, col = "red")
rug(jitter(mtcars$mpg, amount = 0.01))
lines(density(mtcars$mpg), col = "blue", lwd = 2)

# density y-axis with normal fit
x <- mtcars$mpg
xgaus <- seq(min(x), max(x), length = 50)
ygaus <- dnorm(xgaus, mean(x), sd(x))

hist(x, freq = FALSE, breaks = 12, col = "red")
lines(xgaus, ygaus, lwd = 2)
box()


# Kernel Density Plots ----------------------------------------------------

# density plot with colors and rug
plot(density(x))
polygon(density(x), col = "steelblue")
rug(jitter(x, amount = 0.01))

# compare densities
cyl_f <- factor(
  mtcars$cyl,
  levels = c(4, 6, 8),
  labels = c("4 cylinder", "6 cylinder", "8 cylinder")
)

sm.density.compare(mtcars$mpg, mtcars$cyl, lwd = 2)
