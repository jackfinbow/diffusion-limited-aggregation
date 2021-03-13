# ====================================================================================== #
#                                   From the Author                                      #
# ====================================================================================== #
# ! The purpose of this Makefile is to build the hllc Godunov SRHDCode contained in src.
# ! This makefile was adapted to work on all systems
# ! GNU/Linux for which the library X11 was installed

# ====================================================================================== #
#                                 Variables of the Makefile                              #
# ====================================================================================== #

# ------------------------------------------
# 1 - Compiler variables to use
# 2 - Compilation options
# 3 - List of header directories
# 4 - List of library directories
# 5 - Libraries to link
# ------------------------------------------
# CXX     = /usr/bin/g++
# CXX     = /usr/local/bin/g++-8 	# FOR OPENMP!
CXX     = clang++

# CXXFLAGS = -Wall -Wextra -fsanitize=address -g
# CXXFLAGS = -Wall -Wextra -g -std=c++0x
# CXXFLAGS = -Wall -Wextra -g -std=c++11 -O0 -fopenmp
# CXXFLAGS = -Wall -Wextra -std=c++11 -O3 		#run this line on distant
CXXFLAGS = -Wall -Wextra -g -O0  	#run this line on local
# CXXFLAGS = -Wall -Wextra -g -std=c++11 -O0 	-fsanitize=address #debug
# CXXFLAGS = -Wall -Wextra -g -std=c++11 -Og -fopenmp
# CXXFLAGS = -Wall -Wextra -g -std=c++11 -O1
# CXXFLAGS = -Wall -Wextra -g -std=c++11 -O2

IFLAGS = -I/usr/local/include -I/usr/include

# LFLAGS = -L /usr/lib 
# LFLAGS = -L/usr/local/lib -fopenmp -lhdf5_hl_cpp -lhdf5_hl -lhdf5_cpp -lhdf5 -lsz -lz -ldl -lm
# LFLAGS = -L/usr/local/lib -fopenmp -lm			#run this line on distant
# LFLAGS = -L/usr/local/lib -fopenmp -lhdf5 -lm 		#run this line on local
LFLAGS = -L/usr/local/lib -lm -framework OpenGL -framework GLUT		#run this line on local
# LFLAGS = -L/usr/local/lib -fopenmp -lhdf5 -lm -lasan	#debug

# ------------------------------------------
# FOR GENERIC MAKEFILE:
# 1 - Binary directory
# 2 - Source directory
# 3 - Executable name
# 4 - Sources names
# 5 - Dependencies names
# ------------------------------------------
BIN = .
SOURCE = .
EXEC = ./run
SOURCES = $(wildcard $(SOURCE)/*.cpp)
OBJECTS = $(SOURCES:.cpp=.o)

# ====================================================================================== #
#                                   Targets of the Makefile                              #
# target_name : dependency                                                               #
# <tabulation> command                                                                   #
# ====================================================================================== #

# ------------------------------------------
# ! - all : Compiles everything
# ! - help : Shows this help
# ! - clean : erases all object files *.o
# !           and all binary executables
# ------------------------------------------
all : $(BIN)/run

test: $(BIN)/hllc_test

help :
	@grep -E "^# !" Makefile | sed -e 's/# !/ /g'

clean:
	rm -f $(EXEC) $(OBJECTS)

# ------------------------------------------
# Executable
# ------------------------------------------
$(EXEC): $(OBJECTS)
	$(CXX) $(OBJECTS) -o $(EXEC) $(IFLAGS) $(LFLAGS)

# ------------------------------------------
# Temorary files (*.o) (IFLAGS should be added here)
# ------------------------------------------
$(SOURCE)/%.o: $(SOURCE)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@ $(IFLAGS) $(LFLAGS)







