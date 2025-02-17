quick:	browserCode roxy install

all:  browserCode roxy vig build install check


browserCode:
	(cd inst/browserCode; make assemble)

roxy:
	R -e "devtools::document()"
vig:
	R -e "devtools::build_vignettes()"

build:
	(cd ..; R CMD build igvR)

install:
	(cd ..; R CMD INSTALL --no-test-load igvR)

check:
	(cd ..; R CMD check --no-manual --ignoore-vignettes `ls -t igvR_* | head -1`)

biocCheck:
	(cd ..; R CMD BiocCheck `ls -t igvR_* | head -1`)

test:
	 for x in inst/unitTests/test_*.R; do echo ============== $$x; R -f $$x; done

site:
	R -e "devtools::build_site()"
