project(boost_container)

set(DIR_SRC ${BOOST_DIR}/libs/container)

add_library(boost_container
	${DIR_SRC}/src/alloc_lib.c
	${DIR_SRC}/src/dlmalloc.cpp
	${DIR_SRC}/src/global_resource.cpp
	${DIR_SRC}/src/monotonic_buffer_resource.cpp
	${DIR_SRC}/src/pool_resource.cpp
	${DIR_SRC}/src/synchronized_pool_resource.cpp
	${DIR_SRC}/src/unsynchronized_pool_resource.cpp
	)

target_compile_definitions( boost_container PUBLIC ${BOOST_DEF} )
install(TARGETS boost_container DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_container PROPERTIES FOLDER "boost/libs")
  
if(${RUN_BOOST_TEST})
	set(tests_list
	#TODO
	)
	set(test_targets)
	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-test-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		target_link_libraries(${target} PRIVATE boost_chrono boost_unit_test_framework )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/container")
	endforeach()
endif()  
