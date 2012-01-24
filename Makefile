# set latexfile to the name of the main file without the .tex
latexfile = poster

TEX = pdflatex

# reruns latex if needed.  to get rid of this capability, delete the
# three lines after the rule.  Delete .bbl dependency if not using
# BibTeX references.
# idea from http://ctan.unsw.edu.au/help/uk-tex-faq/Makefile

# keep .eps files in the same directory as the .fig files

$(latexfile).pdf : clean
	while ($(TEX) $(latexfile) ; \
	grep -q "Rerun to get cross" $(latexfile).log ) do true ; \
	done

pdf : $(latexfile).pdf


view : $(latexfile).pdf
	grep "Output written on" $(latexfile).log && \
	acroread $(latexfile).pdf 

clean : 
	rm -f $(latexfile).log 
	rm -f $(latexfile).out
	rm -f $(latexfile).aux
	rm -f $(latexfile).bbl
	rm -f $(latexfile).blg
	rm -f $(latexfile)-blx.bib
	rm -f $(latexfile).toc
	rm -f *.*~

purge : clean
	rm mf.pdf

info : 
	detex $(latexfile)  | echo The document contains `wc -w` words

spellcheck:
	hunspell -l -t -i utf-8 $(latexfile)