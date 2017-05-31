project(boost_array)

set(DIR_SRC ${BOOST_DIR}/libs/array)

add_library(boost_array INTERFACE)

if(${RUN_BOOST_TEST})
	set(tests_list
		array0
		array1
		array2
		array3
		array4
		array5
		array6
		array7
		array_constexpr
#		array_getfail1
#		array_getfail2
		array_hash
	)
	set(test_targets)
	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-test-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		target_link_libraries(${target} PRIVATE boost_array boost_unit_test_framework )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/array")
	endforeach()
	# add_custom_target(${PROJECT_NAME}-all-array
	# COMMAND ${CMAKE_CTEST_COMMAND} -R "^${PROJECT_NAME}" -C ${CMAKE_CONFIGURATION_TYPES} ${CMAKE_BINARY_DIR}
	# DEPENDS ${test_targets} )
	# set_target_properties(${PROJECT_NAME}-all-array PROPERTIES FOLDER "boost/test/array")
endif()  

