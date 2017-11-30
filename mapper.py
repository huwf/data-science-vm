#!/usr/bin/env python
# MAPPER

import csv
import sys

input_text = open('Youtube04-Eminem.csv', 'r')
# When we move to the actual MapReduce job, we will need to read from STDIN
input_text = sys.stdin

reader = csv.reader(input_text)
# Skip the column header
next(reader)
for row in reader:
    if row[3].strip() == '':
        continue
    tokens = row[3].split(' ')
    for t in tokens:
        # print tab delimted here,
        # will be input for the reducer
        print('%s\t%d' % (t, 1))    
    # Only do it for the first record for now
    #break

# input_text.close()