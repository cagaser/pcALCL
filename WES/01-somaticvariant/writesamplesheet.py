import sys

def main():
    filename=(sys.argv[1])
    filename=(filename.replace(".gz", ""))
    namelist=(filename.split("/"))
    samplename=(namelist[-1].split("L")[1])
    refname=(samplename.replace("T", "N"))
    if samplename[0] == "T":
        with open("samplesheetwes.csv", "a") as outfile:
            outfile.write('"' + samplename + '","lib1","' + namelist[-1] + '","' + refname + '","' + filename + '_1.fastq.gz",,"' + filename + '_2.fastq.gz",\n')
    if samplename[0] == "N":
        with open("samplesheetwes.csv", "a") as outfile:
            outfile.write('"' + samplename + '","lib1","' + namelist[-1] + '",,"' + filename + '_1.fastq.gz",,"' + filename + '_2.fastq.gz",\n')

main()
