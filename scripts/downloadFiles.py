#!/usr/bin/env python3

import os
import zipfile
import json
import subprocess
import socket
import socks
import urllib.request
import shutil
from shutil import make_archive


def main():
    jsonFile = open("stuff.json", "r")

    if jsonFile.mode == "r":
        obj = json.load(jsonFile)

        folderName = "WebSecurity"
        destDir = "/home/ryan/Videos/FrontEnd/" + folderName + "/"

        socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5, '127.0.0.1', 9050)
        socket.socket = socks.socksocket

        index = 1

        for key, value in obj.items():
            print("i:", index, key, value, "\n")

            urllib.request.FancyURLopener().retrieve(
                value, destDir + str(index) + "_" + key + '.webm')

            index = index + 1

        shutil.make_archive(folderName, "zip", destDir)

    else:
        print("hello")


if __name__ == "__main__":
    main()
