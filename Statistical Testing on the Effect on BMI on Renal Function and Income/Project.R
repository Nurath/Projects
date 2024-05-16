library(NHANES)
library(dplyr)
library(corrplot)
library(doBy)
library(table1)
library(knitr)
library(papeR)
library(stats)
library(tidyverse)
library(ggplot2)
library(corrplot)
SD_pop<-function(x,n){sqrt(sum( (x - mean(x) )^2)/(n))}
#temp$BMI_factor<-cut(temp$BMI,breaks=c(min(temp$BMI,na.rm=TRUE),18.5,25,30,max(temp$BMI,na.rm=TRUE)),
#                    levels=c("low","normal","overweight","obese"))


data(NHANES)
ls(NHANES)
NHANES<-NHANES[!duplicated(NHANES$ID),]

df<-select(NHANES,ID,Gender,Age,BMI,HHIncomeMid,UrineFlow1)
df<-df[complete.cases(df),]
df<-df %>% filter(Age > 18)
for (i in 1:length(df$BMI)) 
{
  if (df$BMI[i]<18.5) {
    df$BMI_Factor[i]<-"Under Weight"
  }
  else if(df$BMI[i]>18.5 & df$BMI[i]<25){
    df$BMI_Factor[i]<-"Normal"
  }
  else if(df$BMI[i]>=25 & df$BMI[i]<30){
    df$BMI_Factor[i]<-"Over Weight"
  }
  else if(df$BMI[i]>=30){
    df$BMI_Factor[i]<-"Obese"
  }
}
df$BMI_Factor<-factor(df$BMI_Factor,order=TRUE,
                      levels = c("Under Weight","Normal","Over Weight","Obese"))
df$Income_Factor <- cut(df$HHIncomeMid,breaks = c(min(df$HHIncomeMid),22500,87500,max(df$HHIncomeMid)),labels = c("Low","Medium","High"),include.lowest = TRUE)
df$Income_Factor <-factor(df$Income_Factor,order=TRUE,levels=c("Low","Medium","High"))
summary(df$Income_Factor)
set.seed(25)
selection<-sample(df$ID[df$Age > 18],500)
df1<-data.frame("ID"=df$ID[df$ID %in% selection],
                "age"=df$Age[df$ID %in% selection],
                "Gender"=df$Gender[df$ID %in% selection],
                "BMI"=df$BMI[df$ID %in% selection],
                "BMI_Factor"=df$BMI_Factor[df$ID %in% selection],
                "Urine_Flow"=df$UrineFlow1[df$ID %in% selection],
                "Income"=df$HHIncomeMid[df$ID %in% selection],
                "Income_Factor"=df$Income_Factor[df$ID %in% selection])



# z-test
temp1<-df1[df1$BMI_Factor=='Under Weight',]
summary(temp1$Urine_Flow)
summary(df$UrineFlow1)
par(mfrow=c(2,1))
hist(df$UrineFlow1)
hist(temp1$Urine_Flow)
mew<-mean(df$UrineFlow1[(df$Age>18)])
sigma<-SD_pop(df$UrineFlow1[(df$Age>18)],
              n=length(df$UrineFlow1[(df$Age>18)]))
sigma_estimated<-sd(temp1$Urine_Flow)
xbar<-mean(temp1$Urine_Flow)
n<-length(temp1$Urine_Flow)
SEM<-(sigma/sqrt(n))

z<-(xbar-mew)/SEM
z

#2-tailed
p_2tailed<-2 * pnorm( - abs(z))
p_2tailed
#not rejecting the null

#1-tailed 
#Null hypothesis sample is greater/equal than the mew 
#Research hypothesis sample is smaller than the mew
p_1tailed_smaller <- pnorm(z)
p_1tailed_smaller
#not rejecting the null

#1-tailed 
#Null hypothesis sample is smaller/equal than the mew 
#Research hypothesis sample is greater than the mew
p_1tailed_greater <- 1 - pnorm(z)
p_1tailed_greater
#not rejecting the null




# z-test
temp1<-df1[df1$BMI_Factor=='Normal',]
summary(temp1)
summary(df)
par(mfrow=c(2,1))
hist(df$UrineFlow1)
hist(temp1$Urine_Flow)
mew<-mean(df$UrineFlow1[(df$Age>18)])
sigma<-SD_pop(df$UrineFlow1[(df$Age>18)],
              n=length(df$UrineFlow1[(df$Age>18)]))
sigma_estimated<-sd(temp1$Urine_Flow)
xbar<-mean(temp1$Urine_Flow)
n<-length(temp1$Urine_Flow)
SEM<-(sigma/sqrt(n))

z<-(xbar-mew)/SEM
z

#2-tailed
p_2tailed<-2 * pnorm( - abs(z))
p_2tailed
#not rejecting the null

#1-tailed 
#Null hypothesis sample is greater/equal than the mew 
#Research hypothesis sample is smaller than the mew
p_1tailed_smaller <- pnorm(z)
p_1tailed_smaller
#not rejecting the null

#1-tailed 
#Null hypothesis sample is smaller/equal than the mew 
#Research hypothesis sample is greater than the mew
p_1tailed_greater <- 1 - pnorm(z)
p_1tailed_greater
#not rejecting the null





# z-test
temp1<-df1[df1$BMI_Factor=='Over Weight',]
summary(temp1)
summary(df)
par(mfrow=c(2,1))
hist(df$UrineFlow1)
hist(temp1$Urine_Flow)
mew<-mean(df$UrineFlow1[(df$Age>18)])
sigma<-SD_pop(df$UrineFlow1[(df$Age>18)],
              n=length(df$UrineFlow1[(df$Age>18)]))
sigma_estimated<-sd(temp1$Urine_Flow)
xbar<-mean(temp1$Urine_Flow)
n<-length(temp1$Urine_Flow)
SEM<-(sigma/sqrt(n))

z<-(xbar-mew)/SEM
z

#2-tailed
p_2tailed<-2 * pnorm( - abs(z))
p_2tailed
#not rejecting the null

#1-tailed 
#Null hypothesis sample is greater/equal than the mew 
#Research hypothesis sample is smaller than the mew
p_1tailed_smaller <- pnorm(z)
p_1tailed_smaller
#not rejecting the null

#1-tailed 
#Null hypothesis sample is smaller/equal than the mew 
#Research hypothesis sample is greater than the mew
p_1tailed_greater <- 1 - pnorm(z)
p_1tailed_greater
#not rejecting the null





# z-test
temp1<-df1[df1$BMI_Factor=='Obese',]
summary(temp1)
summary(df)
par(mfrow=c(2,1))
hist(df$UrineFlow1)
hist(temp1$Urine_Flow)
mew<-mean(df$UrineFlow1[(df$Age>18)])
sigma<-SD_pop(df$UrineFlow1[(df$Age>18)],
              n=length(df$UrineFlow1[(df$Age>18)]))
sigma_estimated<-sd(temp1$Urine_Flow)
xbar<-mean(temp1$Urine_Flow)
n<-length(temp1$Urine_Flow)
SEM<-(sigma/sqrt(n))

z<-(xbar-mew)/SEM
z

#2-tailed
p_2tailed<-2 * pnorm( - abs(z))
p_2tailed
#not rejecting the null

#1-tailed 
#Null hypothesis sample is greater/equal than the mew 
#Research hypothesis sample is smaller than the mew
p_1tailed_smaller <- pnorm(z)
p_1tailed_smaller
#not rejecting the null

#1-tailed 
#Null hypothesis sample is smaller/equal than the mew 
#Research hypothesis sample is greater than the mew
p_1tailed_greater <- 1 - pnorm(z)
p_1tailed_greater
#not rejecting the null


anova_test<-aov(df1$Urine_Flow~df1$BMI_Factor)
summary(anova_test)

Tukey<-TukeyHSD(anova_test)
plot(Tukey)
Tukey







# Income


# z-test
temp1<-df1[df1$Income_Factor=='Low',]
summary(temp1$BMI)
summary(df$BMI)
par(mfrow=c(2,1))
hist(df$BMI)
hist(temp1$BMI)
mew<-mean(df$BMI[(df$Age>18)])
sigma<-SD_pop(df$BMI[(df$Age>18)],
              n=length(df$BMI[(df$Age>18)]))
sigma_estimated<-sd(temp1$BMI)
xbar<-mean(temp1$BMI)
n<-length(temp1$BMI)
SEM<-(sigma/sqrt(n))

z<-(xbar-mew)/SEM
z

#2-tailed
p_2tailed<-2 * pnorm( - abs(z))
p_2tailed
#not rejecting the null

#1-tailed 
#Null hypothesis sample is greater/equal than the mew 
#Research hypothesis sample is smaller than the mew
p_1tailed_smaller <- pnorm(z)
p_1tailed_smaller
#not rejecting the null

#1-tailed 
#Null hypothesis sample is smaller/equal than the mew 
#Research hypothesis sample is greater than the mew
p_1tailed_greater <- 1 - pnorm(z)
p_1tailed_greater
#rejecting the null




# z-test
temp1<-df1[df1$Income_Factor=='Medium',]
summary(temp1$BMI)
summary(df$BMI)
par(mfrow=c(2,1))
hist(df$BMI)
hist(temp1$BMI)
mew<-mean(df$BMI[(df$Age>18)])
sigma<-SD_pop(df$BMI[(df$Age>18)],
              n=length(df$BMI[(df$Age>18)]))
sigma_estimated<-sd(temp1$BMI)
xbar<-mean(temp1$BMI)
n<-length(temp1$BMI)
SEM<-(sigma/sqrt(n))

z<-(xbar-mew)/SEM
z

#2-tailed
p_2tailed<-2 * pnorm( - abs(z))
p_2tailed
# rejecting the null

#1-tailed 
#Null hypothesis sample is greater/equal than the mew 
#Research hypothesis sample is smaller than the mew
p_1tailed_smaller <- pnorm(z)
p_1tailed_smaller
#not rejecting the null

#1-tailed 
#Null hypothesis sample is smaller/equal than the mew 
#Research hypothesis sample is greater than the mew
p_1tailed_greater <- 1 - pnorm(z)
p_1tailed_greater
# rejecting the null





# z-test
temp1<-df1[df1$Income_Factor=='High',]
summary(temp1$BMI)
summary(df$BMI)
par(mfrow=c(2,1))
hist(df$BMI)
hist(temp1$BMI)
mew<-mean(df$BMI[(df$Age>18)])
sigma<-SD_pop(df$BMI[(df$Age>18)],
              n=length(df$BMI[(df$Age>18)]))
sigma_estimated<-sd(temp1$BMI)
xbar<-mean(temp1$BMI)
n<-length(temp1$BMI)
SEM<-(sigma/sqrt(n))

z<-(xbar-mew)/SEM
z
#2-tailed
p_2tailed<-2 * pnorm( - abs(z))
p_2tailed
#not rejecting the null

#1-tailed 
#Null hypothesis sample is greater/equal than the mew 
#Research hypothesis sample is smaller than the mew
p_1tailed_smaller <- pnorm(z)
p_1tailed_smaller
#not rejecting the null

#1-tailed 
#Null hypothesis sample is smaller/equal than the mew 
#Research hypothesis sample is greater than the mew
p_1tailed_greater <- 1 - pnorm(z)
p_1tailed_greater
#not rejecting the null

anova_test1<-aov(df$BMI~df$Income_Factor)
summary(anova_test1)
Tukey1<-TukeyHSD(anova_test1)
plot(Tukey1)
Tukey1


cor(df$UrineFlow1,df$BMI,method = c( "pearson"))
cor(df$HHIncomeMid,df$BMI,method = c( "pearson"))
ls(df)
corrplot(cor(df[,c(3,4,5,6)]), method = "number", type = "upper", diag = FALSE)

fit_all<-lm(Urine_Flow ~ BMI, data=df1)
fit_all
summary(fit_all)


plot(c(min(df1$BMI,na.rm = TRUE),max(df1$BMI,na.rm = TRUE)),c(min(df1$Urine_Flow,na.rm = TRUE),max(df1$Urine_Flow,na.rm = TRUE)),col="white",
     xlab="BMI [Kg/cm^2]",ylab="Urine Flow Rate [mL/sec]")
#ggplot(df1,aes(x=age,y=SBP,color=BMI_Factor)) +
#geom_smooth(method='lm',mapping =aes(x=age,y=SBP),se=FALSE)+
# geom_jitter(width = .2)
points(df1$BMI,df1$Urine_Flow,pch=2,cex=0.6,col="red")
abline(fit_all,col="black")

fit_all<-lm(BMI ~ Income, data=df1)
fit_all
summary(fit_all)

plot(c(min(df1$Income,na.rm = TRUE),max(df1$Income,na.rm = TRUE)),c(min(df1$BMI,na.rm = TRUE),max(df1$BMI,na.rm = TRUE)),col="white",
     xlab="Income [$/yr]",ylab="Body Mass Index [Kg/cm^2]")
#ggplot(df1,aes(x=age,y=SBP,color=BMI_Factor)) +
#geom_smooth(method='lm',mapping =aes(x=age,y=SBP),se=FALSE)+
# geom_jitter(width = .2)
points(df1$Income,df1$BMI,pch=2,cex=0.6,col="red")
abline(fit_all,col="black")

