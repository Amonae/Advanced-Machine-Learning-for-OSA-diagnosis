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

### Exploring features

Initial exploration of features by severity using histograms. Also shows association of each feature with severity
https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/feature_distribution_comp_pat.ipynb -

This uses various methods (correlation, kruskal-wallis, chi2, feature_importance) to explore which features are most important
https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/Important%20features.ipynb

This creates feature lists based on similar studies (as mentioned in the dissertation Table 11) and examines the effects of using different feature lists by classifier. Each result table reflects a feature set and includes performance metrics for several algorithms.
https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/Feature%20Selection_classifier.ipynb

This is the same concept as above, but seach result table reflects an algorithm and includes performance metrics by feature set. It also includes confusion matrices for the feature sets with the highest balanced accuracy for each model.  
https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/Feature%20Selection_category.ipynb

The following notebooks contain the results of pairwise model analysis. It is the same analysis comparing algorithms by feature sets, however, classification is binary and severities are separated in a pairwise manner (0v1, 0v2, 0v3, 1v2 etc). This is not included in the dissertation but it does offer interesting results.

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/Feature%20Selection_category_0_1.ipynb - 0v1

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/Feature%20Selection_category_0_2.ipynb - 0v2

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/Feature%20Selection_category_0_3.ipynb - 0v3

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/Feature%20Selection_category_1_2.ipynb - 1v2

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/Feature%20Selection_category_1_3.ipynb - 1v3

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/Feature%20Selection_category_2_3.ipynb - 2v3


### Outlier identification and removal using Z score and IQR followed by classification with Random Forest can be found here
It also contains boxplots for continuous feature distribution by severity

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/Outlier%20Identification.ipynb

### Incorrect prediction interpretations

This notebook looks at incorrectly classified samples and explores the association between severity and features within correctly and incorrectly classified samples of each severity

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/Severity_vs_features_comp_pat.ipynb

This notebook shows boxplots of the feature distribution for correctly and incorrectly classified samples of each severity. 

https://github.com/Amonae/Advanced-Machine-Learning-for-OSA-diagnosis/blob/main/inc_class_boxplots.ipynb






