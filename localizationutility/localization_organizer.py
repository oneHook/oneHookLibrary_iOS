import file_utility as utility

target = "../../Dooo-iOS"

mfiles = utility.scan_m_files(target)

for fp in mfiles:
    print("Scan " + fp[0])
    utility.scan_lines(fp[0])


