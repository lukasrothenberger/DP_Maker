bin_PROGRAMS = bodytrack
bodytrack_SOURCES = bodytrack.cpp Projection.cpp ParticleFilter.cpp Observation.cpp TrackingModel.cpp
bodytrack_LDADD = ../TrackingBenchmark/libtrackingmodel.la ../FlexImageLib/libflex.la -lm

AM_CPPFLAGS = -I$(srcdir)/../TrackingBenchmark -I$(srcdir)/../FlexImageLib

