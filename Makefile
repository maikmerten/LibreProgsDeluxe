QCC=fteqcc

all:
	-mkdir output
	cp progs_deluxe.src progs.src
	$(QCC)
	-rm progs.src

vanilla:
	-mkdir output
	cp progs_vanilla.src progs.src
	$(QCC)
	-rm progs.src
	 	
clean:
	-rm -rf output
