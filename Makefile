
CLANG        := clang++
CLANGANALYZE := clang++ --analyze
GPP          := g++
GPPPROF      := g++ -pg

INC    := -I include
CFLAGS := -std=c++11

LIBDIR       := lib
SRCDIR       := src
SRCEXT       := cc
TESTSDIR     := tests
SOURCES      := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
SOURCES_TEST := $(shell find $(TESTSDIR) -type f -name *.$(SRCEXT))

BINDIR     := bin
PROFDIR    := bin/prof
TARGET     := $(BINDIR)/renju
PROFTARGET := $(PROFDIR)/a.out

all:
	@mkdir -p $(BINDIR)
	@$(CLANG) $(CFLAGS) $(INC) -Ofast -o $(TARGET) $(SOURCES)

debug:
	@mkdir -p $(BINDIR)
	@$(CLANG) $(CFLAGS) $(INC) -g -o $(TARGET) $(SOURCES)

analyze:
	@mkdir -p $(BINDIR)
	@$(CLANGANALYZE) $(CFLAGS) $(INC) $(SOURCES)

profile:
	@mkdir -p $(PROFDIR)
	@$(GPPPROF) $(CFLAGS) $(INC) -o $(PROFTARGET) $(SOURCES)

test: build_gtest test_source

build_gtest:
	@mkdir -p $(LIBDIR)

	@# Compile gtest library
	@$(GPP) -pthread -I 3rdparty -o $(LIBDIR)/gtest-all.o -c 3rdparty/gtest/gtest-all.cc
	@ar -r $(LIBDIR)/libgtest.a $(LIBDIR)/gtest-all.o
	@rm $(LIBDIR)/gtest-all.o

test_source:
	@mkdir -p $(BINDIR)

	@# Compile tests
	@$(GPP) -pthread $(CFLAGS) $(INC) -I 3rdparty -D RENJU_PARALLEL_TEST \
	 -o $(TARGET)_test $(SOURCES_TEST) $(SOURCES) lib/libgtest.a

	@# Run tests
	@$(TARGET)_test
