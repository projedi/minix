# Makefile for commands.

MAKE	= exec make -$(MAKEFLAGS)
FLEX=flex-2.5.4
BZIP2=bzip2-1.0.3

SMALLPROGRAMS=`arch` aal advent ash autil awk bc byacc cawf cron de dhcpd dis88 elle elvis ftp ftpd ftpd200 httpd ibm indent m4 make mdb mined patch ps reboot rlogind scripts sh simple talk talkd telnet telnetd urlget yap zmodem

usage:
	@echo "Usage: make all          # Compile all commands" >&2
	@echo "       make install      # Install the result (run as bin!)" >&2
	@echo "       make clean        # Delete .o files and other junk" >&2
	@echo "       make big          # Compile all big commands" >&2
	@echo "       make biginstall   # Install all big commands" >&2
	@echo "       make small        # Install all small commands" >&2
	@echo "       make smallinstall # Install all small commands" >&2
	@echo "       make ack          # Make ack" >&2
	@echo "       make ackinstall   # Install ack" >&2
	@echo " "
	@echo "big compiles the commands the require large compiler sizes."
	@echo "small compiles the rest. all compiles all."
	@false

all: small big

install: biginstall smallinstall

big:
	cd $(FLEX) && /bin/sh makeme.sh 
	cd $(BZIP2) && /bin/sh makeme.sh 

biginstall: big
	cd $(FLEX) && make install
	cd $(BZIP2) && make install

clean::
	if [ -f $(FLEX)/Makefile ] ; then cd $(FLEX) && make $@; fi
	if [ -f $(GZIP)/Makefile ] ; then cd $(GZIP) && make $@; fi
	cd $(BZIP2) && make clean
	for p in $(SMALLPROGRAMS); do ( cd $$p && make clean ); done

small::
	for p in $(SMALLPROGRAMS); do ( cd $$p && make all ); done

smallinstall::
	for p in $(SMALLPROGRAMS); do ( cd $$p && make install ); done

ack:
	cd ackpack && make

ackinstall:
	cd ackpack && make install

