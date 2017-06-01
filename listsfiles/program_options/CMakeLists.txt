project(boost_program_options)

set(DIR_SRC ${BOOST_DIR}/libs/program_options)

add_library(boost_program_options
  ${DIR_SRC}/src/cmdline.cpp
  ${DIR_SRC}/src/config_file.cpp
  ${DIR_SRC}/src/options_description.cpp
  ${DIR_SRC}/src/parsers.cpp
  ${DIR_SRC}/src/variables_map.cpp
  ${DIR_SRC}/src/value_semantic.cpp
  ${DIR_SRC}/src/positional_options.cpp
  ${DIR_SRC}/src/utf8_codecvt_facet.cpp
  ${DIR_SRC}/src/convert.cpp
  ${DIR_SRC}/src/winmain.cpp
  ${DIR_SRC}/src/split.cpp
  )
  
target_compile_definitions( boost_program_options PUBLIC ${BOOST_DEF} )
install(TARGETS boost_program_options DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_program_options PROPERTIES FOLDER "boost/libs")

if(${RUN_BOOST_TEST})
	set( tests_list
		#TODO
	)
	set(test_targets)

	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-program_options-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		# target_link_libraries(${target} PRIVATE boost_unit_test_framework )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/program_options")
		target_compile_definitions(${target} PUBLIC ${BOOST_DEF} )
	endforeach()
	
endif()

