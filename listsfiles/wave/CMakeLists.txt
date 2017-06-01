project(boost_wave)

set(DIR_SRC ${BOOST_DIR}/libs/wave)

if(MSVC)
  add_definitions(
    -D_CRT_SECURE_NO_WARNINGS
    -D_SCL_SECURE_NO_WARNINGS
    )
endif()

add_library(boost_wave
  ${DIR_SRC}/src/instantiate_cpp_exprgrammar.cpp
  ${DIR_SRC}/src/instantiate_cpp_grammar.cpp
  ${DIR_SRC}/src/instantiate_cpp_literalgrs.cpp
  ${DIR_SRC}/src/instantiate_defined_grammar.cpp
  ${DIR_SRC}/src/instantiate_predef_macros.cpp
  ${DIR_SRC}/src/instantiate_re2c_lexer.cpp
  ${DIR_SRC}/src/instantiate_re2c_lexer_str.cpp
  ${DIR_SRC}/src/token_ids.cpp
  ${DIR_SRC}/src/wave_config_constant.cpp
  ${DIR_SRC}/src/cpplexer/re2clex/aq.cpp
  ${DIR_SRC}/src/cpplexer/re2clex/cpp_re.cpp
  )
  
target_compile_definitions( boost_wave PUBLIC ${BOOST_DEF} )
target_link_libraries( boost_wave boost_filesystem boost_thread boost_date_time )
install(TARGETS boost_wave DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_wave PROPERTIES FOLDER "boost/libs")

if(${RUN_BOOST_TEST})
	set( tests_list
		#TODO
	)
	set(test_targets)

	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-wave-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		# target_link_libraries(${target} PRIVATE boost_unit_test_framework )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/wave")
		target_compile_definitions(${target} PUBLIC ${BOOST_DEF} )
	endforeach()
	
endif()

