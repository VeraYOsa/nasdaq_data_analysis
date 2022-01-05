# -*- coding: utf-8 -*-
"""
Created on Tue Jan  4 17:49:38 2022

@author: inesr
"""
import pandas as pd
import quandl


#%% Read data
output_folder = (r'C:\Users\inesr\OneDrive\Documentos\nasdaq\\')

quandl.ApiConfig.api_key = "sqWWxGfThfzLsmyptXgy"
ESP =  pd.DataFrame()
input_files = ('ODA/ESP_PPPPC', 'ODA/ESP_LP', 'ODA/ESP_LUR', 'ODA/ESP_PCPIPCH','ODA/ESP_GGXWDG_NGDP')
li = []

for i in input_files:
    ESP = quandl.get(i, end_date='2021-12-31').reset_index(level=['Date'])
    ESP['variable'] = i
    li.append(ESP)

esp = pd.concat(li, axis=0, ignore_index=True).dropna()
esp = esp.pivot_table(index=['Date'], columns='variable', values='Value', aggfunc='first').reset_index()


#what each code means
codes =  pd.DataFrame()
codes = pd.read_csv(output_folder+'codes.csv')



#%% Rename columns

esp = esp.rename(columns = lambda x : str(x)[8:])  # remove the ".csv" from the column name
esp.columns = esp.columns.str.replace('_', '')
esp = esp.rename(columns={'':'Date'})

#%% Export data to csv


# saving the csv
esp.to_csv(output_folder + 'nasdap.csv')



#%% Simple Plot
import matplotlib.pyplot as plt

# Data for plotting
t = esp['Date']
s = esp['GGXWDGNGDP']

fig, ax = plt.subplots()
ax.plot(t, s)

ax.set(xlabel='time (s)', ylabel='Value',
       title='Title goes here')
# ax.grid() #gridlines

# fig.savefig("test.png") #save plot
plt.show()

