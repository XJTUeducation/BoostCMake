project(boost_timer)

set(DIR_SRC ${BOOST_DIR}/libs/timer)

add_library(boost_timer
  ${DIR_SRC}/src/auto_timers_construction.cpp
  ${DIR_SRC}/src/cpu_timer.cpp
	)
target_link_libraries(boost_timer boost_chrono)
target_compile_definitions( boost_timer  PUBLIC ${BOOST_DEF} )
install(TARGETS boost_timer DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_timer PROPERTIES FOLDER "boost/libs")
  
if(${RUN_BOOST_TEST})
	set(tests_list
	cpu_timer_test
	cpu_timer_info
	)
	set(test_targets)
	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-test-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		target_link_libraries(${target} PRIVATE boost_timer )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/timer")
	endforeach()
endif()  

