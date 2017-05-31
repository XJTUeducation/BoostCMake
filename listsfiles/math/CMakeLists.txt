project(boost_math)

set(DIR_SRC ${BOOST_DIR}/libs/math)

set(C99_SOURCES
  acosh
  asinh
  atanh
  cbrt
  copysign
  erfc
  erf
  expm1
  fmax
  fmin
  fpclassify
  hypot
  lgamma
  llround
  log1p
  lround
  nextafter
  nexttoward
  round
  tgamma
  trunc
  )

set(TR1_SOURCES
  assoc_laguerre
  assoc_legendre
  beta
  comp_ellint_1
  comp_ellint_2
  comp_ellint_3
  cyl_bessel_i
  cyl_bessel_j
  cyl_bessel_k
  cyl_neumann
  ellint_1
  ellint_2
  ellint_3
  expint
  hermite
  laguerre
  legendre
  riemann_zeta
  sph_bessel
  sph_legendre
  sph_neumann
  )
include_directories(${DIR_SRC}/src/tr1)

function(add_math_library name suffix)
  set(sources)
  foreach(src ${ARGN})
    list(APPEND sources "${DIR_SRC}/src/tr1/${src}${suffix}.cpp")
  endforeach(src)
  add_library(boost_math_${name} ${sources} )
  target_compile_definitions( boost_math_${name} PUBLIC ${BOOST_DEF} )
  set_property(TARGET boost_math_${name} PROPERTY EXPORT_NAME math_${name})
  set_target_properties(boost_math_${name} PROPERTIES FOLDER "boost/libs/math")
endfunction()

add_math_library(tr1  ""  ${TR1_SOURCES})
add_math_library(tr1f "f" ${TR1_SOURCES})
add_math_library(tr1l "l" ${TR1_SOURCES})
add_math_library(c99  ""  ${C99_SOURCES})
add_math_library(c99f "f" ${C99_SOURCES})
add_math_library(c99l "l" ${C99_SOURCES})

install(TARGETS
    boost_math_tr1
    boost_math_tr1f
    boost_math_tr1l
    boost_math_c99
    boost_math_c99f
    boost_math_c99l
   DESTINATION ${INSTALL_LIB_DIRS} ) 

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
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/math")
	endforeach()
endif()  

