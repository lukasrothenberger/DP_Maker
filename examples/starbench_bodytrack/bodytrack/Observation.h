//-------------------------------------------------------------
//      ____                        _      _
//     / ___|____ _   _ ____   ____| |__  | |
//    | |   / ___| | | |  _  \/ ___|  _  \| |
//    | |___| |  | |_| | | | | |___| | | ||_|
//     \____|_|  \_____|_| |_|\____|_| |_|(_) Media benchmarks
//
//    2006, Intel Corporation, licensed under Apache 2.0
//
//  file : main.cpp
//  author : Scott Ettinger - scott.m.ettinger@intel.com
//  description : Top level body tracking code.  Takes image
//                inputs from disk and runs the tracking
//                particle filter.
//
//                Currently contains 3 versions :
//                Single threaded, OpenMP, and Posix threads.
//                They are kept separate for readability.
//
//                Thread methods supported are selected by the
//                #defines USE_OPENMP, USE_THREADS or USE_TBB.
//
//  modified : Chi Ching Chi <chi.c.chi@tu-berlin.de>
//--------------------------------------------------------------

#ifndef OBSERVATION_H
#define OBSERVATION_H

#include "config.h"
#include <vector>
#include <string>
#include <FlexImage.h>
#include "ImageMeasurements.h"
#include "ImageProjection.h"
#include "CameraModel.h"
#include "BodyGeometry.h"
#include "BinaryImage.h"

#define FlexImage8u  FlexImage<Im8u,1>
#define FlexImage32f FlexImage<Im32f,1>

using namespace std;

class Observation{

protected:
	BinaryImage		mFGMap;		// Background segmented images from each camera
	FlexImage8u		mEdgeMap;	// edge processed images from each camera
	int				mCameraID;
	string			mPath;

	//Generate an edge map from the original camera image
	void CreateEdgeMap(const FlexImage8u &src, FlexImage8u &dst);

public:

	Observation(string path, int camera);
	~Observation() {};

	//Load and process new observation data from image files for a given time(frame).  Generates edge maps from the raw image files.
	bool GetObservation(float timeval, BinaryImage &outFGMap, FlexImage8u &outEdgeMap);

};


#endif