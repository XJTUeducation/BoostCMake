cmake_minimum_required(VERSION 2.8)
project(Boost)

set(BOOST_DIR ${CMAKE_CURRENT_SOURCE_DIR}/boost_1_64_0) 

if(MSVC)
  if(CMAKE_CL_64)
    set(ARCH_TYPE x64)
  elseif((CMAKE_GENERATOR MATCHES "ARM") OR ("${arch_hint}" STREQUAL "ARM") OR (CMAKE_VS_EFFECTIVE_PLATFORMS MATCHES "ARM|arm"))
    set(ARCH_TYPE ARM)
  else()
    set(ARCH_TYPE x86)
  endif()
  if(MSVC_VERSION EQUAL 1400)
    set(RUNTIME msvc2005)
  elseif(MSVC_VERSION EQUAL 1500)
    set(RUNTIME msvc2008)
  elseif(MSVC_VERSION EQUAL 1600)
    set(RUNTIME msvc2010)
  elseif(MSVC_VERSION EQUAL 1700)
    set(RUNTIME msvc2012)
  elseif(MSVC_VERSION EQUAL 1800)
    set(RUNTIME msvc2013)
  elseif(MSVC_VERSION EQUAL 1900)
    set(RUNTIME msvc2015)
  endif()
  ADD_DEFINITIONS(-D_CRT_SECURE_NO_WARNINGS -D_ALLOW_ITERATOR_DEBUG_LEVEL_MISMATCH)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP") # multi processor compiliation.
  set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)
elseif()
  message(FATAL_ERROR "TODO make CMakelLists.txt linux/apple/... platform")
endif()

set(BOOST_VERSION 1.6.4)
set(BOOST_DEF BOOST_ALL_NO_LIB BOOST_THREAD_BUILD_LIB BOOST_PYTHON_STATIC_LIB )
if(NOT CMAKE_DEBUG_POSTFIX)
  set(CMAKE_DEBUG_POSTFIX d)
endif()

set(RUN_BOOST_TEST OFF)
if(${RUN_BOOST_TEST})
	enable_testing()
endif()
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# setting for install
set(INSTALL_LIB_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/boost_libs/${ARCH_TYPE}/${RUNTIME} )
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

include_directories(${BOOST_DIR})

add_subdirectory(listsfiles/test)
add_subdirectory(listsfiles/array)
add_subdirectory(listsfiles/system)
add_subdirectory(listsfiles/date_time)
add_subdirectory(listsfiles/thread)
add_subdirectory(listsfiles/atomic)
add_subdirectory(listsfiles/chrono)
add_subdirectory(listsfiles/exception)
add_subdirectory(listsfiles/container)
add_subdirectory(listsfiles/math)
add_subdirectory(listsfiles/filesystem)
add_subdirectory(listsfiles/random)
add_subdirectory(listsfiles/regex)
add_subdirectory(listsfiles/timer)
add_subdirectory(listsfiles/serialization)
add_subdirectory(listsfiles/graph)

find_package(MPI)
if( MPI_FOUND )
	message(STATUS "MPI found in ${MPI_INCLUDE_PATH}" )
	# add_subdirectory(listsfiles/mpi)
	# add_subdirectory(listsfiles/graph_parallel)
endif()

add_subdirectory(listsfiles/iostreams)
add_subdirectory(listsfiles/locale)
add_subdirectory(listsfiles/program_options)
add_subdirectory(listsfiles/signals)
add_subdirectory(listsfiles/type_erasure)
add_subdirectory(listsfiles/wave)
# add_subdirectory(listsfiles/python)
# add_subdirectory(listsfiles/coroutine)
# add_subdirectory(listsfiles/context)
# add_subdirectory(listsfiles/fiber)
# add_subdirectory(listsfiles/log)


# export(TARGETS 
	 # boost_test
	 # boost_atomic	 
	 # boost_chrono
	 # boost_container
	 # boost_date_time
	 # boost_exception
	 # boost_filesystem
	 # boost_math_c99
	 # boost_math_c99f
	 # boost_math_c99l
	 # boost_math_tr1
	 # boost_math_tr1f
	 # boost_math_tr1l
	 # boost_random
	 # boost_regex
	 # boost_serialization
	 # boost_smart_ptr
	 # boost_system
	 # boost_thread
	 # boost_timer
	 # boost_wserialization
	 # boost_graph
	 # boost_graph_parallel
	 # FILE "${PROJECT_BINARY_DIR}/BoostTargets.cmake")
