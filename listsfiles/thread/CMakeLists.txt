project(boost_thread)

set(DIR_SRC ${BOOST_DIR}/libs/thread)
if(WIN32)
add_library(boost_thread
    ${DIR_SRC}/src/future.cpp
	${DIR_SRC}/src/tss_null.cpp
	${DIR_SRC}/src/win32/thread.cpp
	${DIR_SRC}/src/win32/tss_dll.cpp
	${DIR_SRC}/src/win32/tss_pe.cpp
	)
else(WIN32)
add_library(boost_thread
    ${DIR_SRC}/src/future.cpp
	${DIR_SRC}/src/tss_null.cpp
	${DIR_SRC}/src/pthread/once.cpp
	${DIR_SRC}/src/pthread/once_atomic.cpp
	${DIR_SRC}/src/pthread/thread.cpp
	)
endif(WIN32)
target_link_libraries(boost_thread boost_date_time)
target_compile_definitions( boost_thread PUBLIC ${BOOST_DEF} )
install(TARGETS boost_thread DESTINATION ${INSTALL_LIB_DIRS} ) 
set_target_properties(boost_thread PROPERTIES FOLDER "boost/libs")

if(${RUN_BOOST_TEST})
	set( tests_list
		# no_implicit_assign_from_lvalue_thread
		# no_implicit_move_from_lvalue_thread
		# test_10340
		# test_10963
		test_10964
		test_11053
		# test_11256
		test_11266
		# test_11499
		test_11611
		test_11796
		# test_11818
		test_12293
		test_2309
		test_2501
		test_2741
		test_3628
		# test_3837
		test_4521
		test_4648
		test_4882
		# test_5351
		# test_5502
		test_5542_1
		test_5542_2
		test_5542_3
		test_5891
		test_6130
		test_6170
		test_6174
		test_7160
		test_7328
		test_7571
		# test_7665
		test_7666
		test_7720
		test_7755
		# test_8455
		test_8508
		# test_8557
		test_8586
		# test_8596
		test_8600
		test_8674
		test_8943
		test_8960
		test_9079_a
		test_9079_b
		test_9192
		# test_9303
		test_9319
		test_9711
		# test_9856
		test_barrier
		test_barrier_size_fct
		test_barrier_void_fct
		test_completion_latch
		test_condition
		test_condition_notify_all
		test_condition_notify_one
		test_condition_timed_wait_times_out
		test_futures
		test_generic_locks
		test_hardware_concurrency
		test_latch
		test_lock_concept
		test_ml
		# test_ml2
		test_move_function
		test_mutex
		test_once
		test_physical_concurrency
		test_scheduled_tp
		test_scheduler
		test_scheduling_adaptor
		test_shared_mutex
		test_shared_mutex_part_2
		test_shared_mutex_timed_locks
		test_shared_mutex_timed_locks_chrono
		test_thread
		test_thread_exit
		test_thread_id
		test_thread_launching
		test_thread_mf
		test_thread_move
		test_thread_move_return
		test_thread_return_local
		test_tss
		test_xtime
	)
	set(test_targets)

	foreach(test IN LISTS tests_list)
		set(target "${PROJECT_NAME}-thread-${test}")
		add_executable(${target} ${DIR_SRC}/test/${test}.cpp)
		target_link_libraries(${target} PRIVATE boost_chrono boost_thread boost_system boost_unit_test_framework)
		list(APPEND test_targets ${target})
		add_test(NAME ${PROJECT_NAME}.${test} COMMAND $<TARGET_FILE:${target}> )
		set_target_properties(${target} PROPERTIES FOLDER "boost/test/thread")
		target_compile_definitions(${target} PUBLIC ${BOOST_DEF} )
	endforeach()
	
endif()

