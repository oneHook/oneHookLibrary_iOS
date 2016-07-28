import os
import re

string_re = re.compile('(?<!NSLog\()@"[^"]+"')
## print(string_re.search('''this is a typical line @"abfdsfc"'''))

def scan_m_files(target):
    mfiles = []
    for root, dirs, files in os.walk(target):
        for file in files:
            if file.endswith(".m"):
                # print(os.path.join(root, file))
                mfiles.append((os.path.join(root, file), file))
    return mfiles


def scan_lines(filename):
    input = open(filename)
    line = input.readline()
    while line != "":
        matches = string_re.search(line)
        if matches != None:
            print(line)
        line = input.readline()
    input.close()

