project(boost_signals)

set(DIR_SRC ${BOOST_DIR}/libs/signals)

if(MSVC)
  add_definitions(
    /wd4251 # class needs to have dll-interface to be used by clients
    /wd4275 # 'boost::noncopyable' used as base for dll-interface class 
    )
endif()

add_library(boost_signals
  ${DIR_SRC}/src/trackable.cpp
  ${DIR_SRC}/src/connection.cpp
  ${DIR_SRC}/src/named_slot_map.cpp
  ${DIR_SRC}/src/signal_base.cpp
  ${DIR_SRC}/src/slot.cpp
  )
  
target_compile_definitions( boost_signals PUBLIC ${BOOST_DEF} )
install(TARGETS boost_signals DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_signals PROPERTIES FOLDER "boost/libs")

if(${RUN_BOOST_TEST})
	set( tests_list
		#TODO
	)
	set(test_targets)

	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-signals-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		# target_link_libraries(${target} PRIVATE boost_unit_test_framework )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/signals")
		target_compile_definitions(${target} PUBLIC ${BOOST_DEF} )
	endforeach()
	
endif()

