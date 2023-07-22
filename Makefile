#colors
RED=\033[0;31m
GREEN=\033[0;32m
NC=\033[0m # No Color
MAGENTA=\033[0;35m
YELLOW=\033[0;33m

#PROGRAM NAME
PROG= pushc
SRC= $(wildcard *.c)
OBJ= $(SRC:.c=.o)
FILES = $(PROG) $(OBJ)
#COMPILER variable

CC= cc
CFLAGS= -Wall -pedantic -Wextra -std=gnu89 -g

#rules and recipes

build: $(PROG)
	@echo -e "$(YELLOW)In porcess ... to compile the $(GREEN)$(PROG)${NC}"
	@$(CC) $(CFLAGS) -o $@ $^
	@echo -e "$(YELLOW)$(PROG)$(GREEN) compiled successfully${NC}"

%.o: %.c
	@$(CC) $(CFLAGS) -c -o $@ $^

run: build
	@./$(PROG)

clear:
	@echo -e "$(YELLOW)Cleaning ...$(NC)"
	@rm -f $(FILES)
	@if [ $$? -eq 0 ]; then\ 
		@echo -e "$(MAGENTA)Files $(files) are removed successfully"; \
	else \
		@echo -e "$(RED)Error: Files $(files) are not removed"; \
	fi
