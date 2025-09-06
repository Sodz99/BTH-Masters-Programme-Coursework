# Snake Game Makefile
# Organized directory structure

# Directories
SRCDIR = src
INCDIR = include
BUILDDIR = build

# Tools
CC = gcc
AS = as

# Flags
CFLAGS = -Wall -g -no-pie -I$(INCDIR)
LDFLAGS = -lncurses

# Target and objects
TARGET = $(BUILDDIR)/snake
SOURCES_C = $(wildcard $(SRCDIR)/*.c)
SOURCES_ASM = $(wildcard $(SRCDIR)/*.asm)
OBJECTS_C = $(SOURCES_C:$(SRCDIR)/%.c=$(BUILDDIR)/%.o)
OBJECTS_ASM = $(SOURCES_ASM:$(SRCDIR)/%.asm=$(BUILDDIR)/%.o)
OBJECTS = $(OBJECTS_C) $(OBJECTS_ASM)

# Default target
all: $(BUILDDIR) $(TARGET)

# Create build directory
$(BUILDDIR):
	mkdir -p $(BUILDDIR)

# Link target
$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

# Compile C files
$(BUILDDIR)/%.o: $(SRCDIR)/%.c $(INCDIR)/%.h
	$(CC) $(CFLAGS) -c $< -o $@

# Assemble ASM files
$(BUILDDIR)/%.o: $(SRCDIR)/%.asm
	$(AS) -o $@ $<

# Clean build artifacts
clean:
	rm -rf $(BUILDDIR)

# Install (copy executable to root for convenience)
install: $(TARGET)
	cp $(TARGET) ./snake

# Remove installed executable
uninstall:
	rm -f ./snake

# Rebuild everything
rebuild: clean all

.PHONY: all clean install uninstall rebuild
