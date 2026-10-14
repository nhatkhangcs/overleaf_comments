VENUES := arr iclr cvpr aaai

.PHONY: all clean zips $(VENUES)

all: $(VENUES)

# build one demo, e.g. `make arr`
$(VENUES):
	cd examples/$@ && latexmk -interaction=nonstopmode main.tex

# self-contained Overleaf uploads: dist/<venue>.zip (includes sidecomments.sty)
zips:
	mkdir -p dist
	for v in $(VENUES); do \
	  rm -f dist/$$v.zip; \
	  (cd examples/$$v && zip -q -r ../../dist/$$v.zip . -x 'main.pdf' -x '*.aux' -x '*.log' -x '*.bbl' -x '*.blg' -x '*.out' -x '*.fls' -x '*.fdb_latexmk' -x '*.synctex.gz' -x 'latexmkrc'); \
	  zip -q -j dist/$$v.zip sidecomments.sty; \
	done
	@ls -1 dist

clean:
	for v in $(VENUES); do (cd examples/$$v && latexmk -C); done
	rm -rf dist
