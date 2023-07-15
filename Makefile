# List of source files
SOURCES := tester.cpp readWriteToFile.cpp Huffman.cpp LZW.cpp

# List of object files to be built
OBJECTS := $(SOURCES:.cpp=.o)

# Compiler and compiler flags
CXX := g++
CXXFLAGS := -Wall -Wextra -std=c++11

# List of directories to clean
DIRECTORIES_TO_CLEAN := out/compressedHuff out/decompressedHuff out/compressedLZW/ out/decompressedLZW/

# Files to keep in the directories
FILES_TO_KEEP := dummy.txt


# The default target is "build_final"
build: build_final

# "build_final" depends on the object files, so it will build them first
build_final: $(OBJECTS)
	$(CXX) $(CXXFLAGS) $(OBJECTS) -o tester

# Pattern rule to build object files
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Target to run tests using "script.sh"
run_tests: build_final
	./script.sh

# Clean up object files and the final executable
clean:
	rm -f $(OBJECTS) tester
	for dir in $(DIRECTORIES_TO_CLEAN); do \
		find $$dir -type f ! -name '$(FILES_TO_KEEP)' -exec rm -f {} +; \
	done