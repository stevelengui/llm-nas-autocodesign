# Makefile for LLM-NAS AutoCoDesign Project
# Domain: industrial
# MCU: stm32

CC = gcc
CFLAGS = -O2 -Wall -I.
TARGET = llm_nas_system

SRC = main.c
OBJ = $(SRC:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -f $(OBJ) $(TARGET)

.PHONY: all clean
