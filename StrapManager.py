#!/usr/bin/env python3

import csv
import subprocess

def determine_distro():
    global current_distro
    from platform import system
    assert system() == "Linux", "Non-Linux platforms are not supported"
    if current_distro != None: # The distro is already known
        return
    current_distro = subprocess.check_output("hostnamectl | grep -E '^Operating System' | sed 's/.*://'", shell = True)
    current_distro = current_distro.decode("utf-8")
    current_distro = current_distro.lstrip().rstrip().lower()
    assert len(current_distro) > 0
    # NOTE: Values for current_distro have to be the same as in Packages.csv
    if "ubuntu" in current_distro:
        current_distro = "ubuntu"
    elif "debian" in current_distro:
        current_distro = "debian"
    elif "arch" in current_distro:
        current_distro = "arch"
    elif "fedora" in current_distro:
        current_distro = "fedora"
    else:
        assert False, "Distro not supported"

def grab_package_name(name: str):
    global current_distro
    determine_distro()
    assert current_distro != None
    with open('Packages.csv', newline='') as packages:
        packages_reader = csv.DictReader(packages)
        for row in packages_reader:
            if str(row['global']) == name:
                distro_package = str(row[current_distro])
                print(distro_package)
                return

current_distro = None
grab_package_name(input())
