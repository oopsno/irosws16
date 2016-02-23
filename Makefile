pdf: metapost
	pdflatex workshop.tex
	bibtex   workshop
	pdflatex workshop.tex
	pdflatex workshop.tex

metapost: figures.mp 
	mptopdf $^

.PHONY: clean

clean:
	-rm -f *.aux *.log *.pdf *.1 *.mpx *.dvi
