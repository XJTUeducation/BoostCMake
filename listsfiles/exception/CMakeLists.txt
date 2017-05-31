project(boost_exception)

set(DIR_SRC ${BOOST_DIR}/libs/exception)

add_library(boost_exception ${DIR_SRC}/src/clone_current_exception_non_intrusive.cpp)
target_compile_definitions( boost_exception PUBLIC ${BOOST_DEF} )
install(TARGETS boost_exception DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_exception PROPERTIES FOLDER "boost/libs")
  
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
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/exception")
	endforeach()
endif()  
