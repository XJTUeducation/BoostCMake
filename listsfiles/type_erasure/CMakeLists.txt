project(boost_type_erasure)

set(DIR_SRC ${BOOST_DIR}/libs/type_erasure)

if(MSVC)
  add_definitions(
    /wd4251 # class needs to have dll-interface to be used by clients
    /wd4275 # 'boost::noncopyable' used as base for dll-interface class 
    )
endif()

add_library(boost_type_erasure
  ${DIR_SRC}/src/dynamic_binding.cpp
  )
  
target_compile_definitions( boost_type_erasure PUBLIC ${BOOST_DEF} )
target_link_libraries( boost_type_erasure boost_thread boost_system )
install(TARGETS boost_type_erasure DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_type_erasure PROPERTIES FOLDER "boost/libs")

if(${RUN_BOOST_TEST})
	set( tests_list
		#TODO
	)
	set(test_targets)

	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-type_erasure-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		# target_link_libraries(${target} PRIVATE boost_unit_test_framework )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/type_erasure")
		target_compile_definitions(${target} PUBLIC ${BOOST_DEF} )
	endforeach()
	
endif()

