objects := $(basename $(wildcard *.Rmd))
.PHONY: build pdf html clean
# do not delete *.md files
.SECONDARY = $(addsuffix .md, $(objects))

# main target
build: pdf

# pattern rule: how to create a md from a rmd
%.md : %.Rmd
	Rscript \
		-e 'library(knitr)' \
		-e 'render_markdown(strict = FALSE)' \
		-e 'opts_knit$$set(progress=FALSE, verbose=FALSE)' \
		-e 'null <- knitr::knit(input="$<",output="$@", quiet=TRUE)'
	cp $@ ../tutorial
	sed -i '1,6d' $@
	
# pattern rule: how to create a html from a md
# %.html : %.md
#	pandoc --from=markdown --to=html -o $@ $<	

# pattern rule: how to create a tex from a md
%.tex : %.md
	pandoc --from=markdown-implicit_figures --to=latex -o $@ $<
	sed -i 's/\.png/\.pdf/g' $@

# build main pdf
pdf: $(addsuffix .tex, $(objects)) tutorial.tex
	latexmk -pdf tutorial.tex
	cp tutorial.pdf ../tutorial
	cp -r figure ../tutorial

# build html pages
# html: $(addsuffix .html, $(objects))
# html: $(addsuffix .md, $(objects))
	

clean :
	-rm -rf $(addsuffix .html, $(objects)) \
            $(addsuffix .md, $(objects)) \
            $(addsuffix .tex, $(objects))
	-rm -rf figure
	-latexmk -c -quiet tutorial.tex
