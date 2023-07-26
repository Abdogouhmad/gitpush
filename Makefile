#colors
RED=\033[0;31m
GREEN=\033[0;32m
NC=\033[0m # No Color
MAGENTA=\033[0;35m
YELLOW=\033[0;33m

#PROGRAM NAME
PROG = gitauto
SRC = $(wildcard *.c)
SUMFILE = checksum.md5
#OBJ = $(SRC:.c=.o)
FILES = $(OBJ)
DIR = $(shell pwd)
INSTALLDIR = /usr/bin
#COMPILER variable

CC = cc
CFLAGS = -Wall -pedantic -Wextra -std=gnu89 -g

#rules and recipes

build: checksum ${PROG} #clean 
#run: checksum ${PROG} build #clean

{PROG}:
	@printf "$(YELLOW)In porcess ... to compile the $(GREEN)$(PROG)${NC}\n"
	@$(CC) $(CFLAGS) -o $@ $^
	@printf "$(YELLOW)$(PROG)$(GREEN) compiled successfully${NC}\n"

#%.o: %.c
#	@$(CC) $(CFLAGS) -c -o $@ $<

run: build
	@./$(PROG)

clean:
	@printf "$(YELLOW)Cleaning ...$(NC)\n"
	@rm -f $(FILES)
	@if [ $$? -eq 0 ]; then printf "$(MAGENTA)Files $(FILES) are removed successfully\n"; else printf "$(RED)Error: Files $(FILES) are not removed\n"; fi

generatesum:
	@rm -f checksum.md5
	@rm -f $(FILES)
	@printf "$(YELLOW)In process ... to generate all files into $(SUMFILE)\n"
	@md5sum ./* > $(SUMFILE)
	@if [ $$? -eq 0 ]; then sed -i 's,./,$(DIR),g; /gitauto/d' $(SUMFILE) && printf "$(MAGENTA)$(SUMFILE) is generated sucessfully${NC}\n"; else printf "$(RED)Error: $(SUMFILE) is not generated successfully or sed fdir is not successful\n${NC}"; fi


checksum:
	@printf "$(YELLOW)verifying with md5sum... $(NC)\n"
	@md5sum --check $(SUMFILE) > /dev/null 2>&1
	@if [ $$? -eq 0 ]; then printf "$(MAGENTA)checksum, md5sum checked with $(SUMFILE) successfully\n"; else printf "$(RED)Error: checkedsum, md5sum faild checking with $(SUMFILE)\n"; fi

install:
	@printf "$(YELLOW)Installing into $(INSTALLDIR)... $(NC)\n"
	@install $(PROG) $(INSTALLDIR)
	@if [ $$? -eq 0 ]; then printf "$(MAGENTA)Installed sucessfully.\n"; else printf "$(RED)Error: install faild to install into $(INSTALLDIR), are you root?\m"; fi




#@if [ $$? -eq 0 ]; then\ 
#	printf "$(MAGENTA)Files $(files) are removed successfully"; \
#else \
#	printf "$(RED)Error: Files $(files) are not removed"; \
#fi

.PHONY: clear run build
