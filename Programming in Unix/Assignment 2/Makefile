# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -g -Iinclude  # Enable warnings, debug info, and include path

# Directories
SRCDIR = src
INCDIR = include
DATADIR = data

# Source files
SRCS = $(SRCDIR)/main.c $(SRCDIR)/kmeans.c $(SRCDIR)/input_utils.c $(SRCDIR)/output_utils.c

# Object files
OBJS = main.o kmeans.o input_utils.o output_utils.o

# Target executable
TARGET = kmeans

# Build the main target
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS) -lm  # Link the object files and math library

# Compile main.c into main.o
main.o: $(SRCDIR)/main.c $(INCDIR)/kmeans.h $(INCDIR)/input_utils.h $(INCDIR)/output_utils.h
	$(CC) $(CFLAGS) -c $(SRCDIR)/main.c

# Compile kmeans.c into kmeans.o
kmeans.o: $(SRCDIR)/kmeans.c $(INCDIR)/kmeans.h
	$(CC) $(CFLAGS) -c $(SRCDIR)/kmeans.c

# Compile input_utils.c into input_utils.o
input_utils.o: $(SRCDIR)/input_utils.c $(INCDIR)/input_utils.h $(INCDIR)/kmeans.h
	$(CC) $(CFLAGS) -c $(SRCDIR)/input_utils.c

# Compile output_utils.c into output_utils.o
output_utils.o: $(SRCDIR)/output_utils.c $(INCDIR)/output_utils.h $(INCDIR)/kmeans.h
	$(CC) $(CFLAGS) -c $(SRCDIR)/output_utils.c

# Clean up generated files
clean:
	rm -f *.o $(TARGET) kmeans-output.txt

# Run Valgrind to check for memory leaks
valgrind: $(TARGET)
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(TARGET)

# Run gdb for debugging
gdb: $(TARGET)
	gdb ./$(TARGET)

# Declare 'clean', 'valgrind', and 'gdb' as phony targets
.PHONY: clean valgrind gdb

