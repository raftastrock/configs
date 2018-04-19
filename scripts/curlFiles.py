#!/usr/bin/env python3

import json
import subprocess
import socket
import socks
import urllib.request


def main():
    jsonFile = open("stuff.json", "r")

    if jsonFile.mode == "r":
        obj = json.load(jsonFile)

        socks.setdefaultproxy(socks.PROXY_TYPE_SOCKS5, '127.0.0.1', 9050)
        socket.socket = socks.socksocket

        index = 1

        for key, value in obj.items():
            print("i:", index, key, value, "\n")

            urllib.request.FancyURLopener().retrieve(
                value, '/home/ryan/Videos/FrontEnd/4SemestersOfCompSciPartI/' + str(index) + "_" + key + '.webm')

            index = index + 1

    else:
        print("hello")


if __name__ == "__main__":
    main()
