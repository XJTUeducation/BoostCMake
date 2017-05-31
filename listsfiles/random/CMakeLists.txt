project(boost_random)

set(DIR_SRC ${BOOST_DIR}/libs/random)

add_library(boost_random ${DIR_SRC}/src/random_device.cpp )
target_link_libraries(boost_random boost_system)
target_compile_definitions( boost_random  PUBLIC ${BOOST_DEF} )
install(TARGETS boost_random DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_random PROPERTIES FOLDER "boost/libs")
  
if(${RUN_BOOST_TEST})
	set(tests_list
	#TODO
	)
	set(test_targets)
	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-test-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		target_link_libraries(${target} PRIVATE boost_random boost_unit_test_framework )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/random")
	endforeach()
endif()  


