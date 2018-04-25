#!/usr/bin/env python3

import os
import json
import socket
import socks
import urllib.request
import shutil
from shutil import make_archive


def main():
    jsonFile = open('stuff.json', 'r')

    if jsonFile.mode == 'r':
        obj = json.load(jsonFile)

        folderName = 'JSHardParts'
        destDir = '/home/ryan/Videos/FrontEnd/' + folderName + '/'

        if not os.path.isdir(destDir):
            os.mkdir(destDir)

        socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5, '127.0.0.1', 9050)
        socket.socket = socks.socksocket

        index = 1

        for key, value in obj.items():

            title = key.replace('/', '-').replace('\\', '-')

            fileName = destDir + str(index) + '_' + title + '.webm'

            if not os.path.isfile(fileName):
                print('Downloading file ===>', str(index), fileName, '\n')

                urllib.request.FancyURLopener().retrieve(value, fileName)
            else:
                print('FILE EXISTS ===>', fileName, '\n')

            index = index + 1

        zipFilePath = destDir + folderName + '.zip'

        if not os.path.isfile(zipFilePath):
            os.chdir(destDir)
            print('Zipping file ===>', os.getcwd())
            shutil.make_archive(folderName, 'zip')
        else:
            print('ZIP FILE EXISTS ===>', zipFilePath)


if __name__ == '__main__':
    main()
