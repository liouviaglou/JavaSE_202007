library(dplyr)
library(data.table)
library(partykit)
library(tictoc)
library(caret)
library(e1071)
library(randomForest)
library(ranger)
library(plotly)
library(tidyr)

set.seed(0)
getwd()
setwd('/Users/lubagloukhov/Documents/Consulting/PiqueSolutions/JavaSE_202007/scripts')

# load data
mod_df = read.csv('../data/output/mod_df.csv')  
mod_df <- mod_df %>% rename("OJavaSESubscription_Alts_Top3_EasierUse." = 
                              "JavaSESubscription_Alts_Top3_EasierUse") 

catg_dummy_list = unname(unlist(read.csv('../data/output/catg_dummy_list.csv', 
                                  header=FALSE, as.is=TRUE)))
cont_dummy_list = unname(unlist(read.table('../data/output/cont_dummy_list.csv',
                             sep="\n", as.is=TRUE)))
dummy0_dummy_list = unname(unlist(read.table('../data/output/dummy0_dummy_list.csv',
                             sep="\n", as.is=TRUE)))
exlc_dummy_list = unname(unlist(read.table('../data/output/exlc_dummy_list.csv',
                                           sep="\n", as.is=TRUE)))

# specify response variable groupings
y0_list = c('Sat_Org_EclipseIDE',
           'Sat_Org_IntelliJIDE',
           'Sat_Org_JDeveloper',
           'Sat_Org_NetBeansIDE',
           'Sat_Org_RationalAppDev',
           'Sat_Org_VisualStudio',
           'Sat_Org_Other')
y1_list = c('Sat_Org_JavaSEAMC',
           'Sat_Org_JavaSEAMC_UsageLog',
           'Sat_Org_JavaSEDepRuleSet',
           'Sat_Org_JavaSEMSICustTools',
           'Sat_Org_JavaSEFlightRec')
y2_list = c('OJavaSESubscription_Elem_Sat_Org_ContinuedInvest',
           'OJavaSESubscription_Elem_Sat_Org_PatchesOlderV',
           'OJavaSESubscription_Elem_Sat_Org_JavaWebStartUpdates',
           'OJavaSESubscription_Elem_Sat_Org_DesktopManageUpdates',
           'OJavaSESubscription_Elem_Sat_Org_AutoUpdateTools',
           'OJavaSESubscription_Elem_Sat_Org_Monitoring',
           'OJavaSESubscription_Elem_Sat_Org_MyOSupport',
           'OJavaSESubscription_Elem_Sat_Org_AccessCloud',
           'OJavaSESubscription_Elem_Sat_Org_FlexLicensing',
           'OJavaSESubscription_Elem_Sat_Org_LegacyJava',
           'OJavaSESubscription_Elem_Sat_Org_Other')
y3_list = c('OJavaSESubscription_Attr_Sat_CommMethods',
           'OJavaSESubscription_Attr_Sat_PhoneSupport',
           'OJavaSESubscription_Attr_Sat_SSKnowledge',
           'OJavaSESubscription_Attr_Sat_CoNeedsUnd',
           'OJavaSESubscription_Attr_Sat_TrainingQual',
           'OJavaSESubscription_Attr_Sat_RepsonseTime')

# specify predictor variable gorupings
x0_list = c('Use_Org_EclipseIDE',
           'Use_Org_IntelliJIDE',
           'Use_Org_JDeveloper',
           'Use_Org_NetBeansIDE',
           'Use_Org_RationalAppDev',
           'Use_Org_VisualStudio',
           'Use_Org_Other')
x1_list = c('Use_Org_JavaSEAMC',
           'Use_Org_JavaSEAMC_UsageLog',
           'Use_Org_JavaSEDepRuleSet',
           'Use_Org_JavaSEMSICustTools',
           'Use_Org_JavaSEFlightRec')
x2_list = c('OJavaSESubscription_Elem_Imp_Org_ContinuedInvest',
           'OJavaSESubscription_Elem_Imp_Org_PatchesOlderV',
           'OJavaSESubscription_Elem_Imp_Org_JavaWebStartUpdates',
           'OJavaSESubscription_Elem_Imp_Org_DesktopManageUpdates',
           'OJavaSESubscription_Elem_Imp_Org_AutoUpdateTools',
           'OJavaSESubscription_Elem_Imp_Org_Monitoring',
           'OJavaSESubscription_Elem_Imp_Org_MyOSupport',
           'OJavaSESubscription_Elem_Imp_Org_AccessCloud',
           'OJavaSESubscription_Elem_Imp_Org_FlexLicensing',
           'OJavaSESubscription_Elem_Imp_Org_LegacyJava',
           'OJavaSESubscription_Elem_Imp_Org_Other')
x3_list = c('OJavaSESubscription_Attr_Imp_CommMethods',
           'OJavaSESubscription_Attr_Imp_PhoneSupport',
           'OJavaSESubscription_Attr_Imp_SSKnowledge',
           'OJavaSESubscription_Attr_Imp_CoNeedsUnd',
           'OJavaSESubscription_Attr_Imp_TrainingQual',
           'OJavaSESubscription_Attr_Imp_RepsonseTime')





dim(mod_df)

temp = mod_df[y0_list] * mod_df[x0_list]
names(temp) = paste(names(temp),"_w", sep="")
modw_df = cbind(mod_df,temp)

temp = mod_df[y1_list] * mod_df[x1_list]
names(temp) = paste(names(temp),"_w", sep="")
modw_df = cbind(modw_df,temp)

temp = mod_df[y2_list] * mod_df[x2_list]
names(temp) = paste(names(temp),"_w", sep="")
modw_df = cbind(modw_df,temp)

temp = mod_df[y3_list] * mod_df[x3_list]
names(temp) = paste(names(temp),"_w", sep="")
modw_df = cbind(modw_df,temp)

y0w_list = paste(y0_list,"_w", sep="")
y1w_list = paste(y1_list,"_w", sep="")
y2w_list = paste(y2_list,"_w", sep="")
y3w_list = paste(y3_list,"_w", sep="")

# construct yvar
y123w_var = rowMeans(modw_df[c(y1w_list,y2w_list,y3w_list)],na.rm=TRUE)
y <- y123w_var

# construct X
X = modw_df[c(catg_dummy_list,cont_dummy_list,dummy0_dummy_list)]
X[,c(y1_list,y2_list,y3_list,
     x1_list,x2_list,x3_list)] <- list(NULL)

# replace NAs with means
X_nas = sapply(X, function(x) sum(is.na(x)))[sapply(X, function(x) sum(is.na(x)))>0]/dim(X)[1]
write.csv(X_nas,"X_nas.csv")
sum(is.na(y123w_var))/length(y123w_var) # 3.07%

X <- X %>% mutate_all(~ifelse(is.na(.x), mean(.x, na.rm = TRUE), .x))   
y <- replace_na(y,mean(y, na.rm=TRUE))

X['y123w_mean'] <- y

smp_siz = floor(0.8*nrow(X))
train_ind = sample(seq_len(nrow(X)),size = smp_siz) 
X_train = X[train_ind,] 
X_test = X[-train_ind,] 



# fit model
ranger_01 <- ranger(y123w_mean ~ . , data = X_train ,
                    importance = 'impurity', num.trees=10000)


# save(ranger_01, file="../../data/output/ranger_01")

ranger_predict_01 <- predict(ranger_01, 
                             data = X_test,
                             type="response")$predictions



ranger_01$prediction.error
ranger_01$r.squared

ranger_01$variable.importance


clf = RandomForestRegressor(n_estimators = 1000, random_state = 42)
clf.fit(X_train,y_train)

# Use the forest's predict method on the test data
y_pred = clf.predict(X_test)
# Calculate the absolute errors
errors = abs(y_pred - y_test)
# Print out the mean absolute error (mae)
MeanAbsoluteError=round(np.mean(errors), 2)

# Calculate mean absolute percentage error (MAPE)
mape = 100 * (errors / y_test.replace(0, np.nan))
# Calculate and display accuracy
accuracy = 100 - np.mean(mape)

# Get numerical feature importances
importances = list(clf.feature_importances_)
# List of tuples with variable and importance
feature_importances = [(feature, round(importance, 2)) 
                       for feature, importance in zip(X.columns, importances)]


feature_importances = sorted(feature_importances, key = lambda x: x[1], reverse = True)
varimp0 = ", ".join(map(str,feature_importances[0]))
varimp1 = ", ".join(map(str,feature_importances[1]))
varimp2 = ", ".join(map(str,feature_importances[2]))

# Write out the feature and importances 
imp_df =  pd.DataFrame(feature_importances, columns = ['var', 'imp'])
imp_df.to_csv(imp_filename, index=False)


