# -*- coding: utf-8 -*-
"""Untitled2.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1M05UvbFro49rOxyUQTGd8XOq35nJDWfC
"""

import pandas as pd
import numpy as np
import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression 
from sklearn.metrics import r2_score
import matplotlib.pyplot as plt
from numpy import savetxt
from sklearn.ensemble import RandomForestRegressor
from sklearn.datasets import make_regression

train = pd.read_csv("realestate.csv")

print(train)

df1 = pd.DataFrame(train, columns=['sq__ft', 'price'])
df_filtered = df1[df1['sq__ft'] > 50]
df_filtered = df_filtered[df_filtered['sq__ft'] < 4000]
X=df_filtered['sq__ft']
y=df_filtered['price']

x_train, x_test, y_train, y_test = train_test_split(X,y, test_size=0.2, random_state=42)
x_train = np.array(x_train)
y_train = np.array(y_train)
x_test = np.array(x_test)
y_test = np.array(y_test)
x_train = x_train.reshape(-1,1)
x_test = x_test.reshape(-1,1)

regr = RandomForestRegressor(max_depth=3, random_state=0)
regr.fit(x_train, y_train)
y_pred = regr.predict(x_test)
print(r2_score(y_test,y_pred))
plt.plot(x_test, y_pred)
plt.scatter(x_train, y_train, s=1, c = "black")

clf = LinearRegression(normalize=True)
clf.fit(x_train,y_train)
y_pred = clf.predict(x_test)
print(r2_score(y_test,y_pred))

area = [1200 , 950]
area=np.array(area)
area = area.reshape(-1,1)
price=clf.predict(area)
plt.plot(x_test, y_pred)
plt.scatter(x_train, y_train, s=1, c = "black")

print(clf.predict(area))