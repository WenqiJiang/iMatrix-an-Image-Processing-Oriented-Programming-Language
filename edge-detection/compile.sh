rm *.o
g++ edge_detection.cpp -o output `pkg-config --cflags --libs opencv`