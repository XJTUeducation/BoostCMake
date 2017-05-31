project(boost_system)

set(DIR_SRC ${BOOST_DIR}/libs/system)
add_library(boost_system ${DIR_SRC}/src/error_code.cpp)
target_compile_definitions( boost_system PUBLIC ${BOOST_DEF} )
install(TARGETS boost_system DESTINATION ${INSTALL_LIB_DIRS} ) 

set_target_properties(boost_system PROPERTIES FOLDER "boost/libs")

if(${RUN_BOOST_TEST})
	set( tests_list 
	#error_code_test 
	error_code_user_test
	header_only_test
	#initialization_test_shared
	config_test
	system_error_test
	#throw_test
	#dynamic_link_test
	)
	set(test_targets)

	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-system-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		target_link_libraries(${target} PRIVATE boost_system boost_unit_test_framework )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/system")
		target_compile_definitions(${target} PUBLIC ${BOOST_DEF} )
	endforeach()
	
endif()