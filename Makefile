SRC = asapsym.ins asapsym.dtx
PKG = asapsym.sty asapsym.code.tex asapsym-generic.tex
INT = asapsym.aux asapsym.glo asapsym.gls asapsym.idx asapsym.ilg asapsym.ind asapsym.log
DOC = asapsym.pdf
CTAN = asapsym.dtx asapsym.ins asapsym.pdf README.md Asap-Symbol.otf
NAME = asapsym.tar.gz

.PHONY : all sty pre doc log ind ctan clean

all : sty doc

sty : $(PKG)

$(PKG) : $(SRC)
	latex $<

pre : $(DOC)

$(DOC) : asapsym.dtx
	lualatex $<

post : asapsym.dtx
	touch $(DOC)
	lualatex $<

doc : asapsym.sty pre log ind post

log : pre asapsym.gls

asapsym.gls : asapsym.glo
	makeindex -s gglo.ist -o $@ $<

ind : pre asapsym.ind

asapsym.ind : asapsym.idx
	makeindex -s gind.ist -o $@ $<

ctan : all
	cp $(CTAN) asapsym/
	tar -cf $(NAME) asapsym/

clean :
	rm -f $(INT) $(PKG) $(DOC)
