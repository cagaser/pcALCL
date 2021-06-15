"""
Liana van Grieken
11-04-2019
Making a stacked bar plot from bed files
"""
import os
import csv
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rc
import pandas as pd


LS_CHECK = ['chr1', 'chr2','chr3', 'chr4','chr5','chr6','chr7','chr8',
            'chr9', 'chr10','chr11','chr12','chr13','chr14','chr15',
            'chr16','chr17','chr18','chr19','chr20','chr21','chr22',
            'chrX','chrY']
LS_COLOR = ['#000000','#080808','#181818','#282828', '#303030','#404040',
            '#505050','#606060','#696969','#808080', '#909090','#A0A0A0',
            '#B0B0B0','#BEBEBE','#C0C0C0','#C8C8C8', '#D0D0D0','#D3D3D3',
            '#D8D8D8','#DCDCDC','#E0E0E0','#E8E8E8', '#F0F0F0','#F5F5F5']

def getFiles():
    """
    Get the file names from the directory in the variable path.
    It then loops through the directory and appends files names
    to list if they end with .bedpe.
    """
    path = '/home/liana/Desktop/NPAIRS'
    folder = os.fsencode(path)
    filenames = []
    for file in os.listdir(folder):
        filename = os.fsdecode(file)
        if filename.endswith('.bedpe'):
            filenames.append(filename)
    return filenames

def readFile(file):
    """
    Read the columns from the input files with the chromosome
    number in it. This is column 1 and 4 in the bed file.
    It then return the right and left breakpoints. 
    """
    with open(file) as inf:
        reader = csv.reader(inf, delimiter="\t")
        chrom_right = list(zip(*reader))[0]
    with open(file) as inf:
        reader = csv.reader(inf, delimiter="\t")
        chrom_left = list(zip(*reader))[3]
    return chrom_right + chrom_left

def countChrom(ls_chrom):
    """
    Counts how often the different chromosomes are present in the list and
    returns this as a list.
    """
    count = []
    for i in LS_CHECK:
        count.append(ls_chrom.count(i))
    return count
    
def makePlot(counts, files):
    """
    It takes the list with files names and list with alle the counts.
    Then it loops through the count list and adds these to a bar object.
    The height calculates the bottom of the next bar so it gets stacked on
    top of each other. outside the loop the plt.bar object gets finished
    with labels for the x & y-axsis and the plot is shown in a sepparate window.
    """
    r = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    barWidth = 0.75
    for i in range(0,len(counts)):
        height = 0
        for j in range(len(counts[i])):
            plt.bar(r[i], counts[i][j], bottom = height ,color=LS_COLOR[j],
                    edgecolor='#000000', width=barWidth, label=LS_CHECK[j])
            height = np.add(height, counts[i][j])
    plt.xticks(r, files)
    plt.xlabel("Sample", fontweight='bold', fontsize='large')
    plt.ylabel("Count", fontweight='bold', fontsize='large')
    plt.legend()
    plt.yticks(np.arange(0, 2000, 50))
    plt.show()

def main():
    """

    """
    ls_count = []
    ls_files = getFiles()
    for i in ls_files:
        chrom = readFile(i)
        ls_count.append(countChrom(chrom))
    makePlot(ls_count, ls_files)
    
main()
