!mod$ v1 sum:d646c44813ec8049
!need$ 29aa17c4f6b19b22 n order_io
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
contains
pure function positionless(a,b,positions_rank) result(res)
character(15_4,4),intent(in)::a
character(15_4,4),intent(in)::b
character(15_4,4),intent(in)::positions_rank(:)
logical(4)::res
end
subroutine sortempl(surnames,positions,positions_rank)
character(15_4,4),intent(inout)::surnames(:)
character(15_4,4),intent(inout)::positions(:)
character(15_4,4),intent(in)::positions_rank(:)
end
end
