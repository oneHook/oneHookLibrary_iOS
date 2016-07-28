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
    rv = []
    finput = open(filename)
    line = finput.readline()
    while line != "":
        start = 0
        match = string_re.search(line, start)
        while match != None:
            print("Found ({0}, {1})".format(match.start(), match.end()))
            print(line)
            print(" " * match.start() + "^" + " " * (match.end() - match.start() - 2) + "^")
            rv.append("{0} = {0}".format(line[match.start():match.end()]))
            # key = input("Press enter to change: ")
            # if key == "":
            #     print("Change ")
            print("-" * 15)
            match = string_re.search(line, match.end())
        line = finput.readline()
    finput.close()
    return rv

