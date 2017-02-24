#include <iostream>
#include <chrono>
#include <thread>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
using namespace std;
using namespace std::this_thread;
using namespace std::chrono;

/*
 * A fake application which takes one integer number as input argument,
 * and calculates the cube number of it (i.e. n^3). Before the result is 
 * returned, it also allocates memory and cpu time to mimic
 * the realistic of a data analysis application.
 *
 * On CentOS 6 (g++ 4.4.7), compile it with:
 *
 *     % g++ fake_app.c -std=c++0x -o fake_app -D_GLIBCXX_USE_NANOSLEEP
 *
 * On CentOS 7 (g++ 4.8.3), compile it with:
 *
 *     % g++ fake_app.c -std=c++11 -o fake_app
 * 
 * Run it with:
 *
 *     % ./fake_app 3
 *
 */
int main( int argc, char* args[] ) {

    char* buffer;
    size_t max_memsize = 2048 * 1024 * 1000; // 2gb

    if ( argc < 2 ) {
        cerr << "usage: fake_app <input> [<duration>]" << endl;
        exit(EXIT_FAILURE);
    } else {

        int duration = 300;

        if ( argc >= 3 ) duration = atol(args[2]);

        // generate a random seconds between args[2] and args[2]+60
        srand(time(NULL));
        int t_run = rand() % 60 + duration;
        cout << "compute for " << t_run << " seconds" << endl;

        system_clock::time_point t_now = system_clock::now();
        system_clock::time_point t_end = t_now + seconds(t_run);

        // (re-)fill up the memory buffer with random character
        // for t_run seconds 
        size_t memsize = 1024*1000;
        while ( t_now < t_end ) {
    
            if ( memsize <= max_memsize/2 ) {
                memsize = memsize * 2;
            }

            buffer = (char*) malloc(memsize);

            cout << "generating random characters ...";
            for (int i=0; i<memsize; i++ ) {
                buffer[i] = rand()%26 + 'a';
            }
            cout << " done, sleep 2 second" << endl;

            // sleep for 3 seconds before next iteration
            sleep_for(seconds(2));
            t_now = system_clock::now();

            free(buffer);
        }

        // calculate the cube number of the input argument
        long rslt = pow( atol(args[1]), 3 );
        cout << "result: " << rslt << endl;
    }

    return 0;
}
