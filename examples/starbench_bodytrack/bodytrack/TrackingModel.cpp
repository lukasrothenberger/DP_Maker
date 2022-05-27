//-------------------------------------------------------------
//      ____                        _      _
//     / ___|____ _   _ ____   ____| |__  | |
//    | |   / ___| | | |  _  \/ ___|  _  \| |
//    | |___| |  | |_| | | | | |___| | | ||_|
//     \____|_|  \_____|_| |_|\____|_| |_|(_) Media benchmarks
//
//	  2006, Intel Corporation, licensed under Apache 2.0
//
//  file : TrackingModel.cpp
//  author : Scott Ettinger - scott.m.ettinger@intel.com
//  description : Observation model for kinematic tree body
//				  tracking.
//
//  modified : Chi Ching Chi <chi.c.chi@tu-berlin.de>
//--------------------------------------------------------------

#include "config.h"
#include <sstream>
#include <iomanip>
#include <sys/types.h>
#include <sys/time.h>
#include "TrackingModel.h"
#include "CovarianceMatrix.h"
#include "FlexLib.h"
#include "system.h"

#ifndef uint
#define uint unsigned int
#endif

using namespace std;

//templated conversion to string with field width
template<class T>
inline string str(T n, int width = 0, char pad = '0'){
	stringstream ss;
	ss << setw(width) << setfill(pad) << n;
	return ss.str();
}

// -------------------------------- Initialization ----------------------------

TrackingModel::TrackingModel(const string &path, int cameras, int layers) {
	mPath = path;
	mNCameras = cameras;
	mFGMaps.resize(cameras);
	mEdgeMaps.resize(cameras);
	vector<string> calibFiles(cameras);
	for(int i = 0; i < cameras; i++)
		calibFiles[i] = path + "CALIB" + DIR_SEPARATOR + "Camera" + str(i + 1) + ".cal";

	if(!InitCameras(calibFiles)){
		exit(-1);
	}

	if(!InitGeometry(path + "BodyShapeParameters.txt")){
		exit(-1);
	}
	//initialize body pose angles and translations
	if(!LoadInitialState(path + "InitialPose.txt")){
		exit(-1);
	}
	//initialize pose statistics
	if(!LoadPoseParameters(path + "PoseParameters.txt")){
		exit(-1);
	}
	//generate annealing rates for particle filter using pose parameters
	GenerateStDevMatrices(layers, mPose.Params(), mStdDevs);
}


//Load camera calibration parameters from files
bool TrackingModel::InitCameras(vector<string> &fileNames){
	mCameras.SetCameras((int)fileNames.size());									//set number of cameras
	for(int i = 0; i < (int)fileNames.size(); i++)
		if(!mCameras(i).LoadParams(fileNames[i].c_str()))						//load each camera calibration
			return false;
	return true;
}

//Calculate the likelihood for the current observation
float TrackingModel::LogLikelihood(const vector<float> &v, bool &valid){
	mPose.Set(v);											//set pose angles and translation
	valid = false;
	if(!mPose.Valid(mPose.Params()))						//test for a valid pose (reject impossible body angles)
		return -1e10;
	mBody.ComputeGeometry(mPose, mBody.Parameters());		//compute 3D model geometry from pose (generate conic cylinders and their transforms)
	if(!mBody.Valid())										//test for valid geometry (reject poses with intersecting body parts)
		return -1e10;
	mProjection.ImageProjection(mBody, mCameras);			//compute projected 2D points into each camera image for each body part
	float err = mImageMeasurement.ImageErrorEdge(mEdgeMaps, mProjection);		//compute cylinder edge map term
	err += mImageMeasurement.ImageErrorInside(mFGMaps, mProjection);				//compute silhouette term
	valid = true;
	return -err;
}

MultiCameraProjectedBody& TrackingModel::EstimatedProjection(const vector<float> &estimate){
	//set pose angles and translation
	mPose.Set(estimate);
	//compute 3D model geometry from pose (generate conic cylinders and their transforms)
	mBody.ComputeGeometry(mPose, mBody.Parameters());
	//compute projected 2D points into each camera image for each body part
	mProjection.ImageProjection(mBody, mCameras);

	return mProjection;
}

