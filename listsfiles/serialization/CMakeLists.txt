project(boost_serialization)

set(DIR_SRC ${BOOST_DIR}/libs/serialization)

if(MSVC)
  add_definitions(
    /Gy
    /wd4244 # converting 'std::streamsize' in 'size_t'
    /D_CRT_SECURE_NO_WARNINGS
    /D_SCL_SECURE_NO_WARNINGS
    )
endif()

add_library(boost_serialization
  ${DIR_SRC}/src/basic_archive.cpp
  ${DIR_SRC}/src/basic_iarchive.cpp
  ${DIR_SRC}/src/basic_iserializer.cpp
  ${DIR_SRC}/src/basic_oarchive.cpp
  ${DIR_SRC}/src/basic_oserializer.cpp
  ${DIR_SRC}/src/basic_pointer_iserializer.cpp
  ${DIR_SRC}/src/basic_pointer_oserializer.cpp
  ${DIR_SRC}/src/basic_serializer_map.cpp
  ${DIR_SRC}/src/basic_text_iprimitive.cpp
  ${DIR_SRC}/src/basic_text_oprimitive.cpp
  ${DIR_SRC}/src/basic_xml_archive.cpp
  ${DIR_SRC}/src/binary_iarchive.cpp
  ${DIR_SRC}/src/binary_oarchive.cpp
  ${DIR_SRC}/src/extended_type_info.cpp
  ${DIR_SRC}/src/extended_type_info_no_rtti.cpp
  ${DIR_SRC}/src/extended_type_info_typeid.cpp
  ${DIR_SRC}/src/polymorphic_iarchive.cpp
  ${DIR_SRC}/src/polymorphic_oarchive.cpp
  ${DIR_SRC}/src/singleton.cpp
  ${DIR_SRC}/src/stl_port.cpp
  ${DIR_SRC}/src/text_iarchive.cpp
  ${DIR_SRC}/src/text_oarchive.cpp
  ${DIR_SRC}/src/void_cast.cpp
  ${DIR_SRC}/src/archive_exception.cpp
  ${DIR_SRC}/src/xml_grammar.cpp
  ${DIR_SRC}/src/xml_iarchive.cpp
  ${DIR_SRC}/src/xml_oarchive.cpp
  ${DIR_SRC}/src/xml_archive_exception.cpp
  )

target_link_libraries(boost_serialization boost_smart_ptr )
target_compile_definitions( boost_serialization  PUBLIC ${BOOST_DEF} )
install(TARGETS boost_serialization DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_serialization PROPERTIES FOLDER "boost/libs")

add_library(boost_wserialization
  ${DIR_SRC}/src/basic_text_wiprimitive.cpp
  ${DIR_SRC}/src/basic_text_woprimitive.cpp
  ${DIR_SRC}/src/binary_wiarchive.cpp
  ${DIR_SRC}/src/binary_woarchive.cpp
  ${DIR_SRC}/src/text_wiarchive.cpp
  ${DIR_SRC}/src/text_woarchive.cpp
  ${DIR_SRC}/src/utf8_codecvt_facet.cpp
  ${DIR_SRC}/src/xml_wgrammar.cpp
  ${DIR_SRC}/src/xml_wiarchive.cpp
  ${DIR_SRC}/src/xml_woarchive.cpp
  ${DIR_SRC}/src/codecvt_null.cpp
  )
target_link_libraries(boost_wserialization boost_serialization )
target_compile_definitions( boost_wserialization  PUBLIC ${BOOST_DEF} )
install(TARGETS boost_wserialization DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_wserialization PROPERTIES FOLDER "boost/libs")
  
if(${RUN_BOOST_TEST})
	set(tests_list
	#TODO
	)
	set(test_targets)
	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-test-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		target_link_libraries(${target} PRIVATE boost_serialization boost_wserialization )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/serialization")
	endforeach()
endif()  





