project(boost_iostreams)

set(DIR_SRC ${BOOST_DIR}/libs/iostreams)

find_package(BZip2)
find_package(ZLIB)

set(sources
  ${DIR_SRC}/src/file_descriptor.cpp
  ${DIR_SRC}/src/mapped_file.cpp
  )
  
set(link_3rd_libraries)
if(ZLIB_FOUND)
  include_directories(${ZLIB_INCLUDE_DIRS})
  list(APPEND sources ${DIR_SRC}/src/zlib.cpp ${DIR_SRC}/src/gzip.cpp)
  list(APPEND link_3rd_libraries ${ZLIB_LIBRARIES})
endif(ZLIB_FOUND)

if(BZIP2_FOUND)
  include_directories(${BZIP2_INCLUDE_DIR})
  list(APPEND sources ${DIR_SRC}/src/bzip2.cpp)
  list(APPEND link_3rd_libraries ${BZIP2_LIBRARIES})
endif(BZIP2_FOUND)

add_library(boost_iostreams ${sources} )
install(TARGETS boost_iostreams DESTINATION ${INSTALL_LIB_DIRS} ) 
target_link_libraries(boost_iostreams  ${link_3rd_libraries} )
set_target_properties(boost_iostreams PROPERTIES FOLDER "boost/libs")

if(${RUN_BOOST_TEST})
	set( tests_list
		#TODO
	)
	set(test_targets)

	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-iostreams-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		target_link_libraries(${target} PRIVATE boost_date_time )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/iostreams")
		target_compile_definitions(${target} PUBLIC ${BOOST_DEF} )
	endforeach()
	
endif()
