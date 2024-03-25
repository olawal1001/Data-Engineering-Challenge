#!/usr/bin/env python
# coding: utf-8

# **CLEANING AND PREPROCESSING** 

# In[1]:


import pandas as pd


# In[2]:


import pyodbc


# In[3]:


dataframe = pd.read_csv("C:\\Users\\DELL\\Desktop\\Data Nexus Hub\\Assignments\\DE_DA_DS_Challenge\\bank_marketing.csv")


# In[4]:


dataframe


# In[5]:


dataframe.count()


# In[6]:


dataframe.info()


# In[7]:


#Dictionary mapping for months to numerical values 
month_dict = {'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'may': 5, 'jun': 6, 'jul': 7, 'aug': 8, 'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12}


# In[8]:


#Converting month names to numerical representation
dataframe['month'] = dataframe['month'].str.lower().map(month_dict)


# In[9]:


dataframe['date']=pd.to_datetime(dataframe[['day', 'month']].assign(year=2022))


# In[10]:


dataframe.head()


# In[11]:


# Extracting year from the combined date column and create a new column tagged 'year'
dataframe['year'] = dataframe['date'].dt.year


# In[12]:


dataframe.head()


# In[13]:


dataframe.head(25)


# In[14]:


dataframe.tail(25)


# In[15]:


#Creating new column for Campaign_ID

#To generate unique IDs for each row
campaign_IDs = range(1, len(dataframe) + 1)

#To generate the column 
dataframe['campaign_id'] = campaign_IDs

#To verify the result 
print(dataframe.head(10))


# In[20]:


dataframe.count()


# In[25]:


# Client table
client_dataframe = dataframe[['client_id', 'age', 'job', 'marital', 'education', 'credit_default', 'housing', 'loan']]
# Campaign table
campaign_dataframe = dataframe[['campaign_id','client_id', 'duration', 'contact','pdays', 'previous', 'poutcome', 'y', 'date']]
# Economics table
economics_dataframe = dataframe[['client_id','emp_var_rate', 'cons_price_idx', 'euribor3m', 'nr_employed']]


# In[26]:


# Save each DataFrame as a separate CSV file
client_dataframe.to_csv('client_data.csv', index=False)
campaign_dataframe.to_csv('campaign_data.csv', index=False)
economics_dataframe.to_csv('economics_data.csv', index=False)

