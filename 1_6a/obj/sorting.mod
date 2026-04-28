!mod$ v1 sum:f406cb7bb98cae96
!need$ d1f635917d96a344 n order_io
!need$ cf5f96939bb5da86 n environment
module sorting
use environment,only:event_type
use environment,only:notify_type
use environment,only:lock_type
use environment,only:team_type
use environment,only:atomic_int_kind
use environment,only:atomic_logical_kind
use environment,only:compiler_options
use environment,only:compiler_version
use environment,only:selectedint8
use environment,only:selectedint16
use environment,only:selectedint32
use environment,only:selectedint64
use environment,only:selectedint128
use environment,only:safeint8
use environment,only:safeint16
use environment,only:safeint32
use environment,only:safeint64
use environment,only:safeint128
use environment,only:int8
use environment,only:int16
use environment,only:int32
use environment,only:int64
use environment,only:int128
use environment,only:selecteduint8
use environment,only:selecteduint16
use environment,only:selecteduint32
use environment,only:selecteduint64
use environment,only:selecteduint128
use environment,only:safeuint8
use environment,only:safeuint16
use environment,only:safeuint32
use environment,only:safeuint64
use environment,only:safeuint128
use environment,only:uint8
use environment,only:uint16
use environment,only:uint32
use environment,only:uint64
use environment,only:uint128
use environment,only:logical8
use environment,only:logical16
use environment,only:logical32
use environment,only:logical64
use environment,only:selectedreal16
use environment,only:selectedbfloat16
use environment,only:selectedreal32
use environment,only:selectedreal64
use environment,only:selectedreal80
use environment,only:selectedreal64x2
use environment,only:selectedreal128
use environment,only:safereal16
use environment,only:safebfloat16
use environment,only:safereal32
use environment,only:safereal64
use environment,only:safereal80
use environment,only:safereal64x2
use environment,only:safereal128
use environment,only:real16
use environment,only:bfloat16
use environment,only:real32
use environment,only:real64
use environment,only:real80
use environment,only:real64x2
use environment,only:real128
use environment,only:integer_kinds
use environment,only:real_kinds
use environment,only:logical_kinds
use environment,only:character_kinds
use environment,only:current_team
use environment,only:initial_team
use environment,only:parent_team
use environment,only:character_storage_size
use environment,only:file_storage_size
use environment,only:numeric_storage_size
use environment,only:output_unit
use environment,only:input_unit
use environment,only:error_unit
use environment,only:iostat_end
use environment,only:iostat_eor
use environment,only:iostat_inquire_internal_unit
use environment,only:stat_failed_image
use environment,only:stat_locked
use environment,only:stat_locked_other_image
use environment,only:stat_stopped_image
use environment,only:stat_unlocked
use environment,only:stat_unlocked_failed_image
use environment,only:i_
use environment,only:r_
use environment,only:c_
use environment,only:ch_
use environment,only:selected_char_kind
use environment,only:e_
use environment,only:operator(//)
use environment,only:int_plus_string
use environment,only:string_plus_int
use environment,only:handle_io_status
use order_io,only:surname_len
use order_io,only:position_len
use order_io,only:empl_amount
use order_io,only:pos_amount
use order_io,only:employee
use order_io,only:null
use order_io,only:read_employee_list
use order_io,only:read_remaining_employees
use order_io,only:read_positions
use order_io,only:get_position_rank
use order_io,only:output_employee_list
use order_io,only:output_employee
use order_io,only:free_employee_list
contains
pure function position_less(a,b,positions_rank) result(res)
character(15_4,4),intent(in)::a
character(15_4,4),intent(in)::b
character(15_4,4),intent(in)::positions_rank(:)
logical(4)::res
end
recursive subroutine sort_employee_list(employees,positions_rank)
type(employee),intent(inout),pointer::employees
character(15_4,4),intent(in)::positions_rank(:)
end
recursive subroutine odd_phase(current,positions_rank,pos,sorted)
type(employee),pointer::current
character(15_4,4),intent(in)::positions_rank(:)
integer(4),intent(in)::pos
logical(4),intent(inout)::sorted
end
recursive subroutine even_phase(current,positions_rank,pos,sorted)
type(employee),pointer::current
character(15_4,4),intent(in)::positions_rank(:)
integer(4),intent(in)::pos
logical(4),intent(inout)::sorted
end
pure subroutine swap_data(node1,node2)
type(employee),intent(inout)::node1
type(employee),intent(inout)::node2
end
end
