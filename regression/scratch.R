library(UsingR);
data(diamond);
library(ggplot2);

g <- ggplot(diamond, aes(x=carat, y= price),)
g <- g + xlab("Mass (carats)")
g <- g + ylab("Price (SIN $)")
g <- g + geom_point(size=6, colour="black", alpha=0.2)
g <- g + geom_point(size=5, colour="blue", alpha=0.2)
g <- g + geom_smooth(method="lm", colour="black")
g

fit <- lm(price ~ carat, data = diamond);
coef(fit);

fit2 <- lm(price ~ I(carat - mean(carat)), data = diamond);
coef(fit2);

fit3 <- lm(price ~ I(carat * 10), data = diamond);
coef(fit3);

newx <- c(0.16, 0.27, 0.34)
coef(fit)[1] + coef(fit)[2] * newx
predict(fit, newdata = data.frame(carat = newx))

# Residuals

y <- diamond$price;
x <- diamond$carat;
n <- length(y);
fit <- lm(y~ x);
e <- resid(fit);
yhat <- predict(fit);
max(abs(e - (y - yhat)));
max(abs(e - (y - coef(fit)[1] - coef(fit)[2] * x)))

plot(x, y, xlab="Mass (carat)", ylab="Price ($)", bg = "lightblue",
     col="black", cex=1.1, pch=21, frame=FALSE)
abline(fit,lwd)
for(i in 1 : n)
  lines(c(x[i], x[i]), c(y[i], yhat[i]), col="red", lwd=2)

# Plot residuals on y instead

plot(x, e, xlab="Mass (carat)", ylab="Price ($)", bg = "lightblue",
     col="black", cex=1.1, pch=21, frame=FALSE)
abline(h=0, lwd=2)
for(i in 1 : n)
  lines(c(x[i], x[i]), c(e[i], 0), col="red", lwd=2)


x <- mtcars$wt
y <- mtcars$mpg
fit <- lm(y ~ x) 
newx = data.frame(x = seq(min(x), max(x), length = 100))
p1 = data.frame(predict(fit, newdata= newx,interval = ("confidence")))
p2 = data.frame(predict(fit, newdata = newx,interval = ("prediction")))
p1$interval = "confidence"
p2$interval = "prediction"
p1$x = newx$x
p2$x = newx$x
dat = rbind(p1, p2)
names(dat)[1] = "y"

library(ggplot2)
g = ggplot(dat, aes(x = x, y = y))
g = g + geom_ribbon(aes(ymin = lwr, ymax = upr, fill = interval), alpha = 0.2) 
g = g + geom_line()
g = g + geom_point(data = data.frame(x = x, y=y), aes(x = x, y = y), size = 4)
g

### Multivariants


