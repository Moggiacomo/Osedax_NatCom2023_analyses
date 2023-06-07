if __name__ == "__main__":

    import re

    i = open("riftia_GO_only_raw.txt", "r")
    o = open("riftia_GO_universe.txt", "w")

    regex = re.compile(r'GO:\d+')

    for line in i:
        GOmatches = regex.findall(line)
        Gene_ID = line.split("\t",1)[0]
        if not GOmatches == []:
            o.write(Gene_ID+"\t")
            for i, match in enumerate(GOmatches):
                if i+1 == len(GOmatches):
                    o.write(match.strip("'")+"\n")
                else:
                    o.write(match.strip("'")+", ")
