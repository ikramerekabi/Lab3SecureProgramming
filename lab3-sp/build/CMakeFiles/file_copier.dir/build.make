# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.26

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/group-2-h/lab3-sp/project_v0

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/group-2-h/lab3-sp/project_v0/build

# Include any dependencies generated for this target.
include CMakeFiles/file_copier.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/file_copier.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/file_copier.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/file_copier.dir/flags.make

CMakeFiles/file_copier.dir/sources/main.c.o: CMakeFiles/file_copier.dir/flags.make
CMakeFiles/file_copier.dir/sources/main.c.o: /home/group-2-h/lab3-sp/project_v0/sources/main.c
CMakeFiles/file_copier.dir/sources/main.c.o: CMakeFiles/file_copier.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/group-2-h/lab3-sp/project_v0/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/file_copier.dir/sources/main.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/file_copier.dir/sources/main.c.o -MF CMakeFiles/file_copier.dir/sources/main.c.o.d -o CMakeFiles/file_copier.dir/sources/main.c.o -c /home/group-2-h/lab3-sp/project_v0/sources/main.c

CMakeFiles/file_copier.dir/sources/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/file_copier.dir/sources/main.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/group-2-h/lab3-sp/project_v0/sources/main.c > CMakeFiles/file_copier.dir/sources/main.c.i

CMakeFiles/file_copier.dir/sources/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/file_copier.dir/sources/main.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/group-2-h/lab3-sp/project_v0/sources/main.c -o CMakeFiles/file_copier.dir/sources/main.c.s

CMakeFiles/file_copier.dir/sources/functions/functions.c.o: CMakeFiles/file_copier.dir/flags.make
CMakeFiles/file_copier.dir/sources/functions/functions.c.o: /home/group-2-h/lab3-sp/project_v0/sources/functions/functions.c
CMakeFiles/file_copier.dir/sources/functions/functions.c.o: CMakeFiles/file_copier.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/group-2-h/lab3-sp/project_v0/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/file_copier.dir/sources/functions/functions.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/file_copier.dir/sources/functions/functions.c.o -MF CMakeFiles/file_copier.dir/sources/functions/functions.c.o.d -o CMakeFiles/file_copier.dir/sources/functions/functions.c.o -c /home/group-2-h/lab3-sp/project_v0/sources/functions/functions.c

CMakeFiles/file_copier.dir/sources/functions/functions.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/file_copier.dir/sources/functions/functions.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/group-2-h/lab3-sp/project_v0/sources/functions/functions.c > CMakeFiles/file_copier.dir/sources/functions/functions.c.i

CMakeFiles/file_copier.dir/sources/functions/functions.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/file_copier.dir/sources/functions/functions.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/group-2-h/lab3-sp/project_v0/sources/functions/functions.c -o CMakeFiles/file_copier.dir/sources/functions/functions.c.s

CMakeFiles/file_copier.dir/sources/functions/hidden_functions/hidden_functions.c.o: CMakeFiles/file_copier.dir/flags.make
CMakeFiles/file_copier.dir/sources/functions/hidden_functions/hidden_functions.c.o: /home/group-2-h/lab3-sp/project_v0/sources/functions/hidden_functions/hidden_functions.c
CMakeFiles/file_copier.dir/sources/functions/hidden_functions/hidden_functions.c.o: CMakeFiles/file_copier.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/group-2-h/lab3-sp/project_v0/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/file_copier.dir/sources/functions/hidden_functions/hidden_functions.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/file_copier.dir/sources/functions/hidden_functions/hidden_functions.c.o -MF CMakeFiles/file_copier.dir/sources/functions/hidden_functions/hidden_functions.c.o.d -o CMakeFiles/file_copier.dir/sources/functions/hidden_functions/hidden_functions.c.o -c /home/group-2-h/lab3-sp/project_v0/sources/functions/hidden_functions/hidden_functions.c

CMakeFiles/file_copier.dir/sources/functions/hidden_functions/hidden_functions.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/file_copier.dir/sources/functions/hidden_functions/hidden_functions.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/group-2-h/lab3-sp/project_v0/sources/functions/hidden_functions/hidden_functions.c > CMakeFiles/file_copier.dir/sources/functions/hidden_functions/hidden_functions.c.i

CMakeFiles/file_copier.dir/sources/functions/hidden_functions/hidden_functions.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/file_copier.dir/sources/functions/hidden_functions/hidden_functions.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/group-2-h/lab3-sp/project_v0/sources/functions/hidden_functions/hidden_functions.c -o CMakeFiles/file_copier.dir/sources/functions/hidden_functions/hidden_functions.c.s

# Object files for target file_copier
file_copier_OBJECTS = \
"CMakeFiles/file_copier.dir/sources/main.c.o" \
"CMakeFiles/file_copier.dir/sources/functions/functions.c.o" \
"CMakeFiles/file_copier.dir/sources/functions/hidden_functions/hidden_functions.c.o"

# External object files for target file_copier
file_copier_EXTERNAL_OBJECTS =

file_copier: CMakeFiles/file_copier.dir/sources/main.c.o
file_copier: CMakeFiles/file_copier.dir/sources/functions/functions.c.o
file_copier: CMakeFiles/file_copier.dir/sources/functions/hidden_functions/hidden_functions.c.o
file_copier: CMakeFiles/file_copier.dir/build.make
file_copier: CMakeFiles/file_copier.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/group-2-h/lab3-sp/project_v0/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking C executable file_copier"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/file_copier.dir/link.txt --verbose=$(VERBOSE)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "-- Adding the required privileges..."
	sudo chown root:root file_copier
	sudo chmod u+s file_copier

# Rule to build all files generated by this target.
CMakeFiles/file_copier.dir/build: file_copier
.PHONY : CMakeFiles/file_copier.dir/build

CMakeFiles/file_copier.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/file_copier.dir/cmake_clean.cmake
.PHONY : CMakeFiles/file_copier.dir/clean

CMakeFiles/file_copier.dir/depend:
	cd /home/group-2-h/lab3-sp/project_v0/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/group-2-h/lab3-sp/project_v0 /home/group-2-h/lab3-sp/project_v0 /home/group-2-h/lab3-sp/project_v0/build /home/group-2-h/lab3-sp/project_v0/build /home/group-2-h/lab3-sp/project_v0/build/CMakeFiles/file_copier.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/file_copier.dir/depend

