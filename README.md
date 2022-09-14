# Advanced-Machine-Learning-for-OSA-diagnosis
This is the code that accompanies the SCM8053 2021/2022 dissertation of the same title

### Pre-processing is covered in the following files:

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/Risha_comparison.ipynb  - 
This outlines how the OFSP_original csv was converted into OFSP_rpt_rmv by converting it into English and removing repeated columns

and

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/OFSP_English_Amonae_09May.ipynb - 
This details the process of subsetting the features in OFSP_rpt_rmv, removing duplicate observations, removing features with >80% missingness, etc. It also shows preliminary classifier comparison that was not included in the dissertation

### Missing value imputation was done before any further analysis. Steps are in the following files:


https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/Missing_val_imp.ipynb - 
This includes simple imputation using sklearn and RF models built using imputed data

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/MICE.R - 
This is the code used to impute missing values using MICE and HMISC in R

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/missing_value_imp_R.ipynb - 
This inlcudes RF models built using data imputed with MICE in R. It also features experimentation with varying class weights to improve RF model performance


https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/RF_no_nan_data.ipynb - 
This inlcues the code for creating the "OSA_complete_patients" csv which removes all patients with missing data, circumventing the need for missing data imputation. All further analysis is done using this csv.   



### A preliminary comparison of classifiers using imbalanced data. This data is not included in the dissertation

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/Classifier_comparison_complete_patients.ipynb

### Comparison of classifiers using imbalanced, SMOTE, and ADASYN data: 

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/SMOTE__complete_patients.ipynb

### Hyperparameter tuning of the RandomForest model using randomsearch and HyperOpt

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/Hyperparam_tuning_complete_patients.ipynb

