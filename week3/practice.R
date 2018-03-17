#install.packages("dplyr")
#library(dplyr)
airquality
head(airquality)
#try a simple histagram
#hist(x=airquality$Month,main = "histogram", xlab = "month", ylab = "ozone",col = "blue")
#using package lattice to build another picture
install.packages("lattice")
require(lattice)
airquality$Month <- as.factor(airquality$Month)
bwplot(x = Ozone ~ Month,      # 把Month放在X軸，Ozone放在Y軸
       data = airquality,     
       xlab = "Month"         
)

