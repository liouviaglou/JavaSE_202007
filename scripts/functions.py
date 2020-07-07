

def dtree_pipe (mod_df = mod_df, random_state=0,
               catg_dummy_list = catg_dummy_list,
               cont_dummy_list = cont_dummy_list,
               dummy0_dummy_list = dummy0_dummy_list,
               exlc_dummy_list = exlc_dummy_list,
               y_list = y1_list + y2_list + y3_list, # list of response variables, if len()>1, these will be summed or meaned
               X_list = catg_dummy_list + cont_dummy_list + dummy0_dummy_list, 
               X_drop = None, # list of additional predictors to drop 
               y_funct = 'mean', # either None, 'sum' or 'mean'. Must be one of non-None if len(y_list)>1
               vis_filename = '../data/output/dtree.png',
               ccpa_filename = '../data/output/ccpa.png'):

    if any(isinstance(el, list) for el in y_list): # flatten list if it's nested
        y_list = [item for sublist in y_list for item in sublist]
    if any(isinstance(el, list) for el in X_drop): # flatten list if it's nested
        X_drop = [item for sublist in X_drop for item in sublist]
    if isinstance(X_drop, tuple): # if tuple, convert to a list
        X_drop = list(X_drop)
    print(X_drop)

    X = mod_df.drop(y_list, axis=1, errors='ignore')[X_list].drop(X_drop, axis=1, errors='ignore')
    if y_funct == 'sum':
        y = mod_df[y_list].sum(axis=1,skipna=True)
    elif y_funct == 'mean':
        y = mod_df[y_list].mean(axis=1,skipna=True)
    else:
        y = mod_df[y_list]
        
    
    y_na = y.isna().sum()/len(y)
    

    X = X.fillna(X.mean())
    y = y.fillna(y.mean())
    X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=0)
    
    # find optimal ccp_alpha
    clf = DecisionTreeRegressor(random_state=0)
    path = clf.cost_complexity_pruning_path(X_train, y_train)
    ccp_alphas, impurities = path.ccp_alphas, path.impurities

    clfs = []
    for ccp_alpha in ccp_alphas:
        clf = DecisionTreeRegressor(random_state=random_state, ccp_alpha=ccp_alpha)
        clf.fit(X_train, y_train)
        clfs.append(clf)

    node_counts = [clf.tree_.node_count for clf in clfs]
    depth = [clf.tree_.max_depth for clf in clfs]

    path = clf.cost_complexity_pruning_path(X_train, y_train)
    ccp_alphas, impurities = path.ccp_alphas, path.impurities

    train_scores = [clf.score(X_train, y_train) for clf in clfs]
    test_scores = [clf.score(X_test, y_test) for clf in clfs]
    
    fig, ax = plt.subplots()
    ax.set_xlabel("alpha")
    ax.set_ylabel("accuracy")
    ax.set_title("Accuracy vs alpha for training and testing sets")
    ax.plot(ccp_alphas, train_scores, marker='o', label="train",
            drawstyle="steps-post")
    ax.plot(ccp_alphas, test_scores, marker='o', label="test",
            drawstyle="steps-post")
    ax.legend()
    plt.savefig(ccpa_filename)

    ccp_a_df = pd.DataFrame( {'ccp_alphas':ccp_alphas,
                              'train_scores':train_scores,
                              'test_scores':test_scores})
    ccp_a_df['diff'] = ccp_a_df.train_scores - ccp_a_df.test_scores
    ccp_alpha = ccp_a_df['ccp_alphas'].iloc[ccp_a_df['test_scores'].idxmax()]
    
    clf = DecisionTreeRegressor(random_state=0,ccp_alpha=ccp_alpha)
    clf.fit(X_train,y_train)
    
    dot_data = StringIO()
    export_graphviz(clf, out_file=dot_data,  
                    filled=True, rounded=True,
                    special_characters=True,
                   feature_names = X_train.columns)
    graph = pydotplus.graph_from_dot_data(dot_data.getvalue())
    pydotplus.graph_from_dot_data(dot_data.getvalue()).write_png(vis_filename)
    
    y_pred = clf.predict(X_test)
    score = clf.score(X_test, y_test)
    
    return(ccp_alpha,clf,score, y_na, ', '.join(X_drop) )



def rf_pipe (mod_df = mod_df, 
               catg_dummy_list = catg_dummy_list,
               cont_dummy_list = cont_dummy_list,
               dummy0_dummy_list = dummy0_dummy_list,
               exlc_dummy_list = exlc_dummy_list,
               y_list = y1_list + y2_list + y3_list, # list of response variables, if len()>1, these will be summed or meaned
               X_list = catg_dummy_list + cont_dummy_list + dummy0_dummy_list, 
               X_drop = None, # list of additional predictors to drop 
               y_funct = 'mean', # either None, 'sum' or 'mean'. Must be one of non-None if len(y_list)>1
               imp_filename = '../data/output/rf_imp.csv'):

    if any(isinstance(el, list) for el in y_list): # flatten list if it's nested
        y_list = [item for sublist in y_list for item in sublist]
    if any(isinstance(el, list) for el in X_drop): # flatten list if it's nested
        X_drop = [item for sublist in X_drop for item in sublist]
    if isinstance(X_drop, tuple): # if tuple, convert to a list
        X_drop = list(X_drop)
    

    if isinstance(y_list, list): # if tuple, convert to a list
        for y in y_list:
            try:
                X_list.remove(y)
            except:
                X_list = X_list
    else:
        try:
            X_list.remove(y_list)
        except:
            X_list = X_list
    
    
    X = mod_df.drop(y_list, axis=1, errors='ignore')[X_list].drop(X_drop, axis=1, errors='ignore')
    
    if y_funct == 'sum':
        y = mod_df[y_list].sum(axis=1,skipna=True)
    elif y_funct == 'mean':
        y = mod_df[y_list].mean(axis=1,skipna=True)
    else:
        y = mod_df[y_list]
        
    
    y_na = y.isna().sum()/len(y)
    

    X = X.fillna(X.mean())
    y = y.fillna(y.mean())
    X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=0)
   
 
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
    
   
    
    return(clf,MeanAbsoluteError, accuracy, y_na, varimp0,varimp1, varimp2, feature_importances, ', '.join(X_drop) )

   