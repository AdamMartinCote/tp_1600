CXX=g++
CFLAGS=-g -m32 -Wall
#CFLAGS=-ggdb3 -m32 -Wall	#debug symbols specific to gdb
LDFLAGS=-lm
RM=rm -f
TARGET=tp4
OBJECTS=tp4.o car.o average_speed.s update_status.s total_distance.s equivalent_acc.s 

.PHONY: clean

.cpp.o:
	$(CXX) $(CFLAGS) -c -o $@ $<

.s.o:
	$(CXX) $(CFLAGS) -c -o $@ $<

all: tp4

$(TARGET): $(OBJECTS)
	$(CXX) $(CFLAGS) $(LDFLAGS) -o $@ $^

clean:
	$(RM) *.o $(TARGET)
