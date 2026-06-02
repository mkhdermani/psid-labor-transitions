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
import os
import shutil
from bert_serving.server import BertServer
from bert_serving.server.helper import get_run_args
from bert_serving.client import BertClient
from io import StringIO
import pylev3 as LV
from functools import reduce
from fuzzywuzzy import fuzz
from text2digits import text2digits



def MakeFileStructure(opts,paths):

    # Create Main Folder
    if opts['ReplaceStructure'] is True:
        shutil.rmtree(paths['BaseDir'], ignore_errors=True)
        os.mkdir(paths['BaseDir'])
    else:
        if not os.path.isdir(paths['BaseDir']):
            os.mkdir(paths['BaseDir'])

    # Create Subfolders
    # data
    # --raw
    # --zip
    # --clean
    # projects
    # tmp
    # docs
    # --codebooks
    # --parsedDicts
    # --misc
    # misc

    if opts['ReplaceStructure'] is True:
        if not paths['Data'] is None:
            shutil.rmtree(paths['Data'], ignore_errors=True)
            os.mkdir(paths['Data'])
        else:
            shutil.rmtree(paths['BaseDir'] + '/data/', ignore_errors=True)
            os.mkdir(paths['BaseDir'] + '/data/')
    else:
        if not paths['Data'] is None:
            if not os.path.isdir(paths['Data']):
                os.mkdir(paths['Data'])
        else:
            if not os.path.isdir(paths['BaseDir'] + '/data/'):
                os.mkdir(paths['BaseDir'] + '/data/')

    if opts['ReplaceStructure'] is True:
        if not paths['Data'] is None:
            shutil.rmtree(paths['Data'] + '/zip/', ignore_errors=True)
            os.mkdir(paths['Data'] + '/zip/')
        else:
            shutil.rmtree(paths['BaseDir'] + '/data/zip/', ignore_errors=True)
            os.mkdir(paths['BaseDir'] + '/data/zip/')
    else:
        if not paths['Data'] is None:
            if not os.path.isdir(paths['Data'] + '/zip/'):
                os.mkdir(paths['Data'] + '/zip/')
        else:
            if not os.path.isdir(paths['BaseDir'] + '/data/zip/'):
                os.mkdir(paths['BaseDir'] + '/data/zip/')

    if opts['ReplaceStructure'] is True:
        if not paths['Data'] is None:
            shutil.rmtree(paths['Data'] + '/raw/', ignore_errors=True)
            os.mkdir(paths['Data'] + '/raw/')
        else:
            shutil.rmtree(paths['BaseDir'] + '/data/raw/', ignore_errors=True)
            os.mkdir(paths['BaseDir'] + '/data/raw/')
    else:
        if not paths['Data'] is None:
            if not os.path.isdir(paths['Data'] + '/raw/'):
                os.mkdir(paths['Data'] + '/raw/')
        else:
            if not os.path.isdir(paths['BaseDir'] + '/data/raw/'):
                os.mkdir(paths['BaseDir'] + '/data/raw/')

    if opts['ReplaceStructure'] is True:
        if not paths['Data'] is None:
            shutil.rmtree(paths['Data'] + '/clean/', ignore_errors=True)
            os.mkdir(paths['Data'] + '/clean/')
        else:
            shutil.rmtree(paths['BaseDir'] + '/data/clean/', ignore_errors=True)
            os.mkdir(paths['BaseDir'] + '/data/clean/')
    else:
        if not paths['Data'] is None:
            if not os.path.isdir(paths['Data'] + '/clean/'):
                os.mkdir(paths['Data'] + '/clean/')
        else:
            if not os.path.isdir(paths['BaseDir'] + '/data/clean/'):
                os.mkdir(paths['BaseDir'] + '/data/clean/')
    
    if opts['ReplaceStructure'] is True:
        if not paths['Docs'] is None:
            shutil.rmtree(paths['Docs'], ignore_errors=True)
            os.mkdir(paths['Docs'])
        else:
            shutil.rmtree(paths['BaseDir'] + '/docs/', ignore_errors=True)
            os.mkdir(paths['BaseDir'] + '/docs/')
    else:
        if not paths['Docs'] is None:
            if not os.path.isdir(paths['Docs']):
                os.mkdir(paths['Docs'])
        else:
            if not os.path.isdir(paths['BaseDir'] + '/docs/'):
                os.mkdir(paths['BaseDir'] + '/docs/')

    if opts['ReplaceStructure'] is True:
        if not paths['Docs'] is None:
            shutil.rmtree(paths['Docs'] + '/codebooks/', ignore_errors=True)
            os.mkdir(paths['Docs'] + '/codebooks/')
        else:
            shutil.rmtree(paths['BaseDir'] + '/docs/codebooks/', ignore_errors=True)
            os.mkdir(paths['BaseDir'] + '/docs/codebooks/')
    else:
        if not paths['Docs'] is None:
            if not os.path.isdir(paths['Docs'] + '/codebooks/'):
                os.mkdir(paths['Docs'] + '/codebooks/')
        else:
            if not os.path.isdir(paths['BaseDir'] + '/docs/codebooks/'):
                os.mkdir(paths['BaseDir'] + '/docs/codebooks/')

    if opts['ReplaceStructure'] is True:
        if not paths['Docs'] is None:
            shutil.rmtree(paths['Docs'] + '/parsedDicts/', ignore_errors=True)
            os.mkdir(paths['Docs'] + '/parsedDicts/')
        else:
            shutil.rmtree(paths['BaseDir'] + '/docs/parsedDicts/', ignore_errors=True)
            os.mkdir(paths['BaseDir'] + '/docs/parsedDicts/')
    else:
        if not paths['Docs'] is None:
            if not os.path.isdir(paths['Docs'] + '/parsedDicts/'):
                os.mkdir(paths['Docs'] + '/parsedDicts/')
        else:
            if not os.path.isdir(paths['BaseDir'] + '/docs/parsedDicts/'):
                os.mkdir(paths['BaseDir'] + '/docs/parsedDicts/')
    
    if opts['ReplaceStructure'] is True:
        if not paths['Docs'] is None:
            shutil.rmtree(paths['Docs'] + '/misc/', ignore_errors=True)
            os.mkdir(paths['Docs'] + '/misc/')
        else:
            shutil.rmtree(paths['BaseDir'] + '/docs/misc/', ignore_errors=True)
            os.mkdir(paths['BaseDir'] + '/docs/misc/')
    else:
        if not paths['Docs'] is None:
            if not os.path.isdir(paths['Docs'] + '/misc/'):
                os.mkdir(paths['Docs'] + '/misc/')
        else:
            if not os.path.isdir(paths['BaseDir'] + '/docs/misc/'):
                os.mkdir(paths['BaseDir'] + '/docs/misc/')
   

    if opts['ReplaceStructure'] is True:
        if not paths['Temp'] is None:
            shutil.rmtree(paths['Temp'], ignore_errors=True)
            os.mkdir(paths['Temp'])
        else:
            shutil.rmtree(paths['BaseDir'] + '/tmp/', ignore_errors=True)
            os.mkdir(paths['BaseDir'] + '/tmp/')
    else:
        if not paths['Temp'] is None:
            if not os.path.isdir(paths['Temp']):
                os.mkdir(paths['Temp'])
        else:
            if not os.path.isdir(paths['BaseDir'] + '/tmp/'):
                os.mkdir(paths['BaseDir'] + '/tmp/')

    if opts['ReplaceStructure'] is True:
        if not paths['Project'] is None:
            shutil.rmtree(paths['Project'], ignore_errors=True)
            os.mkdir(paths['Project'])
        else:
            shutil.rmtree(paths['BaseDir'] + '/projects/', ignore_errors=True)
            os.mkdir(paths['BaseDir'] + '/projects/')
    else:
        if not paths['Project'] is None:
            if not os.path.isdir(paths['Project']):
                os.mkdir(paths['Project'])
        else:
            if not os.path.isdir(paths['BaseDir'] + '/projects/'):
                os.mkdir(paths['BaseDir'] + '/projects/')

    if opts['ReplaceStructure'] is True:
        if not paths['Project'] is None:
            shutil.rmtree(paths['Project'] + opts['ProjectName'], ignore_errors=True)
            os.mkdir(paths['Project'] + opts['ProjectName'])
        else:
            shutil.rmtree(paths['BaseDir'] + '/projects/' + opts['ProjectName'], ignore_errors=True)
            os.mkdir(paths['BaseDir'] + '/projects/' + opts['ProjectName'])
    else:
        if not paths['Project'] is None:
            if not os.path.isdir(paths['Project']):
                os.mkdir(paths['Project'] + opts['ProjectName'])
        else:
            if not os.path.isdir(paths['BaseDir'] + '/projects/' + opts['ProjectName']):
                os.mkdir(paths['BaseDir'] + '/projects/' + opts['ProjectName'])

    if opts['ReplaceStructure'] is True:
        if not paths['Misc'] is None:
            shutil.rmtree(paths['Misc'], ignore_errors=True)
            os.mkdir(paths['Misc'])
        else:
            shutil.rmtree(paths['BaseDir'] + '/misc/', ignore_errors=True)
            os.mkdir(paths['BaseDir'] + '/misc/')
    else:
        if not paths['Misc'] is None:
            if not os.path.isdir(paths['Misc']):
                os.mkdir(paths['Misc'])
        else:
            if not os.path.isdir(paths['BaseDir'] + '/misc/'):
                os.mkdir(paths['BaseDir'] + '/misc/')

def merge_two_dicts(x, y):
    z = x.copy()
    z.update(y)
    return z

# Print iterations progress
def printProgressBar (iteration, total, prefix = '', suffix = '', decimals = 1, length = 100, fill = '█'):
    """
    Call in a loop to create terminal progress bar
    @params:
        iteration   - Required  : current iteration (Int)
        total       - Required  : total iterations (Int)
        prefix      - Optional  : prefix string (Str)
        suffix      - Optional  : suffix string (Str)
        decimals    - Optional  : positive number of decimals in percent complete (Int)
        length      - Optional  : character length of bar (Int)
        fill        - Optional  : bar fill character (Str)
    """
    percent = ("{0:." + str(decimals) + "f}").format(100 * (iteration / float(total)))
    filledLength = int(length * iteration // total)
    bar = fill * filledLength + '-' * (length - filledLength)
    print('\r%s |%s| %s%% %s' % (prefix, bar, percent, suffix), end = '\r')
    # Print New Line on Complete
    if iteration == total: 
        print()

# import time

# # A List of Items
# items = list(range(0, 57))
# l = len(items)

# # Initial call to print 0% progress
# printProgressBar(0, l, prefix = 'Progress:', suffix = 'Complete', length = 50)
# for i, item in enumerate(items):
#     # Do stuff...
#     time.sleep(0.1)
#     # Update Progress Bar
#     printProgressBar(i + 1, l, prefix = 'Progress:', suffix = 'Complete', length = 50)

def convertFloatstoInts(checkString):
    try:
        newFloat = float(checkString)
        InttoReturn = math.ceil(newFloat)
    except:
        InttoReturn = checkString
    return InttoReturn



def SimilarityCheck(code1, code2, threshval):
    replaceDict = {'don\'t know':'dk',
                   'didn\'t':'did not',
                   'father or mother':'parent',
                   'brother or sister':'sibling'}
    threshCheck = False
    templen = 0
    if (len(code1.split(";"))>1) or (len(code2.split(";"))>1):
        while (threshCheck == False) and (templen < len(code1.split(";"))):
            for clausePrev in code1.lower().split(";"):
                for repcode in replaceDict.keys(): clausePrev = clausePrev.replace(repcode,replaceDict[repcode])
                for clauseNew in code2.lower().split(";"):
                    for repcode in replaceDict.keys(): clauseNew = clauseNew.replace(repcode,replaceDict[repcode])
                    # thresh1 = fuzz.partial_ratio(clausePrev,clauseNew)
                    thresh1 = fuzz.token_sort_ratio(clausePrev,clauseNew)
                    thresh2 = fuzz.token_set_ratio(clausePrev,clauseNew)
                    threshReturn = max(thresh1,thresh2)
                    if threshReturn > threshval:
                        threshCheck = True
                        pass
                templen = templen + 1
    else:
        clausePrev = code1.lower()
        clauseNew = code2.lower()
        for repcode in replaceDict.keys(): clausePrev = clausePrev.replace(repcode,replaceDict[repcode])
        for repcode in replaceDict.keys(): clauseNew = clauseNew.replace(repcode,replaceDict[repcode])
        # thresh1 = fuzz.partial_ratio(clausePrev,clauseNew)
        thresh1 = fuzz.token_sort_ratio(clausePrev,clauseNew)
        thresh2 = fuzz.token_set_ratio(clausePrev,clauseNew)
        threshReturn = max(thresh1,thresh2)
        if threshReturn > threshval:
            threshCheck = True
            pass

    return threshCheck, threshReturn

def UpdateSynonyms(code):
    replaceDict = {'Negro':'Black',
                   'African-American':'Black',
                   'American Indian':'Native American',
                   'Oriental':'Asian',
                   'Aleut':'Alaska Native',
                   'Eskimo':'Alaska Native'}

    for repcode in replaceDict.keys(): code = code.replace(repcode,replaceDict[repcode])
    # tempcode = list(set(re.split('; |, ',code)))
    # if all(self.SimilarityCheck(tempcode[0],othercodes,99) for othercodes in tempcode[1::]):
    #     returnCode = tempcode[0]
    # else:
    #     returnCode = code

    returnCode = code

    return returnCode

def SimilarityCheckBERT(yhat, xhat, threshval):
    threshCheck = False

    matchVec = np.dot(xhat, yhat.T) / np.sum(xhat * xhat, axis = 1)

    threshReturn = list()
    threshInd = list()
    threshCheck = list()

    if len(xhat) > 1:
        for i in range(0,len(xhat)):
            foundVal = False
            while foundVal == False:
                for ind in np.argpartition(matchVec[i,:],len(matchVec[i,:])-1)[::-1]:
                    if (matchVec[i,ind] == np.max(matchVec[:,ind])) and (matchVec[i,ind] >= np.max(matchVec[ind,:])):
                        threshReturn.append(matchVec[i,ind])
                        threshInd.append(ind)
                        foundVal = True
                if foundVal == False:
                    threshReturn.append(matchVec[i,i])
                    threshInd.append(i)
                    foundVal = True

            if threshReturn[i] >= (threshval/100):
                threshCheck.append(True)
            else:
                threshCheck.append(False)
    else:
        threshReturn.append(np.max(matchVec))
        threshInd.append(np.argmax(matchVec))
        if threshReturn[0] >= (threshval/100):
            threshCheck.append(True)
        else:
            threshCheck.append(False)


    return threshCheck, threshReturn, threshInd


# import sys

# from bert_serving.server import BertServer
# from bert_serving.server.helper import get_run_args


# if __name__ == '__main__':
#     args = get_run_args()
#     server = BertServer(args)
#     server.start()
#     server.join()
