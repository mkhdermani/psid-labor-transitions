################################################################################################################
#Author: Ben Griffy
#Institution: University at Albany, SUNY
#email: griffy@umail.ucsb.edu
#website: https://www.bengriffy.com
#Date:
################################################################################################################

import numpy as np
import pandas as pd
import urllib.request, urllib.parse, urllib.error
import http.cookiejar as cl
import re
import os
import ftplib
import time
import wget
import mechanicalsoup
import requests as rq
import subprocess
import pdftotext
from numpy.random import randint
from bs4 import BeautifulSoup
import shutil
import zipfile

# https://simba.isr.umich.edu/cb.aspx?vNodeID=2-04-1235

class DownloadData:
    def __init__(self, opts, paths):
        self.opts = opts
        self.paths = paths
        self.CensusBaseAddr = 'https://thedataweb.rm.census.gov/ftp/'
        self.CensusFTPAddr = 'ftp2.census.gov'
        self.NBERBaseAddr = 'https://www.nber.org/data/'
        self.FedBoardBaseAddr = 'https://www.federalreserve.gov/econres'
        self.FileTypes = ['zip','txt']
        self.ExtraMainFiles = None
        self.BaseCodebookFTPAddr = None
        self.SrcFTPAddr = None
        self.CodebookFTPAddr = None
        self.DataFTPAddr = None
        self.BaseFTPAddr = None
        self.LoginAddr = None
        self.DataAddr = None
        self.VarListAddr = None
        self.CreateCodebookAddr = None
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
            self.LoginAddr = 'https://simba.isr.umich.edu/U/Login.aspx'
            self.DataAddr = 'https://simba.isr.umich.edu/Zips/ZipMain.aspx'
            self.VarListAddr = 'https://simba.isr.umich.edu/VS/l.aspx'
            self.CreateCodebookAddr = 'https://simba.isr.umich.edu/cart/default.aspx'
            self.VariableCrosswalk = self.paths['Docs'] + '/misc/psid.xlsx'
            self.CodebookAddr = 'https://simba.isr.umich.edu/VS/i.aspx'
            if opts['Years'] == None:
                self.YearsDict = [str(x) for x in list(range(1968,1996))+[1996]+list(range(1997,2017,2))+[2017]]
                self.DownloadYears = [str(x) for x in self.YearsDict]
                self.YearsDict = dict(zip(self.DownloadYears,self.YearsDict))
            else:
                self.YearsDict = [str(x) for x in opts['Years']]
                self.DownloadYears = [str(x) for x in self.YearsDict]
                self.YearsDict = dict(zip(self.DownloadYears,self.YearsDict))
        self.br = mechanicalsoup.StatefulBrowser()
        self.cookiejar = cl.LWPCookieJar()
        self.br.set_cookiejar( self.cookiejar )
        self.br.addheaders = [ ( 'User-agent', 'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.1) Gecko/2008071615 Fedora/3.0.1-1.fc9 Firefox/3.0.1' ) ] 

    def DownloadData(self):
        if self.opts['Dataset'] == "PSID":
            self.LoginDownloadAll()
        elif self.opts['Dataset'] == "ACS":
            self.FTPGetStructure()
        else:
            self.DirectDownloadAll()

    def DirectDownloadAll(self):

        html = urllib.request.urlopen(self.BaseAddr).read()
        soup = BeautifulSoup(html, 'html.parser')

        for link in soup.find_all('a', href = True):
            if any(x in link['href'].split('/')[-1] for x in self.FileTypes):
                filetype = [i for i in self.FileTypes if i in link['href'].split('/')[-1]][0]
                if any(x in link['href'].split('/') for x in self.FileStubs):
                    filestub = [i for i in self.FileStubs if i in link['href'].split('/')][0]
                    fname = link['href'].split('/')[-1]
                    if any(x in fname for x in self.DownloadYears):
                        year = [i for i in self.DownloadYears if i in fname][0]
                        print(fname)
                        if not os.path.isdir(self.paths['Data'] + '/raw/' + filestub.upper() + self.YearsDict[year]):
                            os.mkdir(self.paths['Data'] + '/raw/' + filestub.upper() + self.YearsDict[year])

                        if filetype == 'zip':
                            if os.path.isdir(self.paths['Data'] + '/zips/' + filestub.upper() + self.YearsDict[year]):
                                os.chdir(self.paths['Data'] + '/zips/' + filestub.upper() + self.YearsDict[year])
                                wget.download(link['href'],'./'+fname)
                                with zipfile.ZipFile('./' + fname) as zf:
                                        zf.extractall(self.paths['Data'] + '/raw/' + filestub.upper() + self.YearsDict[year] + '/.')
                            else:
                                os.mkdir(self.paths['Data'] + '/zips/' + filestub.upper() + self.YearsDict[year])
                                os.chdir(self.paths['Data'] + '/zips/' + filestub.upper() + self.YearsDict[year])
                                wget.download(link['href'],'./'+fname)
                                with zipfile.ZipFile('./' + fname) as zf:
                                        zf.extractall(self.paths['Data'] + '/raw/' + filestub.upper() + self.YearsDict[year] + '/.')
                        else:
                            os.chdir(self.paths['Data'] + '/raw/' + filestub.upper() + self.YearsDict[year])
                            wget.download(link['href'],'./'+fname)


    def FTPGetStructure(self):
        # ftp = ftplib.FTP(self.BaseAddr)
        ftp = self.ftp
        ftp.login()
        ftp.cwd(self.FTPDirAddr['main'] + self.FTPDirAddr['data'])
        for item in ftp.nlst():
            if any(x in item for x in self.DownloadYears):
                year = [i for i in self.DownloadYears if i in item][0]
                print(item)
                try:
                    ftp.cwd(item)
                    ftp.cwd('../')
                    os.mkdir(self.paths['Data'] + '/' + item)
                except:
                    pass

    def FTPDownloadAll(self):
        # ftp = ftplib.FTP(self.BaseAddr)
        ftp = self.ftp
        ftp.login()
        ftp.cwd(self.FTPDirAddr['main'] + self.FTPDirAddr['data'])
        os.chdir(self.paths['Data'])
        print((ftp.nlst()))
        for item in ftp.nlst():
            if any(x in item for x in self.DownloadYears):
                year = [i for i in self.DownloadYears if i in item][0]
                print(item)
                try:
                    ftp.cwd(item+'/')
                    print((ftp.nlst()))
                    if os.path.isdir('./' + item + '/'):
                        os.chdir('./'  + item + '/')
                    for filename in ftp.nlst():
                        print(filename)
                        try:
                            ftp.cwd(filename+'/')
                            ftp.cwd('../')
                        except:
                            if not os.path.isfile('./' + filename):
                                with open(filename,'wb') as f:
                                    ftp.retrbinary('RETR %s' % filename, f.write)
                                    f.close()
                                time.sleep(randint(1,10))
                    ftp.cwd('../')
                    os.chdir(self.paths['Data'])
                    time.sleep(randint(5,30))
                except:
                    print("there was an error")
                    if not os.path.isfile('./' + item):
                        try:
                            with open(item,'wb') as f:
                                ftp.retrbinary('RETR %s' % item, f.write)
                                f.close()
                            time.sleep(randint(1,10))
                        except:
                            with open(item,'wb') as f:
                                f.write('there was an error with this file')
                                f.close()

    def LoginDownloadAll(self):
        
        self.br.open(self.LoginAddr)
        html = rq.get(self.LoginAddr)

        # parse and retrieve two vital form values
        viewstate = BeautifulSoup(html.text, "html.parser").find("input", {"id":"__VIEWSTATE"}).attrs["value"]
        eventvalidation = BeautifulSoup(html.text, "html.parser").find("input", {"id":"__EVENTVALIDATION"}).attrs["value"]

        form = self.br.select_form()
        print(form)
        
        # formData = (
        #     ('ctl00$ContentPlaceHolder1$Login1$UserName',self.opts['Username']),
        #     ('ctl00$ContentPlaceHolder1$Login1$Password',self.opts['Password']),
        #     ('ctl00$ContentPlaceHolder1$Login1$LoginButton','Log In'),
        #     ('__VIEWSTATE', viewstate),
        #     ('__EVENTVALIDATION', eventvalidation),
        # )

        form = self.br.select_form()
        form.set('ctl00$ContentPlaceHolder1$Login1$UserName',self.opts['Username'])
        form.set('ctl00$ContentPlaceHolder1$Login1$Password',self.opts['Password'])
        form.set('ctl00$ContentPlaceHolder1$Login1$LoginButton','Log In')
        form.set('__VIEWSTATE',viewstate)
        form.set('__EVENTVALIDATION',eventvalidation)

        # encodedFields = urllib.parse.urlencode(formData)
        # self.br.open(self.LoginAddr,data=encodedFields)
        self.br.submit_selected()
        self.br.open(self.DataAddr)
        
        print(self.DownloadYears)

        for year in self.DownloadYears:
            print(("Downloading " + str(year) + " Family File"))
            if os.path.isdir(self.paths['Data'] + '/zip/'):
                os.chdir(self.paths['Data'] + '/zip/')
            if not self.opts['ReplaceData'] == True:
                if not os.path.isfile('./' + 'FAM'+str(year)+'.zip'):
                    datafile = self.br.follow_link(text = str(year))
                    with open('FAM'+str(year)+'.zip','wb') as output:
                        output.write(datafile.content)
                    time.sleep(randint(1,10))
            else:
                datafile = self.br.follow_link(text = str(year))
                with open('FAM'+str(year)+'.zip','wb') as output:
                    output.write(datafile.content)
                time.sleep(randint(1,10))
            self.br.open(self.DataAddr)

        for item in self.ExtraMainFiles:
            print(("Downloading " + item))
            if os.path.isdir(self.paths['Data'] + '/zip/'):
                os.chdir(self.paths['Data'] + '/zip/')
            if not self.opts['ReplaceData'] == True:
                if not os.path.isfile('./' + item +'.zip'):
                    datafile = self.br.follow_link(text = item)
                    with open(item+'.zip','wb') as output:
                        output.write(datafile.content)
                    time.sleep(randint(1,10))
            else:
                datafile = self.br.follow_link(text = item)
                with open(item+'.zip','wb') as output:
                    output.write(datafile.content)
                time.sleep(randint(1,10))
            self.br.open(self.DataAddr)


    def UnzipData(self):

        os.chdir(self.paths['Data'] + '/zip/')

        if not os.path.isdir(self.paths['Data'] + '/raw/'):
            os.mkdir(self.paths['Data'] + '/raw/')
        for year in self.DownloadYears:
            if not os.path.isdir(self.paths['Data'] + '/raw/Fam' + str(year) + '/'):
                os.mkdir(self.paths['Data'] + '/raw/Fam' + str(year) + '/')
            with zipfile.ZipFile('FAM'+str(year)+'.zip') as zf:
                zf.extractall(self.paths['Data'] + '/raw/Fam' + str(year) + '/')
            if not os.path.isdir(self.paths['Docs'] + '/codebooks/Fam' + str(year) + '/'):
                os.mkdir(self.paths['Docs'] + '/codebooks/Fam' + str(year) + '/')
            sourcefiles = os.listdir(self.paths['Data'] + '/raw/Fam' + str(year) + '/')
            for f in sourcefiles:
                if f.endswith('.pdf'):
                    shutil.move(os.path.join(self.paths['Data'] + '/raw/Fam' + str(year) + '/',f), os.path.join(self.paths['Docs'] + '/codebooks/Fam' + str(year) + '/',f))


        for item in self.ExtraMainFiles:
            if not os.path.isdir(self.paths['Data'] + '/raw/' + item + '/'):
                os.mkdir(self.paths['Data'] + '/raw/' + item + '/')
            with zipfile.ZipFile(item+'.zip') as zf:
                zf.extractall(self.paths['Data'] + '/raw/' + item + '/')
            if not os.path.isdir(self.paths['Docs'] + '/codebooks/' + item + '/'):
                os.mkdir(self.paths['Docs'] + '/codebooks/' + item + '/')
            sourcefiles = os.listdir(self.paths['Data'] + '/raw/' + item + '/')
            for f in sourcefiles:
                if f.endswith('.pdf'):
                    shutil.move(os.path.join(self.paths['Data'] + '/raw/' + item + '/',f), os.path.join(self.paths['Docs'] + '/codebooks/' + item + '/',f))


    # def DownloadCodebooks(self)

    def LoginDownloadCodebooks(self):

        CodebookAddr = 'https://simba.isr.umich.edu/VS/i.aspx'

        self.br.open(self.CodebookAddr)
        html = rq.get(self.CodebookAddr)

        # parse and retrieve two vital form values
        viewstate = BeautifulSoup(html.text, "html.parser").find("input", {"id":"__VIEWSTATE"}).attrs["value"]
        eventvalidation = BeautifulSoup(html.text, "html.parser").find("input", {"id":"__EVENTVALIDATION"}).attrs["value"]

        form = self.br.select_form()
        print(form)
        
        # formData = (
        #     ('ctl00$ContentPlaceHolder1$Login1$UserName',self.opts['Username']),
        #     ('ctl00$ContentPlaceHolder1$Login1$Password',self.opts['Password']),
        #     ('ctl00$ContentPlaceHolder1$Login1$LoginButton','Log In'),
        #     ('__VIEWSTATE', viewstate),
        #     ('__EVENTVALIDATION', eventvalidation),
        # )

        form = self.br.select_form()
        form.set('__VIEWSTATE',viewstate)
        form.set('__EVENTVALIDATION',eventvalidation)

        # encodedFields = urllib.parse.urlencode(formData)
        # self.br.open(self.LoginAddr,data=encodedFields)
        self.br.submit_selected()
        self.br.open(self.DataAddr)
        
        print(self.DownloadYears)

        for year in self.DownloadYears:
            print(("Downloading " + str(year) + " Family File"))
            if os.path.isdir(self.paths['Data'] + '/zip/'):
                os.chdir(self.paths['Data'] + '/zip/')
            if not self.opts['ReplaceData'] == True:
                if not os.path.isfile('./' + 'FAM'+str(year)+'.zip'):
                    datafile = self.br.follow_link(text = str(year))
                    with open('FAM'+str(year)+'.zip','wb') as output:
                        output.write(datafile.content)
                    time.sleep(randint(1,10))
            else:
                datafile = self.br.follow_link(text = str(year))
                with open('FAM'+str(year)+'.zip','wb') as output:
                    output.write(datafile.content)
                time.sleep(randint(1,10))
            self.br.open(self.DataAddr)

        for item in self.ExtraMainFiles:
            print(("Downloading " + item))
            if os.path.isdir(self.paths['Data'] + '/zip/'):
                os.chdir(self.paths['Data'] + '/zip/')
            if not self.opts['ReplaceData'] == True:
                if not os.path.isfile('./' + item +'.zip'):
                    datafile = self.br.follow_link(text = item)
                    with open(item+'.zip','wb') as output:
                        output.write(datafile.content)
                    time.sleep(randint(1,10))
            else:
                datafile = self.br.follow_link(text = item)
                with open(item+'.zip','wb') as output:
                    output.write(datafile.content)
                time.sleep(randint(1,10))
            self.br.open(self.DataAddr)


    def DownloadCodebooks(self):
        
        for year in self.DownloadYears:
            os.chdir(self.paths['Docs'] + '/codebooks/Fam' + str(year) + '/')
            sourcefiles = os.listdir('./')
            for f in sourcefiles:
                if f.endswith('.pdf'):
                    fname = f.replace(".pdf","")
                    subprocess.call(['pdftotext','-layout',fname + ".pdf",fname + '.txt'])

    def CreateXMLLists(self):
        
        DataCrosswalk = pd.read_excel(self.VariableCrosswalk)
        
        print(self.DownloadYears)

        for year in self.DownloadYears:
            print(str(year))
            txttoXMLFile = os.path.join(self.paths['Docs'] + '/codebooks/Fam' + str(year) + '/' + 'FamXML' + str(year) + '.txt')
            DataYearSubset = DataCrosswalk['Y' + str(year)].unique()
            DataYearSubset = DataYearSubset[~pd.isnull(DataYearSubset.tolist())]
            with open(txttoXMLFile,'w') as txtFile:
                # for i in range(0,len())
                txtFile.write(str.join('\n',DataYearSubset.tolist()))


    def LoginDownloadXMLCodebooks(self):
        
        self.br.open(self.LoginAddr)
        html = rq.get(self.LoginAddr)

        # parse and retrieve two vital form values
        viewstate = BeautifulSoup(html.text, "html.parser").find("input", {"id":"__VIEWSTATE"}).attrs["value"]
        eventvalidation = BeautifulSoup(html.text, "html.parser").find("input", {"id":"__EVENTVALIDATION"}).attrs["value"]


        form = self.br.select_form()
        form.set('ctl00$ContentPlaceHolder1$Login1$UserName',self.opts['Username'])
        form.set('ctl00$ContentPlaceHolder1$Login1$Password',self.opts['Password'])
        form.set('ctl00$ContentPlaceHolder1$Login1$LoginButton','Log In')
        form.set('__VIEWSTATE',viewstate)
        form.set('__EVENTVALIDATION',eventvalidation)

        self.br.submit_selected()
        self.br.open(self.VarListAddr)

        print(self.DownloadYears)

        for year in self.DownloadYears:
            print(year)

            self.br.open(self.CreateCodebookAddr)
            
            submit = self.br.get_current_page().find('input', id='ContentPlaceHolder1_CartXML_btnEmptyCart')
            form = self.br.select_form()
            form.choose_submit(submit)
            self.br.submit_selected()

            self.br.open(self.VarListAddr)
            html = rq.get(self.VarListAddr)

            viewstate = BeautifulSoup(html.text, "html.parser").find("input", {"id":"__VIEWSTATE"}).attrs["value"]
            eventvalidation = BeautifulSoup(html.text, "html.parser").find("input", {"id":"__EVENTVALIDATION"}).attrs["value"]

            XMLFile = os.path.join(self.paths['Docs'] + '/codebooks/Fam' + str(year) + '/' + 'FamXML' + str(year) + '.xml')
            txttoXMLFile = os.path.join(self.paths['Docs'] + '/codebooks/Fam' + str(year) + '/' + 'FamXML' + str(year) + '.txt')
            
            form = self.br.select_form()
            
            with open(txttoXMLFile,'r') as txtFile:
                form.set('ctl00$ContentPlaceHolder1$txtUserList',txtFile.read())
                form.set('__VIEWSTATE',viewstate)
                form.set('__EVENTVALIDATION',eventvalidation)
            self.br.submit_selected()
            self.br.open(self.CreateCodebookAddr)
            

            submit = self.br.get_current_page().find('input', id='ContentPlaceHolder1_CartXML_btnCheckout')
            form = self.br.select_form()
            form.choose_submit(submit)
            self.br.submit_selected()

            form = self.br.select_form()
            form.set('ctl00$ContentPlaceHolder1$Checkout1$hdncbOnly','true')
            form.set_radio({'ctl00$ContentPlaceHolder1$Checkout1$rblDoc':'xml'})
            self.br.submit_selected()

            time.sleep(5)
            datalink = self.br.get_current_page().find(id='ContentPlaceHolder1_GridView1_HyperLink1_0')
            if datalink is None:
                datadlnum = datadlnum + 1
                datadownloadlink = datadlstr + str(datadlnum) + '_codebook.xml'
                print("datalink was NoneType, using previous address.")
            else:
                match = re.match(r"([A-Za-z]+)([0-9]+)",datalink.text, re.I)
                if match:
                    tempitems = match.groups()
                    datadlstr = tempitems[0]
                    datadlnum = int(tempitems[1])
                datadownloadlink = datalink.text

            time.sleep(5)
            datafile = self.br.open('https://simba.isr.umich.edu/downloads/'+datadownloadlink)
            print(datafile)
            print('https://simba.isr.umich.edu/downloads/'+datadownloadlink)
            time.sleep(5)
            with open(XMLFile,'w') as output:
                output.write(datafile.content.decode("utf-8", "ignore"))
            time.sleep(randint(1,10))
