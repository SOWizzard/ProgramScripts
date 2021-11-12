#!/usr/bin/env python3

import csv

def die(message: str):
    if len(msg) != 0:
        from sys import stderr
        print(msg, file=stderr)
    exit(1)

def determine_distro():
    global current_distro
    from platform import system
    if system() != "Linux":
        die("Non-Linux platforms are not supported")
    else:
        if current_distro != None:
            return
        from shutil import which
        # NOTE: Values for current_distro have to be the same as in Packages.csv
        if which('pacman') != None:
            current_distro = 'arch'
        if which('apt') != None:
            # TODO: Find a way to differentiate Ubuntu from Debian!
            current_distro = 'debian'

def grab_package_name(name: str):
    global current_distro
    determine_distro()
    assert current_distro != None
    with open('Packages.csv', newline='') as packages:
        packages_reader = csv.DictReader(packages)
        for row in packages_reader:
            if row['global'] == name:
                print(row[current_distro])
                return

current_distro = None
grab_package_name(input())
