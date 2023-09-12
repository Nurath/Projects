import streamlit as st
import streamlit.components.v1 as com
from streamlit.components.v1 import html
import yaml
import re
import os
import glob
from pathlib import Path
import pandas as pd 
import pdfminer
import streamlit as st
from pdfminer.high_level import extract_text
import tkinter as tk
from tkinter import filedialog
# Set up tkinter
root = tk.Tk()
root.withdraw()
# Make folder picker dialog appear on top of other windows
root.wm_attributes('-topmost', 1)
# Folder picker button
main_path='C:\\Text Extraction\\'
tab1, tab2, tab3 = st.tabs(["Upload_File","Configure_File","Result"])


#upload file
with tab1:
    l=[]
    t={}
    
    tab4,tab5=st.tabs(['Location','List of Files'])
    with tab4:
        st.write('Please select a folder:')
        clicked = st.button('Folder Picker')
        if clicked:
            st.session_state.clicked=clicked
            dirname = st.text_input('Selected folder:', filedialog.askdirectory(master=root))
            pdf_dir = Path(dirname)
            if os.listdir(pdf_dir) is not None:
                with tab5:
                    for file in pdf_dir.glob('*.pdf'):
                        st.write(str(file).split('\\')[-1])
                        l+=[file]
                    if l is not None:
                        for i in l:
                            j=str(i).split('\\')[-1]
                            t[j]=extract_text(i)
                            j=j.split('.')[0]
                            with open(main_path+'Text\\'+j+'.txt',mode='w',encoding="utf-8") as f:
                                f.write(t[str(i).split('\\')[-1]])
                        st.session_state.t=t

#                             st.download_button(label="Download",data=t[a],file_name=b+'.txt',mime='text')
                        
                        
                            
            
                    
                    
#configur
with tab2:
    def up(j,k):
        key=st.text_input('Enter Field: ',key=j)
        regex=st.text_input('Enter Regex: ',key=k)
        return key,regex
    
    i,j,k=1000,1,0
    tab6,tab7,tab8=st.tabs(["Upload","Add Fields","New Config"])
    file_details1={} 
    with tab6:
        st.write("Upload data in requested format as a **Yml** file -")
        data_file1 = st.file_uploader("Upload file",type=["yml"])

        if data_file1 is not None:
            if data_file1.type == "application/octet-stream":
                file_details1 = {"filename":data_file1.name, "filetype":data_file1.type, "filesize":data_file1.size}
    #             with open(data_file1) as file:
                config= yaml.safe_load(data_file1)
                length=len(config)
                st.write(config)
            with tab7:
                d={}
                while(True):
                    s=st.selectbox('Add Field: ',('Select','Yes','No'),key=i)
                    if s=='Yes':
                        key,regex=up(j,k)
                        if (key is not None) and (regex is not None):
                            config[key]=regex
                        else:
                            st.write('Incorrect Field/Regex')
                    else:
                        if s=='No':
                            with tab8:
                                if len(config)>length:
                                    st.write(config)
                                    with open(main_path+'Config\\'+'config.yml','w') as file:
                                        yaml.dump(config,file)
                                else:
                                    st.write('No Changes')
                        break
                    i+=1
                    j+=1
                    k-=1
                
                     
                            
                    
                
# # result
with tab3:
    def extract(regex,txt):
        match=re.search(r'{}'.format(regex),txt)
        if match is not None:
            match=match.group()
            return match
        else: return(None)
    
    def convert_df(df):
        return df.to_csv(index=False).encode('utf-8')
    
    d={}
    tab9,tab10=st.tabs(['Extraction','Download'])
    with tab9:
        if st.button('Show Results'):
            text=st.session_state.t
            for i,j in text.items():
                d1={}
                if 'File' in d.keys():
                    d['File']+=i
                    d1['File']=i
                else:
                    d['File']=[i]
                    d1['File']=i
                for k,l in config.items():
                    if k in d.keys():
                        d[k]+=[extract(l,j)]
                        d1[k]=[extract(l,j)]
                    else:
                        d[k]=[extract(l,j)]
                        d1[k]=[extract(l,j)]
                df1=pd.DataFrame(d1)
                df1=df1.dropna(axis=1)
                st.dataframe(df1)
                df1.to_csv(main_path+'Result\\'+d1['File'].split('.')[0]+'.csv',index=False,encoding='utf-8')

#             df=pd.DataFrame(d)
            
#             st.write("**Extracted Results-**")
#             st.dataframe(df)
            
#             with tab10:
#                 st.write('**Click to download csv file**')
#                 csv=convert_df(df)
#                 st.download_button(label="Download data as CSV",data=csv,file_name='Result.csv',mime='text/csv')
            
    
        

            
        
    
