project(boost_chrono)

set(DIR_SRC ${BOOST_DIR}/libs/chrono)

add_library(boost_chrono
  ${DIR_SRC}/src/chrono.cpp
  ${DIR_SRC}/src/thread_clock.cpp
  ${DIR_SRC}/src/process_cpu_clocks.cpp)
  
target_compile_definitions( boost_chrono  PUBLIC ${BOOST_DEF} )
target_link_libraries(boost_chrono PUBLIC boost_exception boost_system )
install(TARGETS boost_chrono DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_chrono PROPERTIES FOLDER "boost/libs")
  
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
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/chrono")
	endforeach()
endif()  
