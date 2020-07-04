# Java SE 202007 Analysis

## Timelog

| Date     | Time     | Desc   |
|----------|----------|--------|
| 20200701 | 1.75h    | deduping     |
| 20200702 | 5h       | data prep     |
| 20200703 | 2h       | data prep     |
| 20200703 | 1h       | decision tree play & plan     |
| 20200703 | 2h       | decision tree execute     |

## Lab Notebook



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


