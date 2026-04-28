!mod$ v1 sum:298bb4405b986b0c
!need$ 74f9bf8089cda4c0 n order_io
!need$ 04073e6def6a6fb2 i omp_lib
module sorting
use order_io,only:event_type
use order_io,only:notify_type
use order_io,only:lock_type
use order_io,only:team_type
use order_io,only:atomic_int_kind
use order_io,only:atomic_logical_kind
use order_io,only:compiler_options
use order_io,only:compiler_version
use order_io,only:selectedint8
use order_io,only:selectedint16
use order_io,only:selectedint32
use order_io,only:selectedint64
use order_io,only:selectedint128
use order_io,only:safeint8
use order_io,only:safeint16
use order_io,only:safeint32
use order_io,only:safeint64
use order_io,only:safeint128
use order_io,only:int8
use order_io,only:int16
use order_io,only:int32
use order_io,only:int64
use order_io,only:int128
use order_io,only:selecteduint8
use order_io,only:selecteduint16
use order_io,only:selecteduint32
use order_io,only:selecteduint64
use order_io,only:selecteduint128
use order_io,only:safeuint8
use order_io,only:safeuint16
use order_io,only:safeuint32
use order_io,only:safeuint64
use order_io,only:safeuint128
use order_io,only:uint8
use order_io,only:uint16
use order_io,only:uint32
use order_io,only:uint64
use order_io,only:uint128
use order_io,only:logical8
use order_io,only:logical16
use order_io,only:logical32
use order_io,only:logical64
use order_io,only:selectedreal16
use order_io,only:selectedbfloat16
use order_io,only:selectedreal32
use order_io,only:selectedreal64
use order_io,only:selectedreal80
use order_io,only:selectedreal64x2
use order_io,only:selectedreal128
use order_io,only:safereal16
use order_io,only:safebfloat16
use order_io,only:safereal32
use order_io,only:safereal64
use order_io,only:safereal80
use order_io,only:safereal64x2
use order_io,only:safereal128
use order_io,only:real16
use order_io,only:bfloat16
use order_io,only:real32
use order_io,only:real64
use order_io,only:real80
use order_io,only:real64x2
use order_io,only:real128
use order_io,only:integer_kinds
use order_io,only:real_kinds
use order_io,only:logical_kinds
use order_io,only:character_kinds
use order_io,only:current_team
use order_io,only:initial_team
use order_io,only:parent_team
use order_io,only:character_storage_size
use order_io,only:file_storage_size
use order_io,only:numeric_storage_size
use order_io,only:output_unit
use order_io,only:input_unit
use order_io,only:error_unit
use order_io,only:iostat_end
use order_io,only:iostat_eor
use order_io,only:iostat_inquire_internal_unit
use order_io,only:stat_failed_image
use order_io,only:stat_locked
use order_io,only:stat_locked_other_image
use order_io,only:stat_stopped_image
use order_io,only:stat_unlocked
use order_io,only:stat_unlocked_failed_image
use order_io,only:i_
use order_io,only:r_
use order_io,only:c_
use order_io,only:ch_
use order_io,only:selected_char_kind
use order_io,only:e_
use order_io,only:operator(//)
use order_io,only:int_plus_string
use order_io,only:string_plus_int
use order_io,only:handle_io_status
use order_io,only:surname_len
use order_io,only:position_len
use order_io,only:empl_amount
use order_io,only:pos_amount
use order_io,only:readempl
use order_io,only:readpositions
use order_io,only:writeempl
use,intrinsic::omp_lib,only:omp_integer_kind
use,intrinsic::omp_lib,only:omp_logical_kind
use,intrinsic::omp_lib,only:omp_real_kind
use,intrinsic::omp_lib,only:kmp_double_kind
use,intrinsic::omp_lib,only:omp_lock_kind
use,intrinsic::omp_lib,only:omp_nest_lock_kind
use,intrinsic::omp_lib,only:omp_sched_kind
use,intrinsic::omp_lib,only:omp_proc_bind_kind
use,intrinsic::omp_lib,only:kmp_pointer_kind
use,intrinsic::omp_lib,only:kmp_size_t_kind
use,intrinsic::omp_lib,only:kmp_affinity_mask_kind
use,intrinsic::omp_lib,only:kmp_cancel_kind
use,intrinsic::omp_lib,only:omp_sync_hint_kind
use,intrinsic::omp_lib,only:omp_lock_hint_kind
use,intrinsic::omp_lib,only:omp_control_tool_kind
use,intrinsic::omp_lib,only:omp_control_tool_result_kind
use,intrinsic::omp_lib,only:omp_allocator_handle_kind
use,intrinsic::omp_lib,only:omp_memspace_handle_kind
use,intrinsic::omp_lib,only:omp_alloctrait_key_kind
use,intrinsic::omp_lib,only:omp_alloctrait_val_kind
use,intrinsic::omp_lib,only:omp_interop_kind
use,intrinsic::omp_lib,only:omp_interop_fr_kind
use,intrinsic::omp_lib,only:omp_alloctrait
use,intrinsic::omp_lib,only:omp_pause_resource_kind
use,intrinsic::omp_lib,only:omp_depend_kind
use,intrinsic::omp_lib,only:omp_event_handle_kind
use,intrinsic::omp_lib,only:openmp_version
use,intrinsic::omp_lib,only:kmp_version_major
use,intrinsic::omp_lib,only:kmp_version_minor
use,intrinsic::omp_lib,only:kmp_version_build
use,intrinsic::omp_lib,only:omp_sched_static
use,intrinsic::omp_lib,only:omp_sched_dynamic
use,intrinsic::omp_lib,only:omp_sched_guided
use,intrinsic::omp_lib,only:omp_sched_auto
use,intrinsic::omp_lib,only:omp_sched_monotonic
use,intrinsic::omp_lib,only:omp_proc_bind_false
use,intrinsic::omp_lib,only:omp_proc_bind_true
use,intrinsic::omp_lib,only:omp_proc_bind_master
use,intrinsic::omp_lib,only:omp_proc_bind_close
use,intrinsic::omp_lib,only:omp_proc_bind_spread
use,intrinsic::omp_lib,only:kmp_cancel_parallel
use,intrinsic::omp_lib,only:kmp_cancel_loop
use,intrinsic::omp_lib,only:kmp_cancel_sections
use,intrinsic::omp_lib,only:kmp_cancel_taskgroup
use,intrinsic::omp_lib,only:omp_sync_hint_none
use,intrinsic::omp_lib,only:omp_sync_hint_uncontended
use,intrinsic::omp_lib,only:omp_sync_hint_contended
use,intrinsic::omp_lib,only:omp_sync_hint_nonspeculative
use,intrinsic::omp_lib,only:omp_sync_hint_speculative
use,intrinsic::omp_lib,only:omp_lock_hint_none
use,intrinsic::omp_lib,only:omp_lock_hint_uncontended
use,intrinsic::omp_lib,only:omp_lock_hint_contended
use,intrinsic::omp_lib,only:omp_lock_hint_nonspeculative
use,intrinsic::omp_lib,only:omp_lock_hint_speculative
use,intrinsic::omp_lib,only:kmp_lock_hint_hle
use,intrinsic::omp_lib,only:kmp_lock_hint_rtm
use,intrinsic::omp_lib,only:kmp_lock_hint_adaptive
use,intrinsic::omp_lib,only:omp_control_tool_start
use,intrinsic::omp_lib,only:omp_control_tool_pause
use,intrinsic::omp_lib,only:omp_control_tool_flush
use,intrinsic::omp_lib,only:omp_control_tool_end
use,intrinsic::omp_lib,only:omp_control_tool_notool
use,intrinsic::omp_lib,only:omp_control_tool_nocallback
use,intrinsic::omp_lib,only:omp_control_tool_success
use,intrinsic::omp_lib,only:omp_control_tool_ignored
use,intrinsic::omp_lib,only:omp_atk_sync_hint
use,intrinsic::omp_lib,only:omp_atk_alignment
use,intrinsic::omp_lib,only:omp_atk_access
use,intrinsic::omp_lib,only:omp_atk_pool_size
use,intrinsic::omp_lib,only:omp_atk_fallback
use,intrinsic::omp_lib,only:omp_atk_fb_data
use,intrinsic::omp_lib,only:omp_atk_pinned
use,intrinsic::omp_lib,only:omp_atk_partition
use,intrinsic::omp_lib,only:omp_atk_pin_device
use,intrinsic::omp_lib,only:omp_atk_preferred_device
use,intrinsic::omp_lib,only:omp_atk_device_access
use,intrinsic::omp_lib,only:omp_atk_target_access
use,intrinsic::omp_lib,only:omp_atk_atomic_scope
use,intrinsic::omp_lib,only:omp_atk_part_size
use,intrinsic::omp_lib,only:omp_atv_default
use,intrinsic::omp_lib,only:omp_atv_false
use,intrinsic::omp_lib,only:omp_atv_true
use,intrinsic::omp_lib,only:omp_atv_contended
use,intrinsic::omp_lib,only:omp_atv_uncontended
use,intrinsic::omp_lib,only:omp_atv_serialized
use,intrinsic::omp_lib,only:omp_atv_sequential
use,intrinsic::omp_lib,only:omp_atv_private
use,intrinsic::omp_lib,only:omp_atv_device
use,intrinsic::omp_lib,only:omp_atv_thread
use,intrinsic::omp_lib,only:omp_atv_pteam
use,intrinsic::omp_lib,only:omp_atv_cgroup
use,intrinsic::omp_lib,only:omp_atv_default_mem_fb
use,intrinsic::omp_lib,only:omp_atv_null_fb
use,intrinsic::omp_lib,only:omp_atv_abort_fb
use,intrinsic::omp_lib,only:omp_atv_allocator_fb
use,intrinsic::omp_lib,only:omp_atv_environment
use,intrinsic::omp_lib,only:omp_atv_nearest
use,intrinsic::omp_lib,only:omp_atv_blocked
use,intrinsic::omp_lib,only:omp_atv_interleaved
use,intrinsic::omp_lib,only:omp_atv_all
use,intrinsic::omp_lib,only:omp_atv_single
use,intrinsic::omp_lib,only:omp_atv_multiple
use,intrinsic::omp_lib,only:omp_atv_memspace
use,intrinsic::omp_lib,only:omp_null_allocator
use,intrinsic::omp_lib,only:omp_default_mem_alloc
use,intrinsic::omp_lib,only:omp_large_cap_mem_alloc
use,intrinsic::omp_lib,only:omp_const_mem_alloc
use,intrinsic::omp_lib,only:omp_high_bw_mem_alloc
use,intrinsic::omp_lib,only:omp_low_lat_mem_alloc
use,intrinsic::omp_lib,only:omp_cgroup_mem_alloc
use,intrinsic::omp_lib,only:omp_pteam_mem_alloc
use,intrinsic::omp_lib,only:omp_thread_mem_alloc
use,intrinsic::omp_lib,only:llvm_omp_target_host_mem_alloc
use,intrinsic::omp_lib,only:llvm_omp_target_shared_mem_alloc
use,intrinsic::omp_lib,only:llvm_omp_target_device_mem_alloc
use,intrinsic::omp_lib,only:omp_null_mem_space
use,intrinsic::omp_lib,only:omp_default_mem_space
use,intrinsic::omp_lib,only:omp_large_cap_mem_space
use,intrinsic::omp_lib,only:omp_const_mem_space
use,intrinsic::omp_lib,only:omp_high_bw_mem_space
use,intrinsic::omp_lib,only:omp_low_lat_mem_space
use,intrinsic::omp_lib,only:llvm_omp_target_host_mem_space
use,intrinsic::omp_lib,only:llvm_omp_target_shared_mem_space
use,intrinsic::omp_lib,only:llvm_omp_target_device_mem_space
use,intrinsic::omp_lib,only:omp_pause_resume
use,intrinsic::omp_lib,only:omp_pause_soft
use,intrinsic::omp_lib,only:omp_pause_hard
use,intrinsic::omp_lib,only:omp_pause_stop_tool
use,intrinsic::omp_lib,only:omp_ifr_cuda
use,intrinsic::omp_lib,only:omp_ifr_cuda_driver
use,intrinsic::omp_lib,only:omp_ifr_opencl
use,intrinsic::omp_lib,only:omp_ifr_sycl
use,intrinsic::omp_lib,only:omp_ifr_hip
use,intrinsic::omp_lib,only:omp_ifr_level_zero
use,intrinsic::omp_lib,only:omp_ifr_last
use,intrinsic::omp_lib,only:omp_interop_none
use,intrinsic::omp_lib,only:omp_set_num_threads
use,intrinsic::omp_lib,only:omp_set_dynamic
use,intrinsic::omp_lib,only:omp_set_nested
use,intrinsic::omp_lib,only:omp_get_num_threads
use,intrinsic::omp_lib,only:omp_get_max_threads
use,intrinsic::omp_lib,only:omp_get_thread_num
use,intrinsic::omp_lib,only:omp_get_num_procs
use,intrinsic::omp_lib,only:omp_in_parallel
use,intrinsic::omp_lib,only:omp_in_final
use,intrinsic::omp_lib,only:omp_get_dynamic
use,intrinsic::omp_lib,only:omp_get_nested
use,intrinsic::omp_lib,only:omp_get_thread_limit
use,intrinsic::omp_lib,only:omp_set_max_active_levels
use,intrinsic::omp_lib,only:omp_get_max_active_levels
use,intrinsic::omp_lib,only:omp_get_level
use,intrinsic::omp_lib,only:omp_get_active_level
use,intrinsic::omp_lib,only:omp_get_ancestor_thread_num
use,intrinsic::omp_lib,only:omp_get_team_size
use,intrinsic::omp_lib,only:omp_set_schedule
use,intrinsic::omp_lib,only:omp_get_schedule
use,intrinsic::omp_lib,only:omp_get_proc_bind
use,intrinsic::omp_lib,only:omp_get_num_places
use,intrinsic::omp_lib,only:omp_get_place_num_procs
use,intrinsic::omp_lib,only:omp_get_place_proc_ids
use,intrinsic::omp_lib,only:omp_get_place_num
use,intrinsic::omp_lib,only:omp_get_partition_num_places
use,intrinsic::omp_lib,only:omp_get_partition_place_nums
use,intrinsic::omp_lib,only:omp_get_wtime
use,intrinsic::omp_lib,only:omp_get_wtick
use,intrinsic::omp_lib,only:omp_get_default_device
use,intrinsic::omp_lib,only:omp_set_default_device
use,intrinsic::omp_lib,only:omp_get_num_devices
use,intrinsic::omp_lib,only:omp_get_num_teams
use,intrinsic::omp_lib,only:omp_get_team_num
use,intrinsic::omp_lib,only:omp_get_cancellation
use,intrinsic::omp_lib,only:omp_is_initial_device
use,intrinsic::omp_lib,only:omp_get_initial_device
use,intrinsic::omp_lib,only:omp_get_device_num
use,intrinsic::omp_lib,only:omp_pause_resource
use,intrinsic::omp_lib,only:omp_pause_resource_all
use,intrinsic::omp_lib,only:omp_get_supported_active_levels
use,intrinsic::omp_lib,only:omp_fulfill_event
use,intrinsic::omp_lib,only:omp_init_lock
use,intrinsic::omp_lib,only:omp_destroy_lock
use,intrinsic::omp_lib,only:omp_set_lock
use,intrinsic::omp_lib,only:omp_unset_lock
use,intrinsic::omp_lib,only:omp_test_lock
use,intrinsic::omp_lib,only:omp_init_nest_lock
use,intrinsic::omp_lib,only:omp_destroy_nest_lock
use,intrinsic::omp_lib,only:omp_set_nest_lock
use,intrinsic::omp_lib,only:omp_unset_nest_lock
use,intrinsic::omp_lib,only:omp_test_nest_lock
use,intrinsic::omp_lib,only:omp_get_max_task_priority
use,intrinsic::omp_lib,only:omp_init_lock_with_hint
use,intrinsic::omp_lib,only:omp_init_nest_lock_with_hint
use,intrinsic::omp_lib,only:omp_control_tool
use,intrinsic::omp_lib,only:omp_init_allocator
use,intrinsic::omp_lib,only:omp_destroy_allocator
use,intrinsic::omp_lib,only:omp_set_default_allocator
use,intrinsic::omp_lib,only:omp_get_default_allocator
use,intrinsic::omp_lib,only:omp_set_affinity_format
use,intrinsic::omp_lib,only:omp_get_affinity_format
use,intrinsic::omp_lib,only:omp_display_affinity
use,intrinsic::omp_lib,only:omp_capture_affinity
use,intrinsic::omp_lib,only:omp_set_num_teams
use,intrinsic::omp_lib,only:omp_get_max_teams
use,intrinsic::omp_lib,only:omp_set_teams_thread_limit
use,intrinsic::omp_lib,only:omp_get_teams_thread_limit
use,intrinsic::omp_lib,only:omp_display_env
use,intrinsic::omp_lib,only:omp_target_alloc
use,intrinsic::omp_lib,only:omp_target_free
use,intrinsic::omp_lib,only:omp_target_is_present
use,intrinsic::omp_lib,only:omp_target_memcpy
use,intrinsic::omp_lib,only:omp_target_memcpy_rect
use,intrinsic::omp_lib,only:omp_target_memcpy_async
use,intrinsic::omp_lib,only:omp_target_memcpy_rect_async
use,intrinsic::omp_lib,only:omp_target_memset
use,intrinsic::omp_lib,only:omp_target_memset_async
use,intrinsic::omp_lib,only:omp_target_associate_ptr
use,intrinsic::omp_lib,only:omp_get_mapped_ptr
use,intrinsic::omp_lib,only:omp_target_disassociate_ptr
use,intrinsic::omp_lib,only:omp_target_is_accessible
use,intrinsic::omp_lib,only:omp_alloc
use,intrinsic::omp_lib,only:omp_aligned_alloc
use,intrinsic::omp_lib,only:omp_calloc
use,intrinsic::omp_lib,only:omp_aligned_calloc
use,intrinsic::omp_lib,only:omp_realloc
use,intrinsic::omp_lib,only:omp_free
use,intrinsic::omp_lib,only:omp_in_explicit_task
use,intrinsic::omp_lib,only:kmp_set_stacksize
use,intrinsic::omp_lib,only:kmp_set_stacksize_s
use,intrinsic::omp_lib,only:kmp_set_blocktime
use,intrinsic::omp_lib,only:kmp_set_library_serial
use,intrinsic::omp_lib,only:kmp_set_library_turnaround
use,intrinsic::omp_lib,only:kmp_set_library_throughput
use,intrinsic::omp_lib,only:kmp_set_library
use,intrinsic::omp_lib,only:kmp_set_defaults
use,intrinsic::omp_lib,only:kmp_get_stacksize
use,intrinsic::omp_lib,only:kmp_get_stacksize_s
use,intrinsic::omp_lib,only:kmp_get_blocktime
use,intrinsic::omp_lib,only:kmp_get_library
use,intrinsic::omp_lib,only:kmp_set_disp_num_buffers
use,intrinsic::omp_lib,only:kmp_set_affinity
use,intrinsic::omp_lib,only:kmp_get_affinity
use,intrinsic::omp_lib,only:kmp_get_affinity_max_proc
use,intrinsic::omp_lib,only:kmp_create_affinity_mask
use,intrinsic::omp_lib,only:kmp_destroy_affinity_mask
use,intrinsic::omp_lib,only:kmp_set_affinity_mask_proc
use,intrinsic::omp_lib,only:kmp_unset_affinity_mask_proc
use,intrinsic::omp_lib,only:kmp_get_affinity_mask_proc
use,intrinsic::omp_lib,only:kmp_malloc
use,intrinsic::omp_lib,only:kmp_aligned_malloc
use,intrinsic::omp_lib,only:kmp_calloc
use,intrinsic::omp_lib,only:kmp_realloc
use,intrinsic::omp_lib,only:kmp_free
use,intrinsic::omp_lib,only:kmp_set_warnings_on
use,intrinsic::omp_lib,only:kmp_set_warnings_off
use,intrinsic::omp_lib,only:kmp_get_cancellation_status
contains
pure function positionless(a,b,positions_rank) result(res)
character(1_8,4),intent(in)::a(:)
character(1_8,4),intent(in)::b(:)
character(1_8,4),intent(in)::positions_rank(:,:)
logical(4)::res
end
subroutine sortempl(surnames,positions,positions_rank)
character(1_8,4),intent(inout)::surnames(:,:)
character(1_8,4),intent(inout)::positions(:,:)
character(1_8,4),intent(in)::positions_rank(:,:)
end
end
