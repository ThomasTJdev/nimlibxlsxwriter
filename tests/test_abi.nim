{.compile: "abi_probe.c".}

import std/[strutils, unittest]
import nimlibxlsxwriter

proc abi_sizeof_lxw_datetime(): csize_t {.importc.}
proc abi_sizeof_lxw_doc_properties(): csize_t {.importc.}
proc abi_sizeof_lxw_workbook_options(): csize_t {.importc.}
proc abi_sizeof_lxw_row_col_options(): csize_t {.importc.}
proc abi_sizeof_lxw_data_validation(): csize_t {.importc.}
proc abi_sizeof_lxw_image_options(): csize_t {.importc.}
proc abi_sizeof_lxw_chart_options(): csize_t {.importc.}
proc abi_sizeof_lxw_comment_options(): csize_t {.importc.}
proc abi_sizeof_lxw_header_footer_options(): csize_t {.importc.}
proc abi_sizeof_lxw_rich_string_tuple(): csize_t {.importc.}
proc abi_sizeof_lxw_chart_line(): csize_t {.importc.}
proc abi_sizeof_lxw_chart_fill(): csize_t {.importc.}
proc abi_sizeof_lxw_chart_pattern(): csize_t {.importc.}
proc abi_sizeof_lxw_chart_font(): csize_t {.importc.}
proc abi_sizeof_lxw_chart_marker(): csize_t {.importc.}

proc abi_offsetof_lxw_doc_properties_created(): csize_t {.importc.}
proc abi_offsetof_lxw_workbook_options_constant_memory(): csize_t {.importc.}
proc abi_offsetof_lxw_workbook_options_tmpdir(): csize_t {.importc.}
proc abi_offsetof_lxw_workbook_options_use_zip64(): csize_t {.importc.}
proc abi_offsetof_lxw_workbook_options_output_buffer(): csize_t {.importc.}
proc abi_offsetof_lxw_workbook_options_output_buffer_size(): csize_t {.importc.}
proc abi_offsetof_lxw_image_options_decorative(): csize_t {.importc.}
proc abi_offsetof_lxw_image_options_url(): csize_t {.importc.}
proc abi_offsetof_lxw_image_options_cell_format(): csize_t {.importc.}
proc abi_offsetof_lxw_chart_options_description(): csize_t {.importc.}
proc abi_offsetof_lxw_chart_options_decorative(): csize_t {.importc.}
proc abi_offsetof_lxw_header_footer_options_image_left(): csize_t {.importc.}

proc abi_lxw_error_parameter_is_empty(): cint {.importc.}
proc abi_lxw_error_datetime_validation(): cint {.importc.}
proc abi_lxw_error_sheetname_length_exceeded(): cint {.importc.}
proc abi_lxw_chart_line_stacked(): cint {.importc.}
proc abi_lxw_chart_pie(): cint {.importc.}
proc abi_lxw_image_gif(): cint {.importc.}
proc abi_dynamic_array_formula_cell(): cint {.importc.}
proc abi_blank_cell(): cint {.importc.}
proc abi_error_cell(): cint {.importc.}

template checkSize(T: typedesc, cSize: untyped) =
  check sizeof(T).csize_t == cSize()

template checkOffset(T: typedesc, field: untyped, cOffset: untyped) =
  check offsetOf(T, field).csize_t == cOffset()

suite "libxlsxwriter 1.2.4 ABI":
  test "caller-allocated structures have the C size":
    checkSize(lxw_datetime, abi_sizeof_lxw_datetime)
    checkSize(lxw_doc_properties, abi_sizeof_lxw_doc_properties)
    checkSize(lxw_workbook_options, abi_sizeof_lxw_workbook_options)
    checkSize(lxw_row_col_options, abi_sizeof_lxw_row_col_options)
    checkSize(lxw_data_validation, abi_sizeof_lxw_data_validation)
    checkSize(lxw_image_options, abi_sizeof_lxw_image_options)
    checkSize(lxw_chart_options, abi_sizeof_lxw_chart_options)
    checkSize(lxw_comment_options, abi_sizeof_lxw_comment_options)
    checkSize(lxw_header_footer_options, abi_sizeof_lxw_header_footer_options)
    checkSize(lxw_rich_string_tuple, abi_sizeof_lxw_rich_string_tuple)
    checkSize(lxw_chart_line, abi_sizeof_lxw_chart_line)
    checkSize(lxw_chart_fill, abi_sizeof_lxw_chart_fill)
    checkSize(lxw_chart_pattern, abi_sizeof_lxw_chart_pattern)
    checkSize(lxw_chart_font, abi_sizeof_lxw_chart_font)
    checkSize(lxw_chart_marker, abi_sizeof_lxw_chart_marker)

  test "new and alignment-sensitive fields have the C offset":
    checkOffset(lxw_doc_properties, created, abi_offsetof_lxw_doc_properties_created)
    checkOffset(lxw_workbook_options, constant_memory,
      abi_offsetof_lxw_workbook_options_constant_memory)
    checkOffset(lxw_workbook_options, tmpdir,
      abi_offsetof_lxw_workbook_options_tmpdir)
    checkOffset(lxw_workbook_options, use_zip64,
      abi_offsetof_lxw_workbook_options_use_zip64)
    checkOffset(lxw_workbook_options, output_buffer,
      abi_offsetof_lxw_workbook_options_output_buffer)
    checkOffset(lxw_workbook_options, output_buffer_size,
      abi_offsetof_lxw_workbook_options_output_buffer_size)
    checkOffset(lxw_image_options, decorative,
      abi_offsetof_lxw_image_options_decorative)
    checkOffset(lxw_image_options, url, abi_offsetof_lxw_image_options_url)
    checkOffset(lxw_image_options, cell_format,
      abi_offsetof_lxw_image_options_cell_format)
    checkOffset(lxw_chart_options, description,
      abi_offsetof_lxw_chart_options_description)
    checkOffset(lxw_chart_options, decorative,
      abi_offsetof_lxw_chart_options_decorative)
    checkOffset(lxw_header_footer_options, image_left,
      abi_offsetof_lxw_header_footer_options_image_left)

  test "enum values match the C API":
    check LXW_ERROR_PARAMETER_IS_EMPTY.cint == abi_lxw_error_parameter_is_empty()
    check LXW_ERROR_DATETIME_VALIDATION.cint == abi_lxw_error_datetime_validation()
    check LXW_ERROR_SHEETNAME_LENGTH_EXCEEDED.cint ==
      abi_lxw_error_sheetname_length_exceeded()
    check LXW_CHART_LINE_STACKED.cint == abi_lxw_chart_line_stacked()
    check LXW_CHART_PIE.cint == abi_lxw_chart_pie()
    check LXW_IMAGE_GIF.cint == abi_lxw_image_gif()
    check DYNAMIC_ARRAY_FORMULA_CELL.cint == abi_dynamic_array_formula_cell()
    check BLANK_CELL.cint == abi_blank_cell()
    check ERROR_CELL.cint == abi_error_cell()

  test "error strings use the current enum positions":
    check ($lxw_strerror(LXW_ERROR_DATETIME_VALIDATION)).contains("Datetime")
    check ($lxw_strerror(LXW_ERROR_SHEETNAME_LENGTH_EXCEEDED)).contains("Worksheet name")
