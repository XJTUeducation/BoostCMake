project(boost_filesystem)

set(DIR_SRC ${BOOST_DIR}/libs/filesystem)

add_library(boost_filesystem 
	${DIR_SRC}/src/codecvt_error_category.cpp
	${DIR_SRC}/src/operations.cpp
	${DIR_SRC}/src/path.cpp
	${DIR_SRC}/src/path_traits.cpp
	${DIR_SRC}/src/portability.cpp
	${DIR_SRC}/src/unique_path.cpp
	${DIR_SRC}/src/utf8_codecvt_facet.cpp
	${DIR_SRC}/src/windows_file_codecvt.cpp
)

target_compile_definitions( boost_filesystem PUBLIC ${BOOST_DEF} )
target_link_libraries(boost_filesystem boost_system)
install(TARGETS boost_filesystem DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_filesystem PROPERTIES FOLDER "boost/libs")
  
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
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/filesystem")
	endforeach()
endif()  


target_compile_definitions( boost_filesystem  PUBLIC ${BOOST_DEF} )

install(TARGETS boost_filesystem DESTINATION ${INSTALL_LIB_DIRS} ) 
