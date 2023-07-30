#colors
RED=\033[0;31m
GREEN=\033[0;32m
NC=\033[0m # No Color
MAGENTA=\033[0;35m
YELLOW=\033[0;33m

#PROGRAM NAME
PROG = gitauto
SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)
FILES = $(OBJ)
DIR = $(shell pwd)
INSTALLDIR = /usr/bin
#COMPILER variable

CC = cc
CFLAGS = -Wall -pedantic -Wextra -std=gnu89 -g

#rules and recipes
compile: ${PROG}
${PROG}: ${OBJ}
	@printf "$(YELLOW)In porcess ... to compile the $(GREEN)$(PROG)${NC}\n"
	$(CC) $(CFLAGS) -o $@ $^
	@printf "$(YELLOW)$(PROG)$(GREEN) compiled successfully${NC}\n"

%.o: %.c
	@$(CC) $(CFLAGS) -c -o $@ $<

run: compile
	@./$(PROG)

clean:
	@printf "$(YELLOW)Cleaning ...$(NC)\n"
	@rm -f $(FILES)
	@if [ $$? -eq 0 ]; then printf "$(MAGENTA)Files $(FILES) are removed successfully\n"; else printf "$(RED)Error: Files $(FILES) are not removed\n"; fi


install: compile
	@printf "$(YELLOW)Installing into $(INSTALLDIR)... $(NC)\n"
	@install $(PROG) $(INSTALLDIR)
	@if [ $$? -eq 0 ]; then printf "$(MAGENTA)Installed sucessfully.\n"; else printf "$(RED)Error: install faild to install into $(INSTALLDIR), are you root?\m"; fi

.PHONY: run compile clean install

