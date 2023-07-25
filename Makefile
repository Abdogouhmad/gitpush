#colors
RED=\033[0;31m
GREEN=\033[0;32m
NC=\033[0m # No Color
MAGENTA=\033[0;35m
YELLOW=\033[0;33m

#PROGRAM NAME
PROG= gitauto
SRC= $(wildcard *.c)
SUMFILE= checksum.md5
SUMFILEFDIR= /tmp/src.tmp
OBJ= $(SRC:.c=.o)
FILES = $(OBJ)
#COMPILER variable

CC= cc
CFLAGS= -Wall -pedantic -Wextra -std=gnu89 -g

#rules and recipes

build: ${PROG}

${PROG}: ${OBJ}
	@printf "$(YELLOW)In porcess ... to compile the $(GREEN)$(PROG)${NC}"
	@$(CC) $(CFLAGS) -o $@ $^
	@printf "$(YELLOW)$(PROG)$(GREEN) compiled successfully${NC}"

%.o: %.c
	@$(CC) $(CFLAGS) -c -o $@ $<

run: build
	@./$(PROG)

clean:
	@printf "$(YELLOW)Cleaning ...$(NC)"
	@rm -f $(FILES)
	@if [ $$? -eq 0 ]; then printf "$(MAGENTA)Files $(FILES) are removed successfully"; else printf "$(RED)Error: Files $(FILES) are not removed"; fi

generatesum:
	@printf "$(YELLOW)In process ... to generate all files into $(SUMFILE)"
	@md5sum ./* > $(SUMFILE)
	@if [ $$? -eq 0 ]; then @sed -i "s,./,/tmp/$(SUMFILEFDIR)/,g" $(SUMFILE) && printf "$(MAGENTA)$(SUMFILE) is generated sucessfully"; else printf "$(RED)Error: $(SUMFILE) is not generated successfully or sed fdir is not successful; fi


checksum:
	@printf "$(YELLOW)Checking with md5sum ...$(NC)"
	@md5sum --check $(SUMFILE) --quiet
	@if [ $$? -eq 0 ]; then printf "$(MAGENTA)checksum, md5sum checked with $(SUMFILE) sucesfully"; else printf "$(RED)Error: checkedsum, md5sum faild checking with $(SUMFILE); fi




#@if [ $$? -eq 0 ]; then\ 
#	printf "$(MAGENTA)Files $(files) are removed successfully"; \
#else \
#	printf "$(RED)Error: Files $(files) are not removed"; \
#fi

.PHONY: clear run build checksum
