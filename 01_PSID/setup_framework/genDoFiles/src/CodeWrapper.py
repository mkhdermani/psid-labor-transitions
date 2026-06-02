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
import getpass
from HelperFunctions import MakeFileStructure
from DownloadFunctions import DownloadData
from CodeWriterFunctions import CodeWriter
sys.setrecursionlimit(10000)

class CodeWrapper:
    def __init__(self, opts, paths):
        self.opts = opts
        self.paths = paths
        if not 'Username' in list(self.opts.keys()):
            self.opts['Username'] = None
        if not 'Password' in list(self.opts.keys()):
            self.opts['Password'] = None
        if opts['Years'] == None:
            self.YearsDict = None
            self.DownloadYears = None
            self.YearsDict = None
        else:
            if isinstance(opts['Years'], list):
                self.YearsDict = [str(x) for x in opts['Years']]
                self.DownloadYears = [str(x) for x in self.YearsDict]
            else:
                self.YearsDict = [opts['Years']]
                self.DownloadYears = [opts['Years']]



    def structureWrapper(self): # Create the structure of the programs and data directory
        MakeFileStructure(self.opts,self.paths)

    def downloadWrapper(self): # Download the dataset
        if (self.opts['Username'] is not None) and (self.opts['Password'] is not None):
            DataDownloader = DownloadData(self.opts,self.paths)
            DataDownloader.DownloadData()
            DataDownloader.UnzipData()
            DataDownloader.DownloadCodebooks()
        else:
            if self.opts['Dataset'] == 'PSID':
                user = input('What is your username for the PSID website?')
                passwd = getpass.getpass('What is your password for the PSID website?')
                self.opts['username'] = user
                self.opts['password'] = passwd
                DataDownloader = DownloadData(self.opts,self.paths)
                DataDownloader.DownloadData()
                DataDownloader.UnzipData()
                DataDownloader.DownloadCodebooks()
            else:
                DataDownloader = DownloadData(self.opts,self.paths)
                DataDownloader.DownloadData()
                DataDownloader.UnzipData()
                DataDownloader.DownloadCodebooks()

###### This is being implemented in other code. Eventually, parse codebooks to standardize codes over time

    # def codebookDownloadWrapper(self): # Download codebooks
    #     DataDownloader = DownloadData(self.opts,self.paths)
    #     # DataDownloader.CreateXMLLists()
    #     DataDownloader.LoginDownloadXMLCodebooks()


    # def codebookWrapper(self):
    #     CodebookParser = ParseCodebooks(self.opts,self.paths)
    #     # CodebookParser.CodebooksToTxtDocs()
    #     CodebookParser.CreateEmptyDicts()
    #     CodebookParser.CreateCrossSectionCodebooks()
    #     CodebookParser.CreatePanelCodebooks()

    # def crosswalkWrapper(self):
    #     CodebookParser = ParseCodebooks(self.opts,self.paths)
    #     CodebookParser.CrossSectionDefinitions()
    #     CodebookParser.PanelCrosswalkDefinitions()


    # def crosswalkWrapper(self):
    #     CrosswalkCreator = DataCrosswalk(self.opts,self.paths)
    #     CrosswalkCreator.StandardizeCodes()

    # def dictionaryWrapper(self):
    #     DictionaryCreator = DataDictionary(self.opts,self.paths)
    #     if self.opts['CrossSectionData'] == True:
    #         DictionaryCreator.CreateCrossSectionDictionary()
    #     if self.opts['PanelData'] == True:
    #         DictionaryCreator.CreatePanelDictionary()

    # def dictionaryWrapper(self):
    #     DictionaryCreator = DataDictionary(self.opts,self.paths)
    #     DictionaryCreator.CreatePanelDictionary()


    def programsWrapper(self):
        WriteOutCode = CodeWriter(self.opts,self.paths)
        WriteOutCode.CreateSubsetData()
        WriteOutCode.WriteDictionaryFiles()
        WriteOutCode.WriteReshapeRenameCode()
        WriteOutCode.WriteLabelCode()

    def mainWrapper(self):
        if self.opts['FromScratch'] == True:
            if self.opts['CreateFolder'] == True:
                self.structureWrapper()
            if self.opts['DownloadData'] == True:
                self.downloadWrapper()
            # if self.opts['XMLCodebooks'] == True:
            #     self.codebookDownloadWrapper()
            # if self.opts['ParseCodebooks'] == True:
            #     print("It claims to be working")
            #     self.codebookWrapper()
            # if self.opts['CreateCodebooks'] == True:
            #     self.codebookWrapper()
            # if self.opts['CreateCrosswalk'] == True:
            #     self.crosswalkWrapper()
            # if self.opts['CreateDataDictionary'] == True:
            #     self.dictionaryWrapper()
            if self.opts['WritePrograms'] == True:
                self.programsWrapper()
            # if self.opts['CreateDataset'] == True:
            #     self.datasetWrapper()
        else:
            if self.opts['WritePrograms'] == True:
                self.programsWrapper()
            # if self.opts['CreateDataset'] == True:
            #     self.datasetWrapper()


# Program Structure:
## Create Data Structure:
### base data
## Download data:
### Raw Data
### Codebooks
## Create Codebooks:
### Parse and turn into readable format

# Project specific structure:
