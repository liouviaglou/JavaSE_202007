# Java SE 202007 Analysis

## Timelog

| Date     | Time     | Desc   |
|----------|----------|--------|
| 20200701 | 1.75h    | deduping     |
| 20200702 | 5h       | data prep     |
| 20200703 | 2h       | data prep     |
| 20200703 | 1h       | decision tree play & plan     |
| 20200703 | 2h       | decision tree execute     |
| 20200703 | 1h       | pipeline set-up    |
| 20200703 | 0.5h     | pipeline parse   |
| 20200704 | 7h       | RF & DTREE mass pipeline > results   |
| 20200705 | 8h       | Summary, Deliverable   |
| 20200707 | 8h     | Summary, Deliverable   |
| 20200708 | 5h     | Summary, Deliverable   |
| 20200709 | 1.5h     | Internal meting   |
| 20200709 | 7h  | Freq & Crosstabs   |

41.25 h 0701-0708

## Lab Notebook



### 20200707

Issue: RF in Python requires one-hot encoding is sub-optimal [link](https://towardsdatascience.com/one-hot-encoding-is-making-your-tree-based-ensembles-worse-heres-why-d64b282b5769)

1. trying quick R run with Ranger and f = y123w ~ .

### 20200705

Plan: synthesize findings


### 20200704_2

Summary: Looking at Satisfaction variables individually or in agregate (i.e. sum across Tools, Attr, Elem) leads to multiple statistically significant results. Looking at a wegihted Satisfaction (weighted by Imp or Use) leads to fewer statistically significant results since now the Imp/Use  variable can no longer be a factor. 

I looked at sum of Satisfaction instead of mean. Meaning that 2 attributes answered with Satisfaction of 5 would be seen as equiv to 1 attrbute with satisfaction of 10.

##### DTREE Results

| response                               | R2_test  | First Split                      | Depth | %Miss |
|----------------------------------------|----------|----------------------------------|-------|----------|
| Sat_Org_JavaSEFlightRec                | 0.727234 | Sat w SEMSICustTools             | 5     | 36% train, 32%test
| y12_sum                                | 0.765901 | Imp of JavaWebStartUpdates       | 1     | 0% train, 0% test
| y2_sum                                 | 0.762853 | Imp of AutoUpdateTools           | 4     | 0% train, 0% test
| y13_sum                                | 0.743953 | Use of SEMSICustTools            | 5     | 0% train, 0% test
| y23_sum                                | 0.727879 | Purch Imp InnovationPotatial     | 8     | 0% train, 0% test
| y123_sum                               | 0.666335 | Purch Imp VendorSupport          | 6     | 0% train, 0% test



| sum_var|    score |   y_na |
|:-------|---------:|-------:|
| y2w    | 0.654119 |      0 |
| y23w   | 0.636916 |      0 |
| y123w  | 0.603959 |      0 |


##### RF Results

| var                                                   |   accuracy |     y_na | varimp0                                                     | varimp1                                                     | varimp2                                                |
|:------------------------------------------------------|-----------:|---------:|:------------------------------------------------------------|:------------------------------------------------------------|:-------------------------------------------------------|
| OJavaSESubscription_Elem_Sat_Org_Other                |    96.7259 | 0.903509 | OJavaSESubscription_Elem_Imp_Org_Other, 0.84                | Java_Dev_Dist_JVM, 0.01                                     | Platform_Dev_Org_LinuxOther_P, 0.01                    |
| OJavaSESubscription_Elem_Sat_Org_Monitoring           |    86.6548 | 0.346491 | OJavaSESubscription_Elem_Imp_Org_Monitoring, 0.13           | OJavaSESubscription_Elem_Sat_Org_LegacyJava, 0.12           | OJavaSESubscription_Elem_Sat_Org_AutoUpdateTools, 0.09 |
| OJavaSESubscription_Elem_Sat_Org_ContinuedInvest      |    85.2248 | 0.245614 | OJavaSESubscription_Elem_Imp_Org_ContinuedInvest, 0.45      | OJavaSESubscription_Elem_Sat_Org_PatchesOlderV, 0.03        | Information_Channel_Imp_OWebsites, 0.02                |
| OJavaSESubscription_Elem_Sat_Org_AccessCloud          |    84.9935 | 0.377193 | OJavaSESubscription_Elem_Imp_Org_AccessCloud, 0.22          | OJavaSESubscription_Elem_Imp_Org_MyOSupport, 0.14           | OJavaSESubscription_Elem_Sat_Org_MyOSupport, 0.1       |
| OJavaSESubscription_Elem_Sat_Org_AutoUpdateTools      |    84.9401 | 0.333333 | OJavaSESubscription_Elem_Imp_Org_AutoUpdateTools, 0.24      | OJavaSESubscription_Elem_Sat_Org_DesktopManageUpdates, 0.12 | OJavaSESubscription_Elem_Sat_Org_Monitoring, 0.1       |
| Sat_Org_JavaSEFlightRec                               |    82.6321 | 0.346491 | Sat_Org_JavaSEMSICustTools, 0.32                            | Use_Org_JavaSEFlightRec, 0.18                               | Sat_Org_JavaSEAMC_UsageLog, 0.1                        |
| OJavaSESubscription_Elem_Sat_Org_DesktopManageUpdates |    81.3599 | 0.333333 | OJavaSESubscription_Elem_Sat_Org_JavaWebStartUpdates, 0.45  | OJavaSESubscription_Elem_Sat_Org_MyOSupport, 0.09           | OJavaSESubscription_Elem_Sat_Org_PatchesOlderV, 0.07   |
| OJavaSESubscription_Elem_Sat_Org_MyOSupport           |    80.4093 | 0.346491 | OJavaSESubscription_Elem_Imp_Org_MyOSupport, 0.3            | OJavaSESubscription_Elem_Sat_Org_DesktopManageUpdates, 0.08 | OJavaSESubscription_Elem_Sat_Org_Monitoring, 0.06      |
| OJavaSESubscription_Elem_Sat_Org_PatchesOlderV        |    77.6419 | 0.258772 | OJavaSESubscription_Elem_Sat_Org_DesktopManageUpdates, 0.15 | OJavaSESubscription_Elem_Sat_Org_Monitoring, 0.06           | OJavaSESubscription_Elem_Sat_Org_ContinuedInvest, 0.05 |
| OJavaSESubscription_Attr_Sat_RepsonseTime             |    77.6119 | 0.118421 | OJavaSESubscription_Attr_Sat_CommMethods, 0.17              | OJavaSESubscription_Attr_Sat_SSKnowledge, 0.12              | OJavaSESubscription_Attr_Sat_PhoneSupport, 0.09        |
| Sat_Org_JavaSEAMC_UsageLog                            |    76.9443 | 0.245614 | Sat_Org_JavaSEDepRuleSet, 0.21                              | Use_Org_JavaSEAMC_UsageLog, 0.13                            | Sat_Org_JavaSEAMC, 0.12                                |
| Sat_Org_JavaSEAMC                                     |    76.4527 | 0.184211 | Sat_Org_JavaSEAMC_UsageLog, 0.29                            | Use_Org_JavaSEAMC, 0.26                                     | Sat_Org_JavaSEFlightRec, 0.03                          |
| OJavaSESubscription_Attr_Sat_CoNeedsUnd               |    76.1308 | 0.100877 | OJavaSESubscription_Attr_Sat_SSKnowledge, 0.23              | OJavaSESubscription_Attr_Sat_TrainingQual, 0.12             | OJavaSESubscription_Attr_Sat_PhoneSupport, 0.06        |
| Sat_Org_JavaSEDepRuleSet                              |    74.6006 | 0.258772 | Sat_Org_JavaSEMSICustTools, 0.36                            | Use_Org_JavaSEDepRuleSet, 0.23                              | Sat_Org_JavaSEAMC_UsageLog, 0.08                       |
| OJavaSESubscription_Attr_Sat_SSKnowledge              |    74.4604 | 0.109649 | OJavaSESubscription_Attr_Sat_CoNeedsUnd, 0.25               | OJavaSESubscription_Attr_Sat_PhoneSupport, 0.17             | OJavaSESubscription_Attr_Sat_CommMethods, 0.07         |
| OJavaSESubscription_Elem_Sat_Org_JavaWebStartUpdates  |    73.2456 | 0.337719 | OJavaSESubscription_Elem_Sat_Org_DesktopManageUpdates, 0.45 | OJavaSESubscription_Elem_Imp_Org_JavaWebStartUpdates, 0.15  | Sat_Org_RationalAppDev, 0.02                           |
| OJavaSESubscription_Elem_Sat_Org_LegacyJava           |    70.7966 | 0.355263 | OJavaSESubscription_Elem_Sat_Org_PatchesOlderV, 0.12        | OJavaSESubscription_Elem_Sat_Org_Monitoring, 0.08           | OJavaSESubscription_Elem_Sat_Org_ContinuedInvest, 0.06 |
| OJavaSESubscription_Elem_Sat_Org_FlexLicensing        |    70.4454 | 0.328947 | OJavaSESubscription_Elem_Imp_Org_FlexLicensing, 0.32        | OJavaSESubscription_Elem_Sat_Org_LegacyJava, 0.07           | OJavaSESubscription_Elem_Sat_Org_Monitoring, 0.05      |
| OJavaSESubscription_Attr_Sat_TrainingQual             |    69.6592 | 0.122807 | OJavaSESubscription_Attr_Sat_CoNeedsUnd, 0.17               | OJavaSESubscription_Attr_Sat_CommMethods, 0.12              | OJavaSESubscription_Attr_Sat_SSKnowledge, 0.07         |
| OJavaSESubscription_Attr_Sat_PhoneSupport             |    68.9642 | 0.188596 | OJavaSESubscription_Attr_Sat_SSKnowledge, 0.18              | OJavaSESubscription_Attr_Imp_PhoneSupport, 0.09             | OJavaSESubscription_Attr_Sat_CommMethods, 0.08         |


| var   |   accuracy |   y_na | varimp0                                                    | varimp1                                                       | varimp2                                                    |
|:------|-----------:|-------:|:-----------------------------------------------------------|:--------------------------------------------------------------|:-----------------------------------------------------------|
| y3_sum    |    76.9132 |      0 | OJavaSESubscription_Attr_Imp_PhoneSupport, 0.19            | Information_Channel_Imp_UserComm, 0.09                        | OJavaSESubscription_Attr_Imp_RepsonseTime, 0.07            |
| y13_sum   |    75.8782 |      0 | Use_Org_JavaSEMSICustTools, 0.26                           | OJavaSESubscription_Attr_Imp_PhoneSupport, 0.09               | Information_Channel_Imp_UserComm, 0.06                     |
| y23_sum   |    70.395  |      0 | OJavaSESubscription_OrgPurch_Imp_InnovationPotential, 0.12 | OJavaSESubscription_OrgPurch_Imp_InnovationContribution, 0.11 | OJavaSESubscription_OrgPurch_Imp_VendorSupport, 0.09       |
| y123_sum  |    68.9382 |      0 | OJavaSESubscription_OrgPurch_Imp_VendorSupport, 0.11       | OJavaSESubscription_OrgPurch_Imp_InnovationContribution, 0.1  | OJavaSESubscription_Elem_Imp_Org_JavaWebStartUpdates, 0.07 |

| var   |   accuracy |      y_na | varimp0                                           | varimp1                                              | varimp2                                                |
|:------|-----------:|----------:|:--------------------------------------------------|:-----------------------------------------------------|:-------------------------------------------------------|
| y2_mean    |    86.1787 | 0.214912  | OJavaSESubscription_Elem_Imp_Org_Monitoring, 0.17 | OJavaSESubscription_Elem_Imp_Org_FlexLicensing, 0.07 | OJavaSESubscription_Attr_Imp_SSKnowledge, 0.06         |
| y3_mean    |    80.9267 | 0.0482456 | OJavaSESubscription_Attr_Imp_SSKnowledge, 0.19    | OJavaSESubscription_Attr_Imp_CoNeedsUnd, 0.08        | OJavaSESubscription_Elem_Sat_Org_ContinuedInvest, 0.05 |
| y13_mean   |    76.4744 | 0.0307018 | OJavaSESubscription_Attr_Imp_CoNeedsUnd, 0.23     | Use_Org_JavaSEAMC, 0.08                              | OJavaSESubscription_Elem_Sat_Org_ContinuedInvest, 0.08 |
| y23_mean   |    74.2037 | 0.0394737 | OJavaSESubscription_Attr_Imp_SSKnowledge, 0.19    | OJavaSESubscription_Attr_Imp_RepsonseTime, 0.07      | OJavaSESubscription_Attr_Imp_PhoneSupport, 0.06       

| var                                                     |   accuracy |      y_na | varimp0                                                    | varimp1                                                     | varimp2                                              |
|:--------------------------------------------------------|-----------:|----------:|:-----------------------------------------------------------|:------------------------------------------------------------|:-----------------------------------------------------|
| OJavaSESubscription_Elem_Sat_Org_Other_w                |    98.4682 | 0.903509  | OJavaSESubscription_Elem_Sat_Org_Other, 0.73               | OJavaSESubscription_Elem_Imp_Org_Other, 0.22                | Country_Code_AU, 0.0                                 |
| OJavaSESubscription_Elem_Sat_Org_Monitoring_w           |    94.7048 | 0.346491  | OJavaSESubscription_Elem_Sat_Org_Monitoring, 0.49          | OJavaSESubscription_Elem_Imp_Org_Monitoring, 0.43           | Country_Code_AU, 0.0                                 |
| OJavaSESubscription_Elem_Sat_Org_FlexLicensing_w        |    93.0468 | 0.333333  | OJavaSESubscription_Elem_Sat_Org_FlexLicensing, 0.75       | OJavaSESubscription_Elem_Imp_Org_FlexLicensing, 0.19        | Country_Code_AU, 0.0                                 |
| OJavaSESubscription_Elem_Sat_Org_AccessCloud_w          |    92.1796 | 0.381579  | OJavaSESubscription_Elem_Sat_Org_AccessCloud, 0.5          | OJavaSESubscription_Elem_Imp_Org_AccessCloud, 0.43          | Country_Code_AU, 0.0                                 |
| OJavaSESubscription_Elem_Sat_Org_ContinuedInvest_w      |    92.0767 | 0.25      | OJavaSESubscription_Elem_Imp_Org_ContinuedInvest, 0.57     | OJavaSESubscription_Elem_Sat_Org_ContinuedInvest, 0.38      | Country_Code_AU, 0.0                                 |
| OJavaSESubscription_Elem_Sat_Org_AutoUpdateTools_w      |    91.877  | 0.337719  | OJavaSESubscription_Elem_Sat_Org_AutoUpdateTools, 0.63     | OJavaSESubscription_Elem_Imp_Org_AutoUpdateTools, 0.32      | Country_Code_AU, 0.0                                 |
| Sat_Org_JavaSEDepRuleSet_w                              |    89.7809 | 0.263158  | Use_Org_JavaSEDepRuleSet, 0.55                             | Sat_Org_JavaSEDepRuleSet, 0.4                               | Country_Code_AU, 0.0                                 |
| OJavaSESubscription_Attr_Sat_RepsonseTime_w             |    89.6316 | 0.118421  | OJavaSESubscription_Attr_Sat_RepsonseTime, 0.6             | OJavaSESubscription_Attr_Imp_RepsonseTime, 0.32             | OJavaSESubscription_Attr_Sat_TrainingQual, 0.01      |
| OJavaSESubscription_Elem_Sat_Org_MyOSupport_w           |    88.2781 | 0.346491  | OJavaSESubscription_Elem_Sat_Org_MyOSupport, 0.58          | OJavaSESubscription_Elem_Imp_Org_MyOSupport, 0.36           | Country_Code_AU, 0.0                                 |
| OJavaSESubscription_Elem_Sat_Org_DesktopManageUpdates_w |    88.1764 | 0.337719  | OJavaSESubscription_Elem_Imp_Org_DesktopManageUpdates, 0.5 | OJavaSESubscription_Elem_Sat_Org_DesktopManageUpdates, 0.42 | OJavaSESubscription_Elem_Sat_Org_PatchesOlderV, 0.01 |
| OJavaSESubscription_Attr_Sat_CommMethods_w              |    87.4349 | 0.0833333 | OJavaSESubscription_Attr_Sat_CommMethods, 0.48             | OJavaSESubscription_Attr_Imp_CommMethods, 0.46              | Country_Code_AU, 0.0                                 |
| Sat_Org_JavaSEFlightRec_w                               |    87.0056 | 0.350877  | Use_Org_JavaSEFlightRec, 0.52                              | Sat_Org_JavaSEFlightRec, 0.37                               | Information_Channel_Imp_IndustryPubs, 0.02           |
| OJavaSESubscription_Elem_Sat_Org_JavaWebStartUpdates_w  |    83.6293 | 0.342105  | OJavaSESubscription_Elem_Sat_Org_JavaWebStartUpdates, 0.56 | OJavaSESubscription_Elem_Imp_Org_JavaWebStartUpdates, 0.36  | OJavaSESubscription_Elem_Sat_Org_Monitoring, 0.01    |
| OJavaSESubscription_Attr_Sat_TrainingQual_w             |    81.8272 | 0.122807  | OJavaSESubscription_Attr_Imp_TrainingQual, 0.46            | OJavaSESubscription_Attr_Sat_TrainingQual, 0.46             | OJavaSESubscription_OrgPurch_Imp_Competition, 0.01   |
| OJavaSESubscription_Attr_Sat_SSKnowledge_w              |    81.5346 | 0.114035  | OJavaSESubscription_Attr_Sat_SSKnowledge, 0.58             | OJavaSESubscription_Attr_Imp_SSKnowledge, 0.37              | Country_Code_AU, 0.0                                 |
| Sat_Org_JavaSEMSICustTools_w                            |    80.1504 | 0.298246  | Use_Org_JavaSEMSICustTools, 0.57                           | Sat_Org_JavaSEMSICustTools, 0.34                            | Sat_Org_JavaSEAMC_UsageLog, 0.01                     |
| OJavaSESubscription_Elem_Sat_Org_PatchesOlderV_w        |    78.9522 | 0.263158  | OJavaSESubscription_Elem_Imp_Org_PatchesOlderV, 0.55       | OJavaSESubscription_Elem_Sat_Org_PatchesOlderV, 0.37        | Country_Code_AU, 0.0                                 |
| Sat_Org_JavaSEAMC_UsageLog_w                            |    78.2503 | 0.254386  | Use_Org_JavaSEAMC_UsageLog, 0.56                           | Sat_Org_JavaSEAMC_UsageLog, 0.36                            | Sat_Org_JavaSEMSICustTools, 0.01                     |
| OJavaSESubscription_Attr_Sat_CoNeedsUnd_w               |    77.8149 | 0.100877  | OJavaSESubscription_Attr_Imp_CoNeedsUnd, 0.47              | OJavaSESubscription_Attr_Sat_CoNeedsUnd, 0.45               | OJavaSESubscription_Attr_Sat_CommMethods, 0.02       |
| OJavaSESubscription_Attr_Sat_PhoneSupport_w             |    74.8308 | 0.192982  | OJavaSESubscription_Attr_Sat_PhoneSupport, 0.58            | OJavaSESubscription_Attr_Imp_PhoneSupport, 0.33             | OJavaSESubscription_Attr_Sat_SSKnowledge, 0.01       |
| OJavaSESubscription_Elem_Sat_Org_LegacyJava_w           |    74.6804 | 0.355263  | OJavaSESubscription_Elem_Sat_Org_LegacyJava, 0.46          | OJavaSESubscription_Elem_Imp_Org_LegacyJava, 0.44           | OJavaSESubscription_Elem_Imp_Org_FlexLicensing, 0.01 |v



| var       |   accuracy |   y_na | varimp0                                                    | varimp1                                                       | varimp2                                                       |
|:----------|-----------:|-------:|:-----------------------------------------------------------|:--------------------------------------------------------------|:--------------------------------------------------------------|
| y23w_sum  |    69.9683 |      0 | OJavaSESubscription_OrgPurch_Imp_InnovationPotential, 0.19 | OJavaSESubscription_OrgPurch_Imp_VendorSupport, 0.1           | OJavaSESubscription_OrgPurch_Imp_InnovationContribution, 0.09 |
| y2w_sum   |    69.4245 |      0 | OJavaSESubscription_OrgPurch_Imp_InnovationPotential, 0.27 | OJavaSESubscription_OrgPurch_Imp_InnovationContribution, 0.08 | OJavaSESubscription_OrgPurch_Imp_VendorSupport, 0.07          |
| y123w_sum |    69.066  |      0 | OJavaSESubscription_OrgPurch_Imp_VendorSupport, 0.16       | OJavaSESubscription_OrgPurch_Imp_InnovationPotential, 0.11    | OJavaSESubscription_OrgPurch_Imp_InnovationContribution, 0.11 |
| y3w_sum   |    67.3608 |      0 | OJavaSESubscription_OrgPurch_Imp_PrPerRatio, 0.11          | Information_Channel_Imp_UserComm, 0.1                         | OJavaSESubscription_Elem_Sat_Org_ContinuedInvest, 0.07        |

| var       |   accuracy |      y_na | varimp0                                                | varimp1                                        | varimp2                                           |
|:----------|-----------:|----------:|:-------------------------------------------------------|:-----------------------------------------------|:--------------------------------------------------|
| y2w_mean  |    73.3615 | 0.219298  | OJavaSESubscription_Attr_Imp_SSKnowledge, 0.09         | OJavaSESubscription_Attr_Imp_CommMethods, 0.08 | OJavaSESubscription_Attr_Imp_PhoneSupport, 0.06   |
| y23w_mean |    73.2351 | 0.0394737 | OJavaSESubscription_OrgPurch_Imp_PrPerRatio, 0.12      | Information_Channel_Imp_OWebsites, 0.1         | Sat_Org_JavaSEAMC, 0.09                           |
| y13w_mean |    70.2459 | 0.0307018 | OJavaSESubscription_Elem_Sat_Org_ContinuedInvest, 0.13 | Information_Channel_Imp_OSalesPros, 0.08       | Information_Channel_Imp_PeerRec, 0.06             |
| y3w_mean  |    70.0355 | 0.0482456 | OJavaSESubscription_Elem_Sat_Org_ContinuedInvest, 0.11 | Information_Channel_Imp_OWebsites, 0.07        | OJavaSESubscription_OrgPurch_Imp_PrPerRatio, 0.07 |



### 20200704

Created pipeline and ran through all individual and gorup results. not sure ccp_alpha is being optimized

parse through results
qa results

try automl?



### 20200703_3

Plan: run through all depedend variable candidates and get the highest 


### 20200703_2

decision tree reuslts: satisfaction with a certain "subset" s largely driven by importance/use of that subset.
few other variables come into play
more interesting to look at overall satisfaction as a function of specific uses and importances

Most interesting result:
- response: Overall Satisfaction with elements of Oracle Java SE Subscription [OJavaSESubscription_Elem_Sat_Org_*] accuracy @ approx 0.75 
- response: Overall Satisfaction with elements AND attrbutes of Oracle Java SE Subscription (but excluding Oracle tools) ... accuracy @ approx 0.724 @ alpha=12.5. Variables driving high satisfaction: innovation potential as purchasing decision (>6.805) + % Java Devs in Org (>50%) + The Java SE Deployment Rule Set Satisfaction (0-10)[ , ]



### 20200703

Plan: 
- run through decision trees with various 'Satisfaction' repsonses & pick out lowest error, drill into insights
- execute decision tree with overall 'Satisfaction' metric
- random forest set up

Finished data prep.

Started decision tree play.

### 20200702

Deduped by removing all obs w/ 'Seq. Number' > 1.

Exploring data.

Possible depedent (sentiment) vars: "satisfaction weighted by usage" 

Todo: 
- exclude Company Name = Student, 
- Parse 'What is the approximate distribution of developers ...' from N% to N
- Parse 'Please provide approximate percentage(s) for each of the development ...' from N% to N
- Parse '... Level of use (0-10)': 12>NA, x=x-1
    though, it might be that Select is N/A, 0 is 1, 1 is 2,...10 is 11, N/A is 12
    verify with tool counts
    or is there a raw data key/map?
- Parse '... Usage (0-10)... ': 12>NA, x=x-1
    though, it might be that Select is N/A, 0 is 1, 1 is 2,...10 is 11, N/A is 12
    verify with tool counts
    or is there a raw data key/map?
- Parse '... Satisfaction (0-10)... ': 12>NA, x=x-1
- Parse 'Importance (0-10) ': 12>NA, x=x-1
- Parse Satisfaction (0-10)': 12>NA, x=x-1
- Parse '... a scale from 0 to 10...', x=x-1



### 20200701

Recieved data, prepped raw data file for analysis. 

Questions: What are 'Custom Variable 1' - 'Custom Variable 5'?

How to proceed with deduping, emailed client.


