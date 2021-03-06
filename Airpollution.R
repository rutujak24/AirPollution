
R version 3.6.3 (2020-02-29) -- "Holding the Windsock"
Copyright (C) 2020 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[Previously saved workspace restored]

> pollutantmean <- function(directory, pollutant, id ) {
+   files_full <- list.files(directory, full.names = TRUE) 
+   
+   dat <- data.frame()
+   
+   for (i in id) {
+     dat <- rbind(dat, read.csv(files_full[i]))
+   }
+   
+   mean(dat[, pollutant], na.rm = TRUE)
+ }
> pollutantmean <- function(directory, pollutant, id ) {
+   files_full <- list.files(directory, full.names = TRUE) 
+   
+   dat <- data.frame()
+   
+   for (i in id) {
+     dat <- rbind(dat, read.csv(files_full[i]))
+   }
+   
+   mean(dat[, pollutant], na.rm = TRUE)
+ }
> pollutantmean("specdata", "sulfate", 1:10)
[1] 4.064128
> pollutantmean("specdata", "nitrate", 70:72)
[1] 1.706047
> pollutantmean("specdata", "sulfate", 34)
[1] 1.477143
> pollutantmean("specdata", "nitrate")
Error in pollutantmean("specdata", "nitrate") : 
  argument "id" is missing, with no default
> pollutantmean("specdata", "nitrate", 1:332)
[1] 1.702932
> complete <- function(directory, id = 1:332) {
+         files_full <- list.files(directory, full.names = TRUE)
+         dat <- data.frame()
+         
+         for (i in id) {
+                 moni_i <- read.csv(files_full[i])
+                 nobs <- sum(complete.cases(moni_i))
+                 tmp <- data.frame(i, nobs)
+                 dat <- rbind(dat, tmp)
+         }
+         
+         colnames(dat) <- c("id", "nobs")
+         dat
+ }
> cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
> print(cc$nobs)
[1] 228 148 124 165 104 460 232
> cc <- complete("specdata", 54)
> print(cc$nobs)
[1] 219
> RNGversion("3.5.1")  
Warning message:
In RNGkind("Mersenne-Twister", "Inversion", "Rounding") :
  non-uniform 'Rounding' sampler used
> set.seed(42)
> cc <- complete("specdata", 332:1)
> use <- sample(332, 10)
> print(cc[use, "nobs"])
 [1] 711 135  74 445 178  73  49   0 687 237
> corr <- function(directory, threshold = 0) {
+         files_full <- list.files(directory, full.names = TRUE)
+         dat <- vector(mode = "numeric", length = 0)
+         
+         for (i in 1:length(files_full)) {
+                 moni_i <- read.csv(files_full[i])
+                 csum <- sum((!is.na(moni_i$sulfate)) & (!is.na(moni_i$nitrate)))
+                 if (csum > threshold) {
+                         tmp <- moni_i[which(!is.na(moni_i$sulfate)), ]
+                         submoni_i <- tmp[which(!is.na(tmp$nitrate)), ]
+                         dat <- c(dat, cor(submoni_i$sulfate, submoni_i$nitrate))
+                 }
+         }
+         
+         dat
+ }
> cr <- corr("specdata")                
> cr <- sort(cr)   
> RNGversion("3.5.1")
Warning message:
In RNGkind("Mersenne-Twister", "Inversion", "Rounding") :
  non-uniform 'Rounding' sampler used
> set.seed(868)                
> out <- round(cr[sample(length(cr), 5)], 4)
> print(out)
[1]  0.2688  0.1127 -0.0085  0.4586  0.0447
> cr <- corr("specdata", 129)                
> cr <- sort(cr)                
> n <- length(cr)    
> RNGversion("3.5.1")
Warning message:
In RNGkind("Mersenne-Twister", "Inversion", "Rounding") :
  non-uniform 'Rounding' sampler used
> set.seed(197)                
> out <- c(n, round(cr[sample(n, 5)], 4))
> print(out)
[1] 243.0000   0.2540   0.0504  -0.1462  -0.1680   0.5969
> cr <- corr("specdata", 2000)                
> n <- length(cr)                
> cr <- corr("specdata", 1000)                
> cr <- sort(cr)
> print(c(n, round(cr, 4)))
[1]  0.0000 -0.0190  0.0419  0.1901
> save.image("C:\\Users\\Rutuja\\Documents\\R\\Rprograms\\Airpollution.R")
> save.image("C:\\Users\\Rutuja\\Documents\\R\\Rprograms\\Airpollution")
> 
