import file_utility as utility

target = "../../Dooo-iOS"

mfiles = utility.scan_m_files(target)

fout = open("output.txt", "w")

for fp in mfiles:
    print("Scan " + fp[0])

    lines = utility.scan_lines(fp[0])
    if len(lines) > 0:
        fout.write("/* {0} */\n\n".format(fp[1]))
        fout.writelines(list(map(lambda x: x + "\n", lines)))
        fout.write("\n\n")

fout.close()

