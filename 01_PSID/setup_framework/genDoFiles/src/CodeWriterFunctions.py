################################################################################################################
#Author: Ben Griffy
#Institution: University at Albany, SUNY
#email: bgriffy@albany.edu
#website: https://www.bengriffy.com
#Date:
################################################################################################################



import numpy as np
import pandas as pd
import re
import os
from functools import reduce

class CodeWriter:
    def __init__(self, opts, paths):
        self.opts = opts
        self.paths = paths
        self.FileTypes = ['zip','txt']
        self.ExtraMainFiles = None
        if opts['Years'] == None:
            self.YearsDict = None
            self.DownloadYears = None
            self.YearsDict = None
        else:
            self.YearsDict = [str(x) for x in opts['Years']]
            self.DownloadYears = [str(x) for x in self.YearsDict]
        if opts['Dataset'] == "PSID":
            self.ExtraMainFiles = ('Cross-year Individual: 1968-2017','Marriage History: 1985-2017','Childbirth & Adoption History: 1985-2017', 'Parent Identification: 2017', 'Pregnancy Intentions: 2013-2017', 'Active Savings: 1989, 1994')
            self.FileStubs = ['fam','ind']
            self.Data = pd.read_excel(self.paths['Docs']+'/misc'+'/psid.xlsx')
            if opts['SubsetVariables'] == True:
                self.DataVars = pd.read_excel(self.paths['SubsetFile'])
            elif opts['ManualVariables'] == True:
                self.DataVars = pd.read_excel(self.paths['SubsetFile'])
            else:
                self.DataVars = self.data
            if "Ind" in self.opts['AdditionalOpts']['DataVars']:
                self.DataIndVars = pd.read_excel(self.paths['IndSubsetFile'])
            else:
                self.DataIndVars = pd.read_excel(self.paths['Docs']+'/misc'+'/IndDefaultSubset.xlsx')
            # self.DataVars = pd.read_excel(self.paths['Misc']+'/psid.xlsx')
            # self.DataSubset = DataPanel
            self.Data['VarNameDefault'] = ''
            self.DataTypes = self.Data.TYPE.unique()
            self.DataCategories = self.Data.CATEGORY.unique()
            self.DataAddVars = pd.DataFrame(columns=['TYPE','CATEGORY','TEXT','HEAD_WIFE','VarName'])
            self.ProgramFileOutputDir = self.paths['SharedCode'] + '/data_prep/'
            # self.DataIndVars = DataIndVars
            self.VariableCrosswalk = self.paths['Docs'] + '/misc/psid.xlsx'
            if opts['Years'] == None:
                self.YearsDict = [str(x) for x in list(range(1968,1996))+[1996]+list(range(1997,2017,2))+[2017]]
                self.DownloadYears = [str(x) for x in self.YearsDict]
                self.YearsDict = dict(zip(self.DownloadYears,self.YearsDict))
            else:
                self.YearsDict = [str(x) for x in opts['Years']]
                self.DownloadYears = [str(x) for x in self.YearsDict]
                self.YearsDict = dict(zip(self.DownloadYears,self.YearsDict))


    def CreateSubsetData(self):
        for vartype in self.DataTypes:
            for i in range(0,len(self.DataCategories)):
                category = self.DataCategories[i]
                tempcatlist = list(self.Data.TEXT[(self.Data.CATEGORY==category)&(self.Data.TYPE==vartype)])
                # tempvarnames = list()
                if len(tempcatlist)>0:
                    if len(category.split()) == 1:
                        tempvarnames = [list(vartype)[0]+''.join(str(category[0:3]) + str(x).zfill(3)) for x in range(1,len(tempcatlist)+1)]
                    else:
                        cat1 = category.split()[0]
                        cat2 = category.split()[1]
                        tempvarnames = [list(vartype)[0]+''.join(str(cat1[0:3]) + str(cat2[0:2]) + str(x).zfill(3)) for x in range(1,len(tempcatlist)+1)]
                    self.Data.VarNameDefault[(self.Data.CATEGORY==category)&(self.Data.TYPE==vartype)] = tempvarnames
        # return self.Data

    def GenFamListPremade(self):
        self.DataSubset = reduce(lambda left,right: pd.merge(left,right,on=['TYPE','CATEGORY','TEXT','HEAD_WIFE']), [self.DataVars,self.Data])
        self.DataSubset = self.DataSubset.fillna('')
        self.DataSubset.VarName[self.DataSubset.VarName==''] = self.DataSubset.VarNameDefault[self.DataSubset.VarName=='']
        if not 'VarLabel' in self.DataSubset.columns:
            self.DataSubset['VarLabel'] = ''
        if not 'VarRename' in self.DataSubset.columns:
            self.DataSubset['VarRename'] = ''
        docatfiles = open(self.ProgramFileOutputDir+'/PSID_Variable_Selection_Family.do', 'w')
        labelsfile = open(self.ProgramFileOutputDir+'/LabelFamVars.do', 'w')
        renamefile = open(self.ProgramFileOutputDir+'/RenameFamVars.do', 'w')
        reshapefile = open(self.ProgramFileOutputDir+'/ReshapeFamData.do','w')
        for i in range(0,len(self.DataCategories)):
            category = self.DataCategories[i]
            catrows = self.DataSubset[self.DataSubset.CATEGORY==category]
            file = open(self.ProgramFileOutputDir+str(category).replace(' ','') + '.do','w')
            docatfiles.write('do ' + str(category).replace(' ',''))
            docatfiles.write('\n')
            if len(catrows) > 0:
                reshapefile.write(' ///' + '\n')
            for j, row in catrows.iterrows():
                file.write('\n')
                file.write('**'+ str(row.TEXT).replace('\n',' ') + '\n')
                file.write('{' + "\n")
                tempvars = row['Y' + str(self.DownloadYears[0]):'Y'+str(self.DownloadYears[-1])]
                for k in range(int(self.DownloadYears[0])-1968,len(tempvars)):
                    if not (row.VarRename is ''):
                        file.write('\t\t' + 'capture : rename ' + str(tempvars[k]) + ' ' + row.VarRename + '_$t' +'\n')
                    else:
                        file.write('\t\t' + 'capture : rename ' + str(tempvars[k]) + ' ' + row.VarName + '_$t' +'\n')
                file.write('}' + "\n")
                if not (row.VarLabel is ''):
                    if not (row.VarRename is ''):
                        labelsfile.write("\t" + "label variable " + row.VarRename + " " + row.VarLabel + "\n" )
                    else:
                        labelsfile.write("\t" + "label variable " + row.VarName + " " + row.VarLabel + "\n" )
                else:
                    if not (row.VarRename is ''):
                        labelsfile.write("\t" + "label variable " + row.VarRename + " " + "\"" +str(row.TEXT).replace('\n',' ')+"\"" + "\n" )
                    else:
                        labelsfile.write("\t" + "label variable " + row.VarName + " " + "\"" +str(row.TEXT).replace('\n',' ')+"\"" + "\n" )
                if not (row.VarRename is ''):
                    reshapefile.write(row.VarRename + "_ ")
                else:
                    reshapefile.write(row.VarName + "_ ")
                if not (row.VarRename is ''):
                    renamefile.write("ren " + row.VarRename + "_ " +row.VarRename + "\n")
                else:
                    renamefile.write("ren " + row.VarName + "_ " +row.VarName + "\n")
            file.close()
        docatfiles.close()
        labelsfile.close()
        reshapefile.close()
        renamefile.close()

    def GenIndListPremade(self):
        self.DataIndSubset = reduce(lambda left,right: pd.merge(left,right,on=['TYPE','CATEGORY','TEXT']), [self.DataIndVars,self.Data])
        self.DataIndSubset = self.DataIndSubset.fillna('')
        self.DataIndSubset.VarName[self.DataIndSubset.VarName==''] = self.DataIndSubset.VarNameDefault[self.DataIndSubset.VarName=='']
        if not 'VarLabel' in self.DataIndSubset.columns:
            self.DataIndSubset['VarLabel'] = ''
        if not 'VarRename' in self.DataIndSubset.columns:
            self.DataIndSubset['VarRename'] = ''
        docatfiles = open(self.ProgramFileOutputDir+'/PSID_Variable_Selection_Individual.do', 'w')
        labelsfile = open(self.ProgramFileOutputDir+'/LabelIndVars.do', 'w')
        renamefile = open(self.ProgramFileOutputDir+'/RenameIndVars.do', 'w')
        reshapefile = open(self.ProgramFileOutputDir+'/ReshapeIndData.do','w')
        for i in range(0,len(self.DataCategories)):
            category = self.DataCategories[i]
            catrows = self.DataIndSubset[self.DataIndSubset.CATEGORY==category]
            file = open(self.ProgramFileOutputDir+str(category).replace(' ','') + 'Ind' + '.do','w')
            docatfiles.write('do ' + str(category).replace(' ','') + 'Ind')
            docatfiles.write('\n')
            if len(catrows) > 0:
                reshapefile.write(' ///' + '\n')
            for j, row in catrows.iterrows():
                file.write('\n')
                file.write('**'+ str(row.TEXT).replace('\n',' ') + '\n')
                file.write('{' + "\n")
                tempvars = row['Y' + str(self.DownloadYears[0]):'Y'+str(self.DownloadYears[-1])]
                for k in range(int(self.DownloadYears[0])-1968,len(tempvars)):
                    if not (row.VarRename is ''):
                        file.write('\t\t' + 'capture : rename ' + str(tempvars[k]) + ' ' + row.VarRename + "_" + str(self.DownloadYears[k]) +'\n')
                    else:
                        file.write('\t\t' + 'capture : rename ' + str(tempvars[k]) + ' ' + row.VarName + "_" + str(self.DownloadYears[k]) +'\n')
                file.write('}' + "\n")
                if not (row.VarLabel is ''):
                    if not (row.VarRename is ''):
                        labelsfile.write("\t" + "label variable " + row.VarRename + " " + row.VarLabel + "\n" )
                    else:
                        labelsfile.write("\t" + "label variable " + row.VarName + " " + row.VarLabel + "\n" )
                else:
                    if not (row.VarRename is ''):
                        labelsfile.write("\t" + "label variable " + row.VarRename + " " + "\"" +str(row.TEXT).replace('\n',' ')+"\"" + "\n" )
                    else:
                        labelsfile.write("\t" + "label variable " + row.VarName + " " + "\"" +str(row.TEXT).replace('\n',' ')+"\"" + "\n" )
                if not (row.VarRename is ''):
                    reshapefile.write(row.VarRename + "_ ")
                else:
                    reshapefile.write(row.VarName + "_ ")
                if not (row.VarRename is ''):
                    renamefile.write("ren " + row.VarRename + "_ " +row.VarRename + "\n")
                else:
                    renamefile.write("ren " + row.VarName + "_ " +row.VarName + "\n")
            file.close()
        docatfiles.close()
        labelsfile.close()
        reshapefile.close()
        renamefile.close()

    def WriteReshapeRenameCode(self):
        reshaperenamefile = open(self.ProgramFileOutputDir+'/ReshapeRenameData.do','w')
        reshaperenamefile.write('clear all\npause on\nset more off\n\n*Set My Path\ncd\"$projdir\"\n\nuse FAMILY_INDIVIDUAL, clear\n\n*drop if ID_1968>5000 & ID_1968<7000\ndrop if ID_1968>7000 & ID_1968<9308\n\ncd \"$progdir/data_prep\"\n')
        reshaperenamefile.write('reshape long ')


        reshapefile = open(self.ProgramFileOutputDir+'/ReshapeFamData.do','r')
        reshaperenamefile.write(reshapefile.read())
        reshapefile.close()
        reshaperenamefile.write(' ')
        reshapefile = open(self.ProgramFileOutputDir+'/ReshapeIndData.do','r')
        reshaperenamefile.write(reshapefile.read())
        reshapefile.close()
        reshaperenamefile.write(', i(IndID) j(year)')
        reshaperenamefile.write('\n')
        renamefile = open(self.ProgramFileOutputDir+'/RenameFamVars.do','r')
        reshaperenamefile.write(renamefile.read())
        renamefile.close()
        reshaperenamefile.write('\n')
        renamefile = open(self.ProgramFileOutputDir+'/RenameIndVars.do','r')
        reshaperenamefile.write(renamefile.read())
        renamefile.close()
        reshaperenamefile.close()


    def WriteLabelCode(self):
        labelsavefile = open(self.ProgramFileOutputDir+'/LabelSaveData.do','w')

        labelsfile = open(self.ProgramFileOutputDir+'/LabelFamVars.do', 'r')
        labelsavefile.write(labelsfile.read())
        labelsfile.close()
        labelsavefile.write('\n')
        labelsfile = open(self.ProgramFileOutputDir+'/LabelIndVars.do', 'r')
        labelsavefile.write(labelsfile.read())
        labelsfile.close()
        labelsavefile.write('\n')
        labelsavefile.write('cd \"$projdir\"\n')
        labelsavefile.write('save PanelReshaped, replace')
        labelsavefile.close()

    def WriteDictionaryFiles(self):
        self.GenFamListPremade()
        self.GenIndListPremade()

    def GenVarList(self):
        DataVars = self.DataVars.append(self.DataAddVars,ignore_index=True)
        dataframe = reduce(lambda left,right: pd.merge(left,right,on=['TYPE','CATEGORY','TEXT','HEAD_WIFE','VAR_COUNT']), [self.DataVars,self.Data])
        return dataframe

    def AddByCategory(self):
        catdict = {}
        finished = 0
        while (finished == 0):
            for i in range(0,len(self.DataCategories)):
                catdict[i] = self.DataCategories[i]
                print(str(i) + ": " + self.DataCategories[i] + "\n")
            category = input('Enter a category: ')
            pd.options.display.max_colwidth = 200
            try:
                int(category)
                category = catdict.get(int(category))
            except:
                pass
            temptypedict = {}
            tempcategorydict = {}
            temptextdict = {}
            tempheadwifedict = {}
            tempvarcountdict = {}
            print('You selected ' + category)
            tempcatlist = list(self.Data.TEXT[self.Data.CATEGORY==category])
            for j in range(0,len(tempcatlist)):
                temptypedict[j] = list(self.Data.TYPE[self.Data.CATEGORY==category])[j]
                tempcategorydict[j] = list(self.Data.CATEGORY[self.Data.CATEGORY==category])[j]
                temptextdict[j] = list(self.Data.TEXT[self.Data.CATEGORY==category])[j]
                tempheadwifedict[j] = list(self.Data.HEAD_WIFE[self.Data.CATEGORY==category])[j]
                tempvarcountdict[j] = list(self.Data.VAR_COUNT[self.Data.CATEGORY==category])[j]
                print(str(j) + ": " + list(self.Data.TEXT[self.Data.CATEGORY==category])[j] + "\n")
            tempvarlist = input('Enter a list of variables (numbers) that you would like: ')
            for k in range(0,len(tempvarlist)-1):
                # print temptypedict.get(int(k))
                # strk = str(k)
                tempdf = pd.DataFrame(data=[[temptypedict.get(int(k)),tempcategorydict.get(int(k)),temptextdict.get(int(k)),tempheadwifedict.get(int(k)),tempvarcountdict.get(int(k)),''.join(str(category[0:3])+str(k+1).zfill(3))]],columns=['TYPE','CATEGORY','TEXT','HEAD_WIFE','VAR_COUNT','VarName'])
                self.DataAddVars = self.DataAddVars.append(tempdf,ignore_index=True)
            finished_yn = input('Are you done adding variables (y/n)? ')
            if finished_yn == 'y':
                finished = 1
        # print self.DataAddVars

    # def GenStataDoFile(self,datafile)


