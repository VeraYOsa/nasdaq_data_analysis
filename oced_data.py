

#%% OCED data
#influenzia: 


quandl.ApiConfig.api_key = "sqWWxGfThfzLsmyptXgy"
ESP =  pd.DataFrame()
input_files = ('OECD/HEALTH_STAT_CICDINPN_NBMALEPH_ESP', 
               'OECD/HEALTH_REAC_HOPIREHA_NOMBRENB_ESP', 'OECD/HEALTH_REAC_HOSPPUHO_NOMBRENB_ESP', 
               'OECD/HEALTH_REAC_HEDUNUGR_NOMBRENB_ESP','OECD/HEALTH_REAC_HOSPTHOS_NOMBRENB_ESP',
               'OECD/HEALTH_REAC_HOSPTHOS_NBMILPNB_ESP', 'OECD/HEALTH_REAC_HOPITBED_NOMBRENB_ESP',
               'OECD/HEALTH_REAC_HOPITBED_RTOINPNB_ESP','OECD/HEALTH_REAC_HOPITBED_HOPRAT_ESP',
               'OECD/HEALTH_REAC_HOEMHEMP_PERSMYNB_ESP', 'OECD/HEALTH_REAC_HOPITBED_NURRAT_ESP',
               'OECD/HEALTH_REAC_RVNURINF_YSALGDMT_ESP')
li = []

for i in input_files:
    ESP = quandl.get(i, end_date='2021-12-31').reset_index(level=['Date'])
    ESP['variable'] = i
    li.append(ESP)

esp = pd.concat(li, axis=0, ignore_index=True).dropna()
esp = esp.pivot_table(index=['Date'], columns='variable', values='Value', aggfunc='first').reset_index()


esp = esp.rename(columns = lambda x : str(x)[8:])  # remove the ".csv" from the column name
esp.columns = esp.columns.str.replace('_', '')
esp = esp.rename(columns={'':'Date'})
# saving the csv
esp.to_csv(output_folder + 'oecd.csv')
