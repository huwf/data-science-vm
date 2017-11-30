#!/usr/bin/env python
# REDUCER

import sys
# Keep simple example in for now, switch to stdin later

input_text = sys.stdin
words = {}

for line in input_text:
    #print('line: ', line)
    if line.strip() == '':
        continue
    try:
        word, count = line.split('\t', 1)
    except:
        continue
    #print('word: %s count: %s' % (word, count))
    
    # Convert count to an integer
    try:
        count = int(count)
    except ValueError:
        # We can safely ignore, so keep calm and carry on
        continue
        
        
    if word in words:
        words[word] += 1
    else:
        words[word] = 1
        
for w in words:
    print('%s\t%s' % (w, words[w]))