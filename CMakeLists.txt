cmake_minimum_required(VERSION 2.8)
project(Boost)

set(BOOST_DIR ${CMAKE_CURRENT_SOURCE_DIR}/boost_1_64_0) 

if(MSVC)
  if(CMAKE_CL_64)
    set(Boost_ARCH x64)
  elseif((CMAKE_GENERATOR MATCHES "ARM") OR ("${arch_hint}" STREQUAL "ARM") OR (CMAKE_VS_EFFECTIVE_PLATFORMS MATCHES "ARM|arm"))
    # see Modules/CmakeGenericSystem.cmake
    set(Boost_ARCH ARM)
  else()
    set(Boost_ARCH x86)
  endif()
  if(MSVC_VERSION EQUAL 1400)
    set(Boost_RUNTIME vc8)
  elseif(MSVC_VERSION EQUAL 1500)
    set(Boost_RUNTIME vc9)
  elseif(MSVC_VERSION EQUAL 1600)
    set(Boost_RUNTIME vc10)
  elseif(MSVC_VERSION EQUAL 1700)
    set(Boost_RUNTIME vc11)
  elseif(MSVC_VERSION EQUAL 1800)
    set(Boost_RUNTIME vc12)
  elseif(MSVC_VERSION EQUAL 1900)
    set(Boost_RUNTIME vc14)
  elseif(MSVC_VERSION EQUAL 1910)
    set(Boost_RUNTIME vc15)
  endif()
elseif(MINGW)
  message(FATAL_ERROR "TODO make CMakelLists.txt linux/apple/... platform")
endif()

set(BOOST_VERSION 1.64.0)
set(BOOST_DEF BOOST_ALL_NO_LIB)
if(NOT CMAKE_DEBUG_POSTFIX)
  set(CMAKE_DEBUG_POSTFIX d)
endif()

set(RUN_BOOST_TEST OFF)
if(${RUN_BOOST_TEST})
	enable_testing()
endif()
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# setting for install
set(INSTALL_LIB_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/libs/${Boost_ARCH}/${Boost_RUNTIME} )
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

include_directories(${BOOST_DIR})

add_subdirectory(listsfiles/test           )
add_subdirectory(listsfiles/array          )
add_subdirectory(listsfiles/system         )
add_subdirectory(listsfiles/date_time      )
add_subdirectory(listsfiles/thread         )
add_subdirectory(listsfiles/atomic         )
add_subdirectory(listsfiles/chrono         )
add_subdirectory(listsfiles/exception      )
add_subdirectory(listsfiles/container      )
add_subdirectory(listsfiles/math           )
add_subdirectory(listsfiles/filesystem     )
add_subdirectory(listsfiles/random         )
add_subdirectory(listsfiles/regex          )
add_subdirectory(listsfiles/timer          )
add_subdirectory(listsfiles/serialization  )
add_subdirectory(listsfiles/graph          )
add_subdirectory(listsfiles/iostreams      )
add_subdirectory(listsfiles/locale         )
add_subdirectory(listsfiles/program_options)
add_subdirectory(listsfiles/signals        )
add_subdirectory(listsfiles/type_erasure   )
add_subdirectory(listsfiles/wave           )
# add_subdirectory(listsfiles/log            )
# add_subdirectory(listsfiles/context        )
# add_subdirectory(listsfiles/coroutine      )
# add_subdirectory(listsfiles/fiber          )

set(boost_modules_export
	boost_unit_test_framework           
	boost_system         
	boost_date_time      
	boost_thread         
	boost_atomic         
	boost_chrono         
	boost_exception      
	boost_container      
	boost_math_c99
	boost_math_c99f
	boost_math_c99l
	boost_math_tr1
	boost_math_tr1f
	boost_math_tr1l
	boost_filesystem     
	boost_random         
	boost_regex          
	boost_timer          
	boost_serialization  
	boost_wserialization  
	boost_graph          
	boost_iostreams      
	boost_locale         
	boost_program_options
	boost_signals        
	boost_type_erasure   
	boost_wave
	# boost_log       
	# boost_context   
	# boost_coroutine 
	# boost_fiber     
	)
	
find_package(MPI)
if( MPI_FOUND )
	message(STATUS "MPI found in ${MPI_INCLUDE_PATH}" )
	# add_subdirectory(listsfiles/mpi)
	# add_subdirectory(listsfiles/graph_parallel)
	# list(APPEND boost_modules_export boost_mpi boost_graph_parallel)
endif()

find_package(PythonLibs)
if( PythonLibs_FOUND )
	message(STATUS "PythonLibs found in ${PYTHON_INCLUDE_DIRS}" )
	add_subdirectory(listsfiles/python)
	list(APPEND boost_modules_export boost_python)
endif()

export(TARGETS ${boost_modules_export} FILE "${PROJECT_BINARY_DIR}/BoostTargets.cmake")
