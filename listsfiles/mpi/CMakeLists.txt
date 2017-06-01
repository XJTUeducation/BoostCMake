project(boost_mpi)

set(DIR_SRC ${BOOST_DIR}/libs/mpi)

if(MSVC)
  add_definitions(
    /D_SCL_SECURE_NO_WARNINGS
    /wd4251 # class needs to have dll-interface to be used by clients
    /wd4275 # non dll-interface class used as base for dll-interface class
    /wd4996 # 'strdup': The POSIX name for this item is deprecated.
    )
endif()

add_library(boost_mpi 
	${DIR_SRC}/src/broadcast.cpp
	${DIR_SRC}/src/communicator.cpp
	${DIR_SRC}/src/computation_tree.cpp
	${DIR_SRC}/src/content_oarchive.cpp
	${DIR_SRC}/src/environment.cpp
	${DIR_SRC}/src/exception.cpp
	${DIR_SRC}/src/graph_communicator.cpp
	${DIR_SRC}/src/group.cpp
	${DIR_SRC}/src/intercommunicator.cpp
	${DIR_SRC}/src/mpi_datatype_cache.cpp
	${DIR_SRC}/src/mpi_datatype_oarchive.cpp
	${DIR_SRC}/src/packed_iarchive.cpp
	${DIR_SRC}/src/packed_oarchive.cpp
	${DIR_SRC}/src/packed_skeleton_iarchive.cpp
	${DIR_SRC}/src/packed_skeleton_oarchive.cpp
	${DIR_SRC}/src/point_to_point.cpp
	${DIR_SRC}/src/request.cpp
	${DIR_SRC}/src/text_skeleton_oarchive.cpp
	${DIR_SRC}/src/timer.cpp
	)
	
target_include_directories(boost_mpi PUBLIC ${MPI_INCLUDE_PATH} ${BOOST_DIR})
target_compile_definitions( boost_mpi PUBLIC ${BOOST_DEF} )
install(TARGETS boost_mpi DESTINATION ${INSTALL_LIB_DIRS} ) 
target_link_libraries(boost_mpi boost_serialization)
set_target_properties(boost_mpi PROPERTIES FOLDER "boost/libs")

if(${RUN_BOOST_TEST})
	set( tests_list
		#TODO
	)
	set(test_targets)

	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-mpi-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		target_link_libraries(${target} PRIVATE boost_date_time )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/mpi")
		target_compile_definitions(${target} PUBLIC ${BOOST_DEF} )
	endforeach()
	
endif()

