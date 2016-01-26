pdf: metapost
	latex workshop.tex
	dvipdfmx workshop.dvi

metapost: *.1

*.1: *.mp
	mpost $^

.PHONY: clean

clean:
	-rm -f *.aux *.log *.pdf *.1 *.mpx *.dvi
