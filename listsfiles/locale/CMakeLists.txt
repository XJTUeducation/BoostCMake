project(boost_locale)

find_package(Iconv)
if(ICONV_FOUND)
  option(BOOST_LOCALE_NO_ICONV "Disable iconv library" OFF)
else()
  set(BOOST_LOCALE_NO_ICONV ON)
endif()

find_package(ICU)
if(ICU_FOUND AND ICU_I18N_FOUND)
  option(BOOST_LOCALE_NO_ICU "Disable ICU library/backend" OFF)
else()
  set(BOOST_LOCALE_NO_ICU ON)
endif()

if(APPLE OR "${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
  option(BOOST_LOCALE_NO_POSIX_BACKEND "Disable POSIX backend" OFF)
else()
  set(BOOST_LOCALE_NO_POSIX_BACKEND ON)
endif()

if(NOT CMAKE_CXX_COMPILER_ID STREQUAL "SunPro")
  option(BOOST_LOCALE_NO_STD_BACKEND "Disable STD backend" OFF)
else()
  set(BOOST_LOCALE_NO_STD_BACKEND ON)
endif()

if(WIN32 OR CYGWIN) 
  option(BOOST_LOCALE_NO_WINAPI_BACKEND	"Disable Win32API backend" OFF)
else()
  set(BOOST_LOCALE_NO_WINAPI_BACKEND ON)
endif()

set(DIR_SRC ${BOOST_DIR}/libs/locale)
set(sources 
	${DIR_SRC}/src/encoding/codepage.cpp
	${DIR_SRC}/src/shared/date_time.cpp
	${DIR_SRC}/src/shared/format.cpp
	${DIR_SRC}/src/shared/formatting.cpp
	${DIR_SRC}/src/shared/generator.cpp
	${DIR_SRC}/src/shared/ids.cpp
	${DIR_SRC}/src/shared/localization_backend.cpp
	${DIR_SRC}/src/shared/message.cpp
	${DIR_SRC}/src/shared/mo_lambda.cpp
	${DIR_SRC}/src/util/codecvt_converter.cpp
	${DIR_SRC}/src/util/default_locale.cpp
	${DIR_SRC}/src/util/info.cpp
	${DIR_SRC}/src/util/locale_data.cpp  
	)
#####################################################################################
set(link_libraries)
if(BOOST_LOCALE_NO_ICONV)
  add_definitions(-DBOOST_LOCALE_NO_ICONV)
else()
  include_directories(${ICONV_INCLUDE_DIR})
  add_definitions(-DBOOST_LOCALE_WITH_ICONV)
  list(APPEND link_libraries
    ${ICONV_LIBRARIES}
    )
endif()

if(BOOST_LOCALE_NO_ICU)
  add_definitions(-DBOOST_LOCALE_NO_ICU)
else()
  include_directories(${ICU_INCLUDE_DIRS})
  add_definitions(-DBOOST_LOCALE_WITH_ICU)
  list(APPEND sources
    ${DIR_SRC}/src/icu/boundary.cpp
    ${DIR_SRC}/src/icu/codecvt.cpp
    ${DIR_SRC}/src/icu/collator.cpp
    ${DIR_SRC}/src/icu/conversion.cpp
    ${DIR_SRC}/src/icu/date_time.cpp
    ${DIR_SRC}/src/icu/formatter.cpp
    ${DIR_SRC}/src/icu/icu_backend.cpp
    ${DIR_SRC}/src/icu/numeric.cpp
    ${DIR_SRC}/src/icu/time_zone.cpp
    )
  list(APPEND link_libraries
    ${ICU_LIBRARIES}
    ${ICU_I18N_LIBRARIES}
    boost_thread
    )
endif()

if(BOOST_LOCALE_NO_POSIX_BACKEND)
  add_definitions(-DBOOST_LOCALE_NO_POSIX_BACKEND)
else()
  add_definitions(-DBOOST_LOCALE_WITH_POSIX_BACKEND)
  list(APPEND sources
    ${DIR_SRC}/src/posix/collate.cpp
    ${DIR_SRC}/src/posix/converter.cpp
    ${DIR_SRC}/src/posix/numeric.cpp
    ${DIR_SRC}/src/posix/codecvt.cpp
    ${DIR_SRC}/src/posix/posix_backend.cpp
    )
endif()

if(BOOST_LOCALE_NO_STD_BACKEND)
  add_definitions(-DBOOST_LOCALE_NO_STD_BACKEND)
else()
  add_definitions(-DBOOST_LOCALE_WITH_STD_BACKEND)
  list(APPEND sources
    ${DIR_SRC}/src/std/codecvt.cpp
    ${DIR_SRC}/src/std/collate.cpp
    ${DIR_SRC}/src/std/converter.cpp
    ${DIR_SRC}/src/std/numeric.cpp
    ${DIR_SRC}/src/std/std_backend.cpp
    )
endif()

if(BOOST_LOCALE_NO_WINAPI_BACKEND)
  add_definitions(-DBOOST_LOCALE_NO_WINAPI_BACKEND)
else()
  add_definitions(-DBOOST_LOCALE_WITH_WINAPI_BACKEND)
  list(APPEND sources
    ${DIR_SRC}/src/win32/collate.cpp
    ${DIR_SRC}/src/win32/converter.cpp
    ${DIR_SRC}/src/win32/numeric.cpp
    ${DIR_SRC}/src/win32/win_backend.cpp
    )
endif()

if(NOT BOOST_LOCALE_NO_POSIX_BACKEND OR
   NOT BOOST_LOCALE_NO_STD_BACKEND OR
   NOT BOOST_LOCALE_NO_WINAPI_BACKEND)
  list(APPEND sources
    ${DIR_SRC}/src/util/gregorian.cpp
    )
  list(APPEND link_libraries boost_system)
endif()

if(WIN32 OR CYGWIN)
  if(NOT BOOST_LOCALE_NO_STD_BACKEND OR NOT BOOST_LOCALE_NO_WINAPI_BACKEND)
    list(APPEND sources
      ${DIR_SRC}/src/win32/lcid.cpp
      )
  endif()
endif()
#####################################################################################
add_library(boost_locale ${sources} )
target_compile_definitions( boost_locale PUBLIC ${BOOST_DEF} )
install(TARGETS boost_locale DESTINATION ${INSTALL_LIB_DIRS} ) 
target_link_libraries(boost_locale  ${link_libraries})
set_target_properties(boost_locale PROPERTIES FOLDER "boost/libs")

if(${RUN_BOOST_TEST})
	set( tests_list
		#TODO
	)
	set(test_targets)

	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-locale-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		# target_link_libraries(${target} PRIVATE  )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/locale")
		target_compile_definitions(${target} PUBLIC ${BOOST_DEF} )
	endforeach()
	
endif()

