QCC=fteqcc

all:
	-mkdir output
	$(QCC)
	 	
clean:
	-rm -rf output
