//-------------------------------------------------------------
//      ____                        _      _
//     / ___|____ _   _ ____   ____| |__  | |
//    | |   / ___| | | |  _  \/ ___|  _  \| |
//    | |___| |  | |_| | | | | |___| | | ||_|
//     \____|_|  \_____|_| |_|\____|_| |_|(_) Media benchmarks
//
//	  2006, Intel Corporation, licensed under Apache 2.0
//
//  file : main.cpp
//  author : Scott Ettinger - scott.m.ettinger@intel.com
//  description : Top level body tracking code.  Takes image
//				  inputs from disk and runs the tracking
//				  particle filter.
//
//				  Currently contains 3 versions :
//				  Single threaded, OpenMP, and Posix threads.
//				  They are kept separate for readability.
//
//				  Thread methods supported are selected by the
//				  #defines USE_OPENMP, USE_THREADS or USE_TBB.
//
//  modified : Chi Ching Chi <chi.c.chi@tu-berlin.de>
//--------------------------------------------------------------

#include "config.h"
#include <vector>
#include <sstream>
#include <fstream>
#include <iostream>
#include <iomanip>

#include "ParticleFilter.h"
#include "Observation.h"
#include "Projection.h"
#include "system.h"


using namespace std;

//templated conversion from string
template<class T>
bool num(const string s, T &n)
{	istringstream ss(s);
    ss >> n;
    return !ss.fail();
}

//write a given pose to a stream
inline void WritePose(ostream &f, vector<float> &pose)
{	for(int i = 0; i < (int)pose.size(); i++)
        f << pose[i] << " ";
    f << endl;
}

bool ProcessCmdLine(int argc, char **argv, string &path, int &cameras, int &frames, int &particles, int &layers, bool &OutputBMP)
{
    string    usage("Usage : Track (Dataset Path) (# of cameras) (# of frames to process)\n");
    usage += string("              (# of particles) (# of annealing layers) \n");
    usage += string("              [write .bmp output (nonzero = yes)]\n\n");

    string errmsg("Error : invalid argument - ");
    if(argc < 6 || argc > 9)                                                            //check for valid number of arguments
    {	cout << "Error : Invalid number of arguments" << endl << usage << endl;
        return false;
    }
    path = string(argv[1]);                                                             //get dataset path and add backslash if needed
    if(path[path.size() - 1] != DIR_SEPARATOR[0])
        path.push_back(DIR_SEPARATOR[0]);
    if(!num(string(argv[2]), cameras))                                                  //parse each argument
    {	cout << errmsg << "number of cameras" << endl << usage << endl;
        return false;
    }
    if(!num(string(argv[3]), frames))
    {	cout << errmsg << "number of frames" << endl << usage << endl;
        return false;
    }
    if(!num(string(argv[4]), particles))
    {	cout << errmsg << "number of particles" << endl << usage << endl;
        return false;
    }
    if(!num(string(argv[5]), layers))
    {	cout << errmsg << "number of annealing layers" << endl << usage << endl;
        return false;
    }

    if(argc < 6)                                                                        //use default single thread mode if no threading arguments present
        return true;
    int n;
    OutputBMP = true;                                                                   //do not output bmp results by default

    if(!num(string(argv[6]), n)){
        cout << errmsg << "Output BMP flag" << endl << usage << endl;
        return false;
    }
    OutputBMP = (n != 0);

    return true;
}


//Body tracking Single Threaded
int mainSingleThread(string path, int cameras, int frames, int particles, int layers, bool OutputBMP)
{

    struct timeval start, end;
    long mtime, seconds, useconds;
    gettimeofday(&start, NULL);
    cout << endl << "Running Single Threaded" << endl << endl;

    vector<Observation> observ;
    for (int i=0; i<cameras; i++){
        observ.push_back(Observation(path, i));
    }

    // Background segmented images from each camera
    vector<BinaryImage> mFGMaps(cameras);
    // Edge processed images from each camera
    vector<FlexImage8u>  mEdgeMaps(cameras);

    //particle filter instantiated with body tracking model type
    ParticleFilter pf(path, cameras, layers, particles);

    // Image projections of the body on all cameras
    MultiCameraProjectedBody mProjection;

    Projection pj(path, cameras);

    cout << "Using dataset : " << path << endl;
    cout << particles << " particles with " << layers << " annealing layers" << endl << endl;
    ofstream outputFileAvg((path + "poses.txt").c_str());

    vector<float> estimate;                                                         //expected pose from particle distribution
    gettimeofday(&end, NULL);
    seconds  = end.tv_sec  - start.tv_sec;
    useconds = end.tv_usec - start.tv_usec;
    mtime = ((seconds) * 1000 + useconds/1000.0) + 0.5;
    printf("Elapsed time Initialization: %ld milliseconds\n", mtime);
    start = end;
    for(int i = 0; i < frames; i++) {                                               //process each set of frames
        for (int j=0; j<cameras; j++){
            if (!observ[j].GetObservation((float)i, mFGMaps[j], mEdgeMaps[j])){
                cout << "Error loading observation data" << endl;
                return 0;
            }
        }

        cout << "Processing frame " << i << endl;

        pf.Update((float)i, mFGMaps, mEdgeMaps, mProjection, estimate);             //Run particle filter step

        gettimeofday(&end, NULL);
        seconds  = end.tv_sec  - start.tv_sec;
        useconds = end.tv_usec - start.tv_usec;
        mtime = ((seconds) * 1000 + useconds/1000.0) + 0.5;
        printf("Elapsed time Update: %ld milliseconds\n", mtime);
        start = end;

        WritePose(outputFileAvg, estimate);

        if(OutputBMP)
            pj.createBMP(mProjection, i);                                           //save output bitmap file

        gettimeofday(&end, NULL);
        seconds  = end.tv_sec  - start.tv_sec;
        useconds = end.tv_usec - start.tv_usec;
        mtime = ((seconds) * 1000 + useconds/1000.0) + 0.5;
        printf("Elapsed time Output: %ld milliseconds\n", mtime);
        start = end;
    }

    return 1;
}

int main(int argc, char **argv)
{
    string path;
    bool OutputBMP;
    int cameras, frames, particles, layers;                 //process command line parameters to get path, cameras, and frames

    if(!ProcessCmdLine(argc, argv, path, cameras, frames, particles, layers, OutputBMP))
        return 0;

    //single threaded tracking
    mainSingleThread(path, cameras, frames, particles, layers, OutputBMP);

    return 0;
}
