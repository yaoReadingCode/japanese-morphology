#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
reload(sys)
sys.setdefaultencoding('utf-8')
import codecs
from kimmo import *

sargs = sys.argv[:]
wordcorpusfn = 'japanese-words.txt'
if "corpus" in sargs:
	sargs.remove("corpus")
	wordcorpusfn = 'corpus/corpus-allwords-base-pos.txt'
passedword = ""
if len(sargs) > 1:
	passedword = sargs[1].decode("utf-8")

def listtostr(l):
	if type(l) == type([]):
		return "[" + (",".join([listtostr(x) for x in l])) + "]"
	elif type(l) == type((3,2)):
		return "(" + ",".join([listtostr(x) for x in l]) + ")"
	else:
		return l

def recword(k, word):
	featurelog = TextTrace(0)
	#print listtostr(k.recognize(word, featurelog)), '<=', word
	k.recognize(word, featurelog)
	#print word,
	success = False
	baseform = ""
	pos = ""
	for feat in featurelog.features:
		if "SUCCESS" in feat:
			success = True
			feat.remove("SUCCESS")
			for z in feat:
				if z[:5] == "BASE:" and baseform == "":
					baseform = z[5:]
				if z[:4] == "POS:" and pos == "":
					pos = z[4:]
	if pos == "Number":
		baseform = word
		pos = "Noun"
	if not success:
		#print "[FAILURE]"
		return None, None
	else:
		return baseform, pos
		#print baseform + " " + pos
	#print log

k = KimmoRuleSet.load('japanese.yaml')
if passedword != "":
	recword(k, passedword)
	exit(0)

recfile = codecs.open(wordcorpusfn, encoding='utf-8')
for line in recfile:
	line = line.strip()
	if not line: continue
	if line.startswith(';'):
		print line
		continue
	word,base,pos = line.split(" ")
	nbase,npos = recword(k, word)
	if nbase == None or npos == None:
		print word + " " + base + " " + pos + " [FAILURE]"
	elif base != nbase and pos != npos:
		print word + " " + base + "/" + nbase + " " + pos + "/" + npos + " [BPFAIL]"		
	elif base != nbase:
		print word + " " + base + "/" + nbase + " " + pos + " [BASEFAIL]"
	elif pos != npos:
		print word + " " + base + " " + pos + "/" + npos + " [POSFAIL]"
	else:
		print word + " " + base + " " + pos + " [SUCCESS]"
recfile.close()

