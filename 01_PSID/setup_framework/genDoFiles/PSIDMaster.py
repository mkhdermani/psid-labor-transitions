# coding: utf-8

################################################################################################################
#Author: Ben Griffy
#Institution: University at Albany, SUNY
#email: bengriffy@gmail.com
#website: https://www.bengriffy.com
#Date:
################################################################################################################

import numpy as np
import pandas as pd
import sys
sys.setrecursionlimit(10000)

opts = {'Dataset':"PSID", # Eventually choose from list: "PSID"; "SIPP"; "NLSY79"; "NLSY97"; "CPS"; "SSA"; "IRS"; "SCF". Now just PSID
        'genCodeSubdir':'/setup/genDoFiles/',
        'outputCodeSubdir':'/data/',
        'StorageDir':'/media/ben/workB/',
        'SharedDir':'/media/ben/workB/',
        'ProjectName':"BaselinePSIDProject",
        'FromScratch':False, # Start entirely from scratch or start with pre-made dataset and then subset.
        'PremadeDataset':"Panel", # When starting from one of the pre-made datasets, select which subset to start from.
        'CreateFolder':False, # Create the folder to download the PSID
        'DownloadData':False, # Download all available data? If you have already done this for the corresponding dataset, don't do this.
        'SubsetVariables':True, # Use a subset of the entire PSID dataset. You should do this. It will require that you choose variables from the psid.xlsx file.
        'WritePrograms':True, # Generate programs to create and work with your PSID selection.
        'ProgramLanguage':"Stata", # Write do-files if Stata is selected. I'd like to have the same for Python, but haven't written it yet.
        'ReplaceData':False, # Replace current raw data files. If DownloadData == True and ReplaceData == False, this updates the dataset with the newest data.
        'ReplaceStructure':False, # Replace current raw data files. If DownloadData == True and ReplaceData == False, this updates the dataset with the newest data.
        'Username':None, # Username for the ISPCR (PSID) website
        'Password':None, # Password for the ISPCR (PSID) website. Note, this might transmit in plain text, so don't use a password you would use anywhere else.
        'ReplaceCodes':False, # Replace previously coded variables
        'Years':None, # The additional options depend on the dataset that you are using
        'AdditionalOpts':{'Years':[str(x) for x in list(range(1968,1996))+[1996]+list(range(1997,2017,2))+[2017]],
        'DataVars':["Fam"]} # The additional options depend on the dataset that you are using
}


paths = {'MainDir':opts['StorageDir'],
         'BaseDir':opts['StorageDir'] + '/data/' + opts['Dataset'] + '/'  + opts['ProjectName'], # Base path of the PSID
         'Data':opts['StorageDir'] + '/data/' + opts['Dataset'] + '/'  + opts['ProjectName'] + '/data/', # Base path of the raw SIPP data
         'Temp':opts['StorageDir'] + '/data/' + opts['Dataset'] + '/'  + opts['ProjectName'] + '/tmp/', # Base path of the raw SIPP data
         'Project':opts['StorageDir'] + '/data/' + opts['Dataset'] + '/' + opts['ProjectName']  +'/projects/', # Base path of the output (code and data)
         'Code':opts['StorageDir'] + '/data/' + opts['Dataset'] + '/' + opts['ProjectName'] + '/programs/' + opts['genCodeSubdir'], # Location of the file where I have defined variables that I want to keep from the SIPP
         'SharedCode':opts['SharedDir'] + '/data/' + opts['Dataset'] + '/' + opts['ProjectName'] + '/programs/' + opts['outputCodeSubdir'], # Location of the file where I have defined variables that I want to keep from the SIPP
         'Docs':opts['StorageDir'] + '/data/' + opts['Dataset'] + '/' + opts['ProjectName'] + '/data/docs/',
         'SubsetFile':opts['StorageDir'] + '/data/' + opts['Dataset'] + '/' + opts['ProjectName'] + '/data/docs/misc/' + '/Family_Variable_Selection.xlsx', # Location of the file where I have defined variables that I want to keep from the SIPP
         'AdditionalPaths':{'SubsetFile':opts['SharedDir'] + '/programs/data/' + opts['Dataset'] + '/' + '/Family_Variable_Selection.xlsx'}
}

sys.path.append(paths['Code']+'/src')

from CodeWrapper import CodeWrapper

mainDataset = CodeWrapper(opts,paths)
mainDataset.mainWrapper()


# if __name__ == '__main__':
#     mainDataset = CodeWrapper(opts,paths)
#     mainDataset.mainWrapper()
