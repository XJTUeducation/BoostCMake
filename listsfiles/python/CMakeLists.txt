project(boost_python)

set(DIR_SRC ${BOOST_DIR}/libs/python)

if(NOT PYTHON_EXECUTABLE)
  if(NumPy_FIND_QUIETLY)
    find_package(PythonInterp QUIET)
  else()
    find_package(PythonInterp)
    set(__numpy_out 1)
  endif()
endif()

if (PYTHON_EXECUTABLE)
	execute_process( COMMAND "${PYTHON_EXECUTABLE}" -c
	"from __future__ import print_function\ntry: import numpy; print(numpy.get_include(), end='')\nexcept:pass\n"
	OUTPUT_VARIABLE __numpy_path)	  
	message(__numpy_path=${__numpy_path})
elseif(__numpy_out)
  message(STATUS "Python executable not found.")
endif(PYTHON_EXECUTABLE)

find_path(PYTHON_NUMPY_INCLUDE_DIR numpy/arrayobject.h HINTS "${__numpy_path}" "${PYTHON_INCLUDE_PATH}" NO_DEFAULT_PATH)

add_library(boost_python
  ${DIR_SRC}/src/numeric.cpp
  ${DIR_SRC}/src/list.cpp
  ${DIR_SRC}/src/long.cpp
  ${DIR_SRC}/src/dict.cpp
  ${DIR_SRC}/src/tuple.cpp
  ${DIR_SRC}/src/str.cpp
  ${DIR_SRC}/src/slice.cpp
  ${DIR_SRC}/src/converter/from_python.cpp
  ${DIR_SRC}/src/converter/registry.cpp
  ${DIR_SRC}/src/converter/type_id.cpp
  ${DIR_SRC}/src/object/enum.cpp
  ${DIR_SRC}/src/object/class.cpp
  ${DIR_SRC}/src/object/function.cpp
  ${DIR_SRC}/src/object/inheritance.cpp
  ${DIR_SRC}/src/object/life_support.cpp
  ${DIR_SRC}/src/object/pickle_support.cpp
  ${DIR_SRC}/src/errors.cpp
  ${DIR_SRC}/src/module.cpp
  ${DIR_SRC}/src/converter/builtin_converters.cpp
  ${DIR_SRC}/src/converter/arg_to_python_base.cpp
  ${DIR_SRC}/src/object/iterator.cpp
  ${DIR_SRC}/src/object/stl_iterator.cpp
  ${DIR_SRC}/src/object_protocol.cpp
  ${DIR_SRC}/src/object_operators.cpp
  ${DIR_SRC}/src/wrapper.cpp
  ${DIR_SRC}/src/import.cpp
  ${DIR_SRC}/src/exec.cpp
  ${DIR_SRC}/src/object/function_doc_signature.cpp
  ${DIR_SRC}/src/numpy/dtype.cpp
  ${DIR_SRC}/src/numpy/matrix.cpp
  ${DIR_SRC}/src/numpy/ndarray.cpp
  ${DIR_SRC}/src/numpy/numpy.cpp
  ${DIR_SRC}/src/numpy/scalars.cpp
  ${DIR_SRC}/src/numpy/ufunc.cpp
)
target_include_directories(boost_python PUBLIC ${PYTHON_INCLUDE_DIRS} ${PYTHON_NUMPY_INCLUDE_DIR} )
target_compile_definitions( boost_python  PUBLIC ${BOOST_DEF} BOOST_PYTHON_STATIC_LIB BOOST_NUMPY_SOURCE )
target_link_libraries(boost_python PUBLIC
  boost_serialization
  boost_graph
  ${PYTHON_LIBRARIES}
  )
install(TARGETS boost_python DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_python PROPERTIES FOLDER "boost/libs")
  
if(${RUN_BOOST_TEST})
	set(tests_list
	#TODO
	)
	set(test_targets)
	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-python-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		target_link_libraries(${target} PRIVATE boost_python )
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/python")
	endforeach()
endif()  
