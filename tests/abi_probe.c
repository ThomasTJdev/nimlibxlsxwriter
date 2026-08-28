#include <stddef.h>
#include <xlsxwriter.h>

#define ABI_SIZEOF(type) \
    size_t abi_sizeof_##type(void) { return sizeof(type); }

#define ABI_OFFSETOF(type, field) \
    size_t abi_offsetof_##type##_##field(void) { return offsetof(type, field); }

ABI_SIZEOF(lxw_datetime)
ABI_SIZEOF(lxw_doc_properties)
ABI_SIZEOF(lxw_workbook_options)
ABI_SIZEOF(lxw_row_col_options)
ABI_SIZEOF(lxw_data_validation)
ABI_SIZEOF(lxw_image_options)
ABI_SIZEOF(lxw_chart_options)
ABI_SIZEOF(lxw_comment_options)
ABI_SIZEOF(lxw_header_footer_options)
ABI_SIZEOF(lxw_rich_string_tuple)
ABI_SIZEOF(lxw_chart_line)
ABI_SIZEOF(lxw_chart_fill)
ABI_SIZEOF(lxw_chart_pattern)
ABI_SIZEOF(lxw_chart_font)
ABI_SIZEOF(lxw_chart_marker)

ABI_OFFSETOF(lxw_doc_properties, created)
ABI_OFFSETOF(lxw_workbook_options, constant_memory)
ABI_OFFSETOF(lxw_workbook_options, tmpdir)
ABI_OFFSETOF(lxw_workbook_options, use_zip64)
ABI_OFFSETOF(lxw_workbook_options, output_buffer)
ABI_OFFSETOF(lxw_workbook_options, output_buffer_size)
ABI_OFFSETOF(lxw_image_options, decorative)
ABI_OFFSETOF(lxw_image_options, url)
ABI_OFFSETOF(lxw_image_options, cell_format)
ABI_OFFSETOF(lxw_chart_options, description)
ABI_OFFSETOF(lxw_chart_options, decorative)
ABI_OFFSETOF(lxw_header_footer_options, image_left)

int abi_lxw_error_parameter_is_empty(void) {
    return LXW_ERROR_PARAMETER_IS_EMPTY;
}

int abi_lxw_error_datetime_validation(void) {
    return LXW_ERROR_DATETIME_VALIDATION;
}

int abi_lxw_error_sheetname_length_exceeded(void) {
    return LXW_ERROR_SHEETNAME_LENGTH_EXCEEDED;
}

int abi_lxw_chart_line_stacked(void) {
    return LXW_CHART_LINE_STACKED;
}

int abi_lxw_chart_pie(void) {
    return LXW_CHART_PIE;
}

int abi_lxw_image_gif(void) {
    return LXW_IMAGE_GIF;
}

int abi_dynamic_array_formula_cell(void) {
    return DYNAMIC_ARRAY_FORMULA_CELL;
}

int abi_blank_cell(void) {
    return BLANK_CELL;
}

int abi_error_cell(void) {
    return ERROR_CELL;
}
