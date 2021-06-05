QCC=fteqcc
DEFEXTRACT=java tools/QDefExtractor.java progs.src output/libreprogs.def

all:
	-mkdir output
	cp qcsrc/progs_deluxe.src progs.src
	$(QCC)
	$(DEFEXTRACT)
	-rm progs.src

vanilla:
	-mkdir output
	cp qcsrc/progs_vanilla.src progs.src
	$(QCC)
	$(DEFEXTRACT)
	-rm progs.src
	 	
clean:
	-rm -rf output
