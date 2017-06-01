project(boost_graph_parallel)

set(DIR_SRC ${BOOST_DIR}/libs/graph_parallel)

add_library(boost_graph_parallel 
	${DIR_SRC}/src/mpi_process_group.cpp
	${DIR_SRC}/src/tag_allocator.cpp
	)
	
target_compile_definitions( boost_graph_parallel PUBLIC ${BOOST_DEF} )
install(TARGETS boost_graph_parallel DESTINATION ${INSTALL_LIB_DIRS} ) 
target_link_libraries(boost_graph_parallel boost_mpi)
set_target_properties(boost_graph_parallel PROPERTIES FOLDER "boost/libs")

if(${RUN_BOOST_TEST})
	set( tests_list
		#TODO
	)
	set(test_targets)

	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-graph_parallel-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		target_link_libraries(${target} PRIVATE boost_date_time )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/graph_parallel")
		target_compile_definitions(${target} PUBLIC ${BOOST_DEF} )
	endforeach()
	
endif()

