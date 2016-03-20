.PHONY : all sty pre doc log ind ctan clean

all : sty doc

sty : asapsym.sty

asapsym.sty asapsym.code.tex asapsym-generic.tex : asapsym.ins asapsym.dtx
	latex $<

pre : asapsym.pdf

asapsym.pdf : asapsym.dtx
	lualatex $<

doc : asapsym.sty pre log ind asapsym.pdf

log : pre asapsym.gls

asapsym.gls : asapsym.glo
	makeindex -s gglo.ist -o $@ $<

ind : pre asapsym.ind

asapsym.ind : asapsym.idx
	makeindex -s gind.ist -o $@ $<

clean : 
	rm -f asapsym{.sty,.code.tex,-generic.tex,.pdf}
