data = read.csv(file.choose(), row.names = 1)
View(data)
str(data)
features = c('Sex', 'Age', 'Current_smoker', 'Former_smoker',
            'Sedentary', 'Height', 'Weight', 'Cervical_perimeter',
            'Abdominal_perimeter', 'Systolic_BP', 'Diastolic_BP',
            'Maxillofacial_profile', 'BMI', 'High_BP', 'Asthma', 'Rhinitis', 'COPD',
            'Respiratory_fail', 'Myocardial_infarct', 'Coronary_fail',
            'Arrhythmias', 'Stroke', 'Heart_fail', 'Arteriopathy', 'Gastric_reflux',
            'Glaucoma', 'Diabetes', 'Hypercholesterolemia', 'Hypertriglyceridemia',
            'Hypo.er.thyroidism', 'Depression', 'Obesity', 'Dysmorphology',
            'Restless_Leg_Syndrome', 'Snoring', 'Diurnal_somnolence',
            'Driving_drowsiness', 'Morning_fatigue', 'Morning_headache',
            'Memory_problem', 'Nocturnal_perspiration',
            'Shortness_of_breath_on_exertion', 'Nocturia', 'Drowsiness_accident',
            'Near_miss_accident', 'Respiratory_arrest', 'Epworth_scale',
            'Pichots_scale', 'Depression_scale')
continuous = c('Age','Height','Weight','Cervical_perimeter','Abdominal_perimeter','Systolic_BP','Diastolic_BP', 
              'BMI','Epworth_scale','Pichots_scale','Depression_scale')
categorical = setdiff(features, continuous)

# converting categorical to factor
data[,categorical] <- lapply(data[,categorical] , factor)
str(data)

# no missing severities
sum(is.na(data$Severity))



#MICE
# usefule sites: https://datasciencebeginners.com/2018/11/11/a-brief-introduction-to-mice-r-package/
#                https://datascienceplus.com/handling-missing-data-with-mice-package-a-simple-approach/
#                https://datascienceplus.com/imputing-missing-data-with-r-mice-package/
#                https://www.analyticsvidhya.com/blog/2016/03/tutorial-powerful-packages-imputing-missing-values/


install.packages("mice")
library(mice)
methods(mice)   #methods that can be used with mice

initial = mice(data, maxit=0) 
meth = initial$method # methods to be used. Default is PMM for continuous and logreg for categorical
predM = initial$predictorMatrix   # predictorMatrix is a matrix which tells the algorithm which variables predict missingness in which other variables

predM[, c("Severity", "PatientID")]=0  # not using severity or patinet ID as a predictor
 


set.seed(103)
imputed = mice(data, method=meth, predictorMatrix=predM, m=5, maxit = 20)  # maxit = 5 as default. May want to increase for accuracy. Recommended 20-30

imputed1 = complete(imputed,1) # apply imputations to dataset 1st iteration
imputed2 = complete(imputed,2) # apply imputations to dataset 1st iteration
imputed3 = complete(imputed,3) # apply imputations to dataset 1st iteration
imputed4 = complete(imputed,4) # apply imputations to dataset 1st iteration
imputed5 = complete(imputed,5) # apply imputations to dataset 1st iteration


sapply(imputed1, function(x) sum(is.na(x))) # check for NAs in new dataset

write.csv(imputed1, "mice_imp1_maxit20.csv")
write.csv(imputed2, "mice_imp2_maxit20.csv")
write.csv(imputed3, "mice_imp3_maxit20.csv")
write.csv(imputed4, "mice_imp4_maxit20.csv")
write.csv(imputed5, "mice_imp5_maxit20.csv")





# paralellization
install.packages('doParallel')
library(doParallel)
set.seed(103)

registerDoParallel(cores=3)


#missForest
# useful site = https://rpubs.com/lmorgan95/MissForest

install.packages("missForest")
library(missForest)

data_features = data[,-c(1,51)] # removing Patient ID and Severity so they won't be included in feature imputation 

forest_imp = missForest(data_features, verbose = T, ntree = 10, maxiter = 1, parallelize = "forests") # maxiter = 10 by default. Monitor OOB error estimate across iterations and if it's not increasing with more iterations, lower maxiter

#parallelize = "variables"
#parallelize = "forests"

#check imputed values
data_forest.forest_imp$ximp

#check imputation error. 
#NRMSE is normalized mean squared error. It is used to represent error derived from imputing continuous values. PFC (proportion of falsely classified) is used to represent error derived from imputing categorical values.
data_forest.forest_imp$OOBerror




#HMISC

#install package and load library
install.packages("Hmisc")
library(Hmisc)


hmisc_impute = aregImpute(~ Sex+ Age+ Current_smoker+ Former_smoker+
                          Sedentary+ Height+ Weight+ Cervical_perimeter+
                          Abdominal_perimeter+ Systolic_BP+ Diastolic_BP+
                          Maxillofacial_profile+ BMI+ High_BP+ Asthma+ Rhinitis+ COPD+
                          Respiratory_fail+ Myocardial_infarct+ Coronary_fail+
                          Arrhythmias+ Stroke+ Heart_fail+ Arteriopathy+ Gastric_reflux+
                          Glaucoma+ Diabetes+ Hypercholesterolemia+ Hypertriglyceridemia+
                          Hypo.er.thyroidism+ Depression+ Obesity+ Dysmorphology+
                          Restless_Leg_Syndrome+ Snoring+ Diurnal_somnolence+
                          Driving_drowsiness+ Morning_fatigue+ Morning_headache+
                          Memory_problem+ Nocturnal_perspiration+
                          Shortness_of_breath_on_exertion+ Nocturia+ Drowsiness_accident+
                          Near_miss_accident+ Respiratory_arrest+ Epworth_scale+
                          Pichots_scale+ Depression_scale, data = data_features, n.impute = 1)    # 1 imputation took 30 minutes. Default 4 iterations. About 8 minutes per iteration


#extract  the imputation dataset from the imputed object created by the aregImpute object
hmisc_impute1 = impute.transcan(hmisc_impute, imputation=1, data=data_features, list.out=TRUE,
                           pr=FALSE, check=FALSE)

#convert the impute1 list into a dataframe
completed_hmisc_impute1 = data.frame(hmisc_impute1)

write.csv(completed_hmisc_impute1, "completed_hmisc_impute1.csv")


hmisc_impute_5 = aregImpute(~ Sex+ Age+ Current_smoker+ Former_smoker+
                            Sedentary+ Height+ Weight+ Cervical_perimeter+
                            Abdominal_perimeter+ Systolic_BP+ Diastolic_BP+
                            Maxillofacial_profile+ BMI+ High_BP+ Asthma+ Rhinitis+ COPD+
                            Respiratory_fail+ Myocardial_infarct+ Coronary_fail+
                            Arrhythmias+ Stroke+ Heart_fail+ Arteriopathy+ Gastric_reflux+
                            Glaucoma+ Diabetes+ Hypercholesterolemia+ Hypertriglyceridemia+
                            Hypo.er.thyroidism+ Depression+ Obesity+ Dysmorphology+
                            Restless_Leg_Syndrome+ Snoring+ Diurnal_somnolence+
                            Driving_drowsiness+ Morning_fatigue+ Morning_headache+
                            Memory_problem+ Nocturnal_perspiration+
                            Shortness_of_breath_on_exertion+ Nocturia+ Drowsiness_accident+
                            Near_miss_accident+ Respiratory_arrest+ Epworth_scale+
                            Pichots_scale+ Depression_scale, data = data_features, n.impute = 5) 
