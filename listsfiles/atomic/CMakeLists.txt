project(boost_atomic)

set(DIR_SRC ${BOOST_DIR}/libs/atomic)
add_library(boost_atomic ${DIR_SRC}/src/lockpool.cpp)
target_compile_definitions( boost_atomic PUBLIC ${BOOST_DEF} )
install(TARGETS boost_atomic DESTINATION ${INSTALL_LIB_DIRS} ) 

set_target_properties(boost_atomic PROPERTIES FOLDER "boost/libs")

if(${RUN_BOOST_TEST})
	set( tests_list 
		native_api
		fallback_api
		atomicity
		ordering
		lockfree
	)
	set(test_targets)

	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-atomic-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		target_link_libraries(${target} PRIVATE boost_thread boost_atomic boost_system )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/atomic")
		target_compile_definitions(${target} PUBLIC ${BOOST_DEF} )
	endforeach()
	
endif()