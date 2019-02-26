#multicolinearity remover 

Multi_linear_Filter_alpha <- function(data_samp, cor_thres = 0.7, desired_det = 0.0007, dep_var ){
  
  ### get variable of interest and remove from dataset
  y <- data_samp[,dep_var]
  data_samp[,dep_var]<-NULL
  data_samp <- select_if(data_samp, is.numeric) ##select only numerical portion of data
  # remove constants to make correlation matrix work
  level_collect<- matrix(nrow = length(data_samp), ncol = 1) 
  for (i in 1:length(data_samp)) {
    level_collect[i,] <- var(data_samp[,i]) #collect variances
  }
  ind_coll_2 <- which(level_collect>0, arr.ind = TRUE)#collect variables which possess variance 
  data_samp <- data_samp[,ind_coll_2[,1]] # collect variables which vary 
  
  
  cor_data<- cor(data_samp) ## get correlation 
  index_remove <- 1 ## start index from somewhere 
  det_thres<- det(cor_data) ## get intial determinant
  while( (det_thres < desired_det) || (is.null(index_remove) == TRUE) ){ ##condition to satisfy
    
    index_remove <- NULL #start index collector at null to append later
    for (i in 1:(nrow(cor_data)-1)) { ## first index to dictate variable of interest
      #print(i)
      for (j in (i+1):ncol(cor_data)) { ## to check correlation pairs b/w variables of interest and other variables
        
        corij <- cor_data[i,j]
        if(corij < cor_thres) { ## check if correlation of i,j with specified threshold
          if(cor(data_samp[,i],y)<cor(data_samp[,j],y)){ ## collect variable with least info on dependant variable
            index_remove <- rbind(index_remove,j)
            print(x = c(i,j)) }
          else{index_remove <- rbind(index_remove,i)
          print(x = c(i,j))}
        }
      }
    }
    
    index_remove<- unique(index_remove) ## collect unique index because of repition
    #data_samp[,index_remove]<- NULL #remove those selected variables 
    
   data_samp<- data_samp[,index_remove] #collect index and make that new dataset
    
    cor_data<- cor(data_samp) ## recalulate correlation matrix
    det_thres <- det(cor_data) ## recalculate determinant and recheck while loop condition
    #iterate until conditions are met.
    
  }
  
  return(list(Data = cbind(DepVar = y, data_samp), determinant_value = det_thres, cor_matrix = cor_data))
  
}


### test

data_samp <- my_Bootstrap(data_numeric, 40000)
check <- Multi_linear_Filter_alpha(data = data_samp, cor_thres = 0.05, desired_det =0.9, dep_var = "INCTOT")

(check$cor_matrix)
check$determinant_value
pairs(check$Data)
stuff<-(check$Data)
cor(check$Data)
