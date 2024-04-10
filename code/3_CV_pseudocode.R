### A basic cross-validation loop

# Note this won't actually run (!) it's just an example of the procedure.

# define the search "grid" (in this case, over a single hyperparameter)
hyperparameter_values <- c(0.001, 0.01, 0.1,...)

# assign each training observation to a fold (typically 5 or 10 folds in total)
K <- 10
k_folds <- sample(1:K, nrow(X_train), replace = TRUE)

# create a data frame to store the average loss across k-folds for each 
# hyperparameter value
cv_losses <- data.frame(
  value = hyperparameter_values,
  avg_loss = NA
)

# loop over the hyperparameter values
for (val in hyperparameter_values) {
  
  # create a vector to store the individual k_mod losses
  k_losses <- c()
  
  # loop over the folds
  for (k in 1:K) {
    
    X_val_k <- X_train[k_fold == k,]
    X_train_k <- X_train[k_fold != k,]
    
    y_val_k <- y_train[kfold == k]
    y_train_k <- y_train[kfold != k]
    
    k_mod <- model(y_val_k ~ X_train_k)
    
    y_pred_k <- predict(k_mod, X_val_k)
    
    # some loss metric (can be accuracy, or MSE, or whatever you choose)
    loss <- mean(y_val_k == y_pred_k)
    
    # append loss to your k_losses  
    k_losses[k] <- loss
    
  }
  
  # once you've done this K times, we calculate the average estimated test error
  loss <- mean(cv_loss)
  
  # then update our CV dataframe
  cv_losses[cv_losses$value = val,]$avg_loss <- loss
  
}

# finally, having searched all hyp. vals, find the best performing version
cv_losses$value[which.min(cv_losses$avg_loss)]
