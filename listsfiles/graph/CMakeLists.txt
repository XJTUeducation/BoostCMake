project(boost_graph)

set(DIR_SRC ${BOOST_DIR}/libs/graph)

add_library(boost_graph 
	${DIR_SRC}/src/read_graphviz_new.cpp
	${DIR_SRC}/src/graphml.cpp
	)
	
target_compile_definitions( boost_graph PUBLIC ${BOOST_DEF} )
install(TARGETS boost_graph DESTINATION ${INSTALL_LIB_DIRS} ) 
target_link_libraries(boost_graph boost_regex)
set_target_properties(boost_graph PROPERTIES FOLDER "boost/libs")

if(${RUN_BOOST_TEST})
	set( tests_list
		#TODO
	)
	set(test_targets)

	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-graph-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		target_link_libraries(${target} PRIVATE boost_date_time )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/graph")
		target_compile_definitions(${target} PUBLIC ${BOOST_DEF} )
	endforeach()
	
endif()

