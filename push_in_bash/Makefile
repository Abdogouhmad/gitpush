# install push script

# coloring
COLOR_RESET = \033[0m
COLOR_RED = \033[31m
COLOR_GREEN = \033[32m
COLOR_YELLOW = \033[33m
COLOR_BLUE = \033[34m
COLOR_MAGENTA = \033[35m
COLOR_CYAN = \033[36m

# work
SCRIPT_NAME = push

# /usr/bin/ is typically in the PATH, making the script accessible as a built-in command
TARGET_DIR = /usr/bin
TARGET = $(TARGET_DIR)/$(SCRIPT_NAME)

install:
	# copy script to target directory
	@sudo cp $(SCRIPT_NAME) $(TARGET_DIR)
	@sudo chmod +x $(TARGET)
	@echo -e "${COLOR_GREEN}Install ${COLOR_MAGENTA}$(SCRIPT_NAME) ${COLOR_GREEN}to ${COLOR_MAGENTA}$(TARGET_DIR) ${COLOR_GREEN} successfully ${COLOR_RESET}"

uninstall:
	@sudo rm $(TARGET)
	@echo -e "${COLOR_GREEN}Uninstall ${COLOR_MAGENTA}$(SCRIPT_NAME) ${COLOR_GREEN}from ${COLOR_MAGENTA}$(TARGET_DIR) ${COLOR_GREEN} successfully ${COLOR_RESET}"

.PHONY: install uninstall

.DEFAULT_GOAL := install
