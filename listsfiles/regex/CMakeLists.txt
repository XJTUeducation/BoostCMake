project(boost_regex)

set(DIR_SRC ${BOOST_DIR}/libs/regex)

add_library(boost_regex
    ${DIR_SRC}/src/c_regex_traits.cpp
	${DIR_SRC}/src/cpp_regex_traits.cpp
	${DIR_SRC}/src/cregex.cpp
	${DIR_SRC}/src/fileiter.cpp
	${DIR_SRC}/src/icu.cpp
	${DIR_SRC}/src/instances.cpp
	${DIR_SRC}/src/posix_api.cpp
	${DIR_SRC}/src/regex.cpp
	${DIR_SRC}/src/regex_debug.cpp
	${DIR_SRC}/src/regex_raw_buffer.cpp
	${DIR_SRC}/src/regex_traits_defaults.cpp
	${DIR_SRC}/src/static_mutex.cpp
	${DIR_SRC}/src/usinstances.cpp
	${DIR_SRC}/src/w32_regex_traits.cpp
	${DIR_SRC}/src/wc_regex_traits.cpp
	${DIR_SRC}/src/wide_posix_api.cpp
	${DIR_SRC}/src/winstances.cpp
	)
target_compile_definitions( boost_regex  PUBLIC ${BOOST_DEF} )
install(TARGETS boost_regex DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_regex PROPERTIES FOLDER "boost/libs")
  
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
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/regex")
	endforeach()
endif()  





