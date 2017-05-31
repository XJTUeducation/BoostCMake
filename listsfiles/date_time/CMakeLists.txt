project(boost_date_time)

set(DIR_SRC ${BOOST_DIR}/libs/date_time)

add_library(boost_date_time 
	${DIR_SRC}/src/posix_time/posix_time_types.cpp 
	${DIR_SRC}/src/gregorian/date_generators.cpp 
	${DIR_SRC}/src/gregorian/greg_month.cpp 
	${DIR_SRC}/src/gregorian/greg_names.hpp
	${DIR_SRC}/src/gregorian/greg_weekday.cpp 
	${DIR_SRC}/src/gregorian/gregorian_types.cpp 
	)
	
target_compile_definitions( boost_date_time PUBLIC ${BOOST_DEF} )
install(TARGETS boost_date_time DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_date_time PROPERTIES FOLDER "boost/libs")

if(${RUN_BOOST_TEST})
	set( tests_list
		testconstrained_value
		testgeneric_period
		testgregorian_calendar
		testint_adapter
		testint64_range
		testtime_resolution_traits
		testwrapping_int
	)
	set(test_targets)

	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-date_time-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		target_link_libraries(${target} PRIVATE boost_date_time )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/date_time")
		target_compile_definitions(${target} PUBLIC ${BOOST_DEF} )
	endforeach()
	
endif()

