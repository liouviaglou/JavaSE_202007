# Java SE 202007 Analysis

## Timelog

| Date     | Time     | Desc   |
|----------|----------|--------|
| 20200701 | 1.75h    | deduping     |

## Lab Notebook

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
- Parse '... On a scale from 0 to 10...', x=x-1



### 20200701

Recieved data, prepped raw data file for analysis. 

Questions: What are 'Custom Variable 1' - 'Custom Variable 5'?

How to proceed with deduping, emailed client.


