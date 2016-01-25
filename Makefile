pdf:
	pdflatex workshop.tex

.PHONY: clean

clean:
	-rm *.aux *.log *.pdf
