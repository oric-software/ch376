AS=xa
CC=cl65
CFLAGS=-ttelestrat
LDFILES=../telemon/src/include/libs/ca65/ch376.s


PROGRAM=ch376
SOURCE=src/ch376.c

ASFLAGS=-C -W -e error.txt -l xa_labels.txt -DTARGET_ORIX

$(PROGRAM): $(SOURCE)
	$(CC) -o $(PROGRAM) $(CFLAGS) $(LDFILES) $(SOURCE)

test:
	mkdir -p build/usr/bin/
	mkdir -p build/usr/share/man
	mkdir -p build/usr/share/ipkg  
	mkdir -p build/usr/share/doc/$(PROGRAM)/
	cp $(PROGRAM) build/usr/bin/
	cp src/man/$(PROGRAM).hlp build/usr/share/man
	cp src/ipkg/$(PROGRAM).csv build/usr/share/ipkg
	cp README.md build/usr/share/doc/$(PROGRAM)/
	cd build &&	tar -c * > ../$(PROGRAM).tar &&	cd ..  
	filepack  $(PROGRAM).tar $(PROGRAM).pkg
	gzip $(PROGRAM).tar
	mv $(PROGRAM).tar.gz $(PROGRAM).tgz
	php buildTestAndRelease/publish/publish2repo.php $(PROGRAM).pkg ${hash} 6502 pkg beta
	php buildTestAndRelease/publish/publish2repo.php $(PROGRAM).tgz ${hash} 6502 tgz beta
	echo nothing
