if !exists("g:os")
    if has("win64") || has("win32") || has("win32unix") || has("win16")
        " nothing ...
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

set nocompatible
filetype off

nnoremap <Space> <Nop>
let mapleader="\<Space>"

try
    source ~/.config/vim-plug/plug.vim

    call plug#begin('~/.config/vim-plug/plugged')

    Plug 'tpope/vim-fugitive'
    nmap <leader>nd <C-W><C-O>:grep "<<<<"<CR>:Gvdiff<CR><CR>

    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-eunuch'

    Plug 'chrisbra/improvedft'

    Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

    Plug 'yssl/QFEnter'
    let g:qfenter_keymap = {}
    let g:qfenter_keymap.cnext_keep = ['<C-n>']
    let g:qfenter_keymap.cprev_keep = ['<C-p>']
    let g:qfenter_keymap.vopen = ['<C-v>']
    let g:qfenter_keymap.hopen = ['<C-s>']
    let g:qfenter_keymap.topen = ['<C-t>']

    Plug 'Shougo/vimproc.vim'

    Plug 'SimplyKnownAsG/vim-code-dark'

    Plug 'prabirshrestha/async.vim'

    " performance issues
    let g:lsp_highlights_enabled = 0
    let g:lsp_textprop_enabled = 0
    let g:lsp_fold_enabled = 0
    set completeopt-=preview
    Plug 'prabirshrestha/vim-lsp'

    " custom text formatting options
    let my_typescript_format_options = {
        \   'indentStyle': 'Smart',
        \   'insertSpaceAfterCommaDelimiter': v:true,
        \   'insertSpaceAfterSemicolonInForStatements': v:true,
        \   'insertSpaceBeforeAndAfterBinaryOperators': v:true,
        \   'insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces': v:false,
        \   'insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces': v:false,
        \   'insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces': v:false,
        \ }

    let my_java_format_options = {
        \   "org.eclipse.jdt.core.compiler.codegen.inlineJsrBytecode": "enabled",
        \   "org.eclipse.jdt.core.compiler.codegen.targetPlatform": "1.7",
        \   "org.eclipse.jdt.core.compiler.problem.assertIdentifier": "error",
        \   "org.eclipse.jdt.core.compiler.problem.enumIdentifier": "error",
        \   "org.eclipse.jdt.core.formatter.align_type_members_on_columns": v:false,
        \   "org.eclipse.jdt.core.formatter.alignment_for_arguments_in_allocation_expression": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_arguments_in_annotation": 0,
        \   "org.eclipse.jdt.core.formatter.alignment_for_arguments_in_enum_constant": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_arguments_in_explicit_constructor_call": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_arguments_in_method_invocation": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_arguments_in_qualified_allocation_expression": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_assignment": 0,
        \   "org.eclipse.jdt.core.formatter.alignment_for_binary_expression": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_compact_if": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_conditional_expression": 80,
        \   "org.eclipse.jdt.core.formatter.alignment_for_enum_constants": 0,
        \   "org.eclipse.jdt.core.formatter.alignment_for_expressions_in_array_initializer": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_method_declaration": 0,
        \   "org.eclipse.jdt.core.formatter.alignment_for_multiple_fields": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_parameters_in_constructor_declaration": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_parameters_in_method_declaration": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_resources_in_try": 80,
        \   "org.eclipse.jdt.core.formatter.alignment_for_selector_in_method_invocation": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_superclass_in_type_declaration": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_superinterfaces_in_enum_declaration": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_superinterfaces_in_type_declaration": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_throws_clause_in_constructor_declaration": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_throws_clause_in_method_declaration": 16,
        \   "org.eclipse.jdt.core.formatter.alignment_for_union_type_in_multicatch": 16,
        \   "org.eclipse.jdt.core.formatter.blank_lines_after_imports": 1,
        \   "org.eclipse.jdt.core.formatter.blank_lines_after_package": 1,
        \   "org.eclipse.jdt.core.formatter.blank_lines_before_field": 0,
        \   "org.eclipse.jdt.core.formatter.blank_lines_before_first_class_body_declaration": 0,
        \   "org.eclipse.jdt.core.formatter.blank_lines_before_imports": 1,
        \   "org.eclipse.jdt.core.formatter.blank_lines_before_member_type": 1,
        \   "org.eclipse.jdt.core.formatter.blank_lines_before_method": 1,
        \   "org.eclipse.jdt.core.formatter.blank_lines_before_new_chunk": 1,
        \   "org.eclipse.jdt.core.formatter.blank_lines_before_package": 0,
        \   "org.eclipse.jdt.core.formatter.blank_lines_between_import_groups": 1,
        \   "org.eclipse.jdt.core.formatter.blank_lines_between_type_declarations": 1,
        \   "org.eclipse.jdt.core.formatter.brace_position_for_annotation_type_declaration": "end_of_line",
        \   "org.eclipse.jdt.core.formatter.brace_position_for_anonymous_type_declaration": "end_of_line",
        \   "org.eclipse.jdt.core.formatter.brace_position_for_array_initializer": "end_of_line",
        \   "org.eclipse.jdt.core.formatter.brace_position_for_block": "end_of_line",
        \   "org.eclipse.jdt.core.formatter.brace_position_for_block_in_case": "end_of_line",
        \   "org.eclipse.jdt.core.formatter.brace_position_for_constructor_declaration": "end_of_line",
        \   "org.eclipse.jdt.core.formatter.brace_position_for_enum_constant": "end_of_line",
        \   "org.eclipse.jdt.core.formatter.brace_position_for_enum_declaration": "end_of_line",
        \   "org.eclipse.jdt.core.formatter.brace_position_for_method_declaration": "end_of_line",
        \   "org.eclipse.jdt.core.formatter.brace_position_for_switch": "end_of_line",
        \   "org.eclipse.jdt.core.formatter.brace_position_for_type_declaration": "end_of_line",
        \   "org.eclipse.jdt.core.formatter.comment.clear_blank_lines_in_block_comment": v:false,
        \   "org.eclipse.jdt.core.formatter.comment.clear_blank_lines_in_javadoc_comment": v:false,
        \   "org.eclipse.jdt.core.formatter.comment.format_block_comments": v:true,
        \   "org.eclipse.jdt.core.formatter.comment.format_header": v:false,
        \   "org.eclipse.jdt.core.formatter.comment.format_html": v:true,
        \   "org.eclipse.jdt.core.formatter.comment.format_javadoc_comments": v:true,
        \   "org.eclipse.jdt.core.formatter.comment.format_line_comments": v:true,
        \   "org.eclipse.jdt.core.formatter.comment.format_source_code": v:true,
        \   "org.eclipse.jdt.core.formatter.comment.indent_parameter_description": v:true,
        \   "org.eclipse.jdt.core.formatter.comment.indent_root_tags": v:true,
        \   "org.eclipse.jdt.core.formatter.comment.insert_new_line_before_root_tags": "insert",
        \   "org.eclipse.jdt.core.formatter.comment.insert_new_line_for_parameter": "do not insert",
        \   "org.eclipse.jdt.core.formatter.comment.line_length": 120,
        \   "org.eclipse.jdt.core.formatter.comment.new_lines_at_block_boundaries": v:true,
        \   "org.eclipse.jdt.core.formatter.comment.new_lines_at_javadoc_boundaries": v:true,
        \   "org.eclipse.jdt.core.formatter.comment.preserve_white_space_between_code_and_line_comments": v:false,
        \   "org.eclipse.jdt.core.formatter.compact_else_if": v:true,
        \   "org.eclipse.jdt.core.formatter.continuation_indentation": 2,
        \   "org.eclipse.jdt.core.formatter.continuation_indentation_for_array_initializer": 2,
        \   "org.eclipse.jdt.core.formatter.disabling_tag": "@formatter:off",
        \   "org.eclipse.jdt.core.formatter.enabling_tag": "@formatter:on",
        \   "org.eclipse.jdt.core.formatter.format_guardian_clause_on_one_line": v:false,
        \   "org.eclipse.jdt.core.formatter.format_line_comment_starting_on_first_column": v:true,
        \   "org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_annotation_declaration_header": v:true,
        \   "org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_enum_constant_header": v:true,
        \   "org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_enum_declaration_header": v:true,
        \   "org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_type_header": v:true,
        \   "org.eclipse.jdt.core.formatter.indent_breaks_compare_to_cases": v:true,
        \   "org.eclipse.jdt.core.formatter.indent_empty_lines": v:false,
        \   "org.eclipse.jdt.core.formatter.indent_statements_compare_to_block": v:true,
        \   "org.eclipse.jdt.core.formatter.indent_statements_compare_to_body": v:true,
        \   "org.eclipse.jdt.core.formatter.indent_switchstatements_compare_to_cases": v:true,
        \   "org.eclipse.jdt.core.formatter.indent_switchstatements_compare_to_switch": v:false,
        \   "org.eclipse.jdt.core.formatter.indentation.size": 2,
        \   "org.eclipse.jdt.core.formatter.insert_new_line_after_annotation_on_field": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_after_annotation_on_local_variable": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_after_annotation_on_method": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_after_annotation_on_package": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_after_annotation_on_parameter": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_after_annotation_on_type": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_after_label": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_after_opening_brace_in_array_initializer": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_at_end_of_file_if_missing": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_before_catch_in_try_statement": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_before_closing_brace_in_array_initializer": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_before_else_in_if_statement": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_before_finally_in_try_statement": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_before_while_in_do_statement": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_in_empty_annotation_declaration": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_in_empty_anonymous_type_declaration": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_in_empty_block": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_in_empty_enum_constant": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_in_empty_enum_declaration": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_in_empty_method_body": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_new_line_in_empty_type_declaration": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_and_in_type_parameter": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_assignment_operator": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_at_in_annotation": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_at_in_annotation_type_declaration": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_binary_operator": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_closing_angle_bracket_in_type_arguments": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_closing_angle_bracket_in_type_parameters": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_closing_brace_in_block": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_closing_paren_in_cast": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_colon_in_assert": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_colon_in_case": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_colon_in_conditional": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_colon_in_for": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_colon_in_labeled_statement": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_allocation_expression": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_annotation": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_array_initializer": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_constructor_declaration_parameters": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_constructor_declaration_throws": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_enum_constant_arguments": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_enum_declarations": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_explicitconstructorcall_arguments": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_for_increments": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_for_inits": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_declaration_parameters": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_declaration_throws": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_invocation_arguments": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_multiple_field_declarations": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_multiple_local_declarations": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_parameterized_type_reference": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_superinterfaces": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_type_arguments": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_comma_in_type_parameters": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_ellipsis": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_parameterized_type_reference": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_type_arguments": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_angle_bracket_in_type_parameters": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_brace_in_array_initializer": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_bracket_in_array_allocation_expression": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_bracket_in_array_reference": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_annotation": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_cast": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_catch": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_constructor_declaration": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_enum_constant": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_for": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_if": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_method_declaration": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_method_invocation": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_parenthesized_expression": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_switch": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_synchronized": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_try": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_opening_paren_in_while": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_postfix_operator": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_prefix_operator": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_question_in_conditional": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_question_in_wildcard": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_semicolon_in_for": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_semicolon_in_try_resources": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_after_unary_operator": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_and_in_type_parameter": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_assignment_operator": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_at_in_annotation_type_declaration": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_binary_operator": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_parameterized_type_reference": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_type_arguments": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_angle_bracket_in_type_parameters": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_brace_in_array_initializer": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_bracket_in_array_allocation_expression": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_bracket_in_array_reference": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_annotation": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_cast": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_catch": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_constructor_declaration": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_enum_constant": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_for": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_if": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_method_declaration": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_method_invocation": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_parenthesized_expression": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_switch": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_synchronized": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_try": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_closing_paren_in_while": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_colon_in_assert": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_colon_in_case": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_colon_in_conditional": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_colon_in_default": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_colon_in_for": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_colon_in_labeled_statement": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_allocation_expression": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_annotation": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_array_initializer": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_constructor_declaration_parameters": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_constructor_declaration_throws": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_enum_constant_arguments": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_enum_declarations": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_explicitconstructorcall_arguments": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_for_increments": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_for_inits": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_declaration_parameters": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_declaration_throws": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_method_invocation_arguments": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_multiple_field_declarations": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_multiple_local_declarations": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_parameterized_type_reference": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_superinterfaces": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_type_arguments": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_comma_in_type_parameters": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_ellipsis": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_parameterized_type_reference": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_type_arguments": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_angle_bracket_in_type_parameters": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_annotation_type_declaration": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_anonymous_type_declaration": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_array_initializer": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_block": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_constructor_declaration": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_enum_constant": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_enum_declaration": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_method_declaration": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_switch": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_type_declaration": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_allocation_expression": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_reference": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_bracket_in_array_type_reference": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_annotation": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_annotation_type_member_declaration": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_catch": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_constructor_declaration": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_enum_constant": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_for": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_if": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_method_declaration": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_method_invocation": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_parenthesized_expression": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_switch": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_synchronized": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_try": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_while": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_parenthesized_expression_in_return": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_parenthesized_expression_in_throw": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_postfix_operator": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_prefix_operator": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_question_in_conditional": "insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_question_in_wildcard": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_semicolon": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_semicolon_in_for": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_semicolon_in_try_resources": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_before_unary_operator": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_between_brackets_in_array_type_reference": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_between_empty_braces_in_array_initializer": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_between_empty_brackets_in_array_allocation_expression": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_annotation_type_member_declaration": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_constructor_declaration": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_enum_constant": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_method_declaration": "do not insert",
        \   "org.eclipse.jdt.core.formatter.insert_space_between_empty_parens_in_method_invocation": "do not insert",
        \   "org.eclipse.jdt.core.formatter.join_lines_in_comments": v:true,
        \   "org.eclipse.jdt.core.formatter.join_wrapped_lines": v:false,
        \   "org.eclipse.jdt.core.formatter.keep_else_statement_on_same_line": v:false,
        \   "org.eclipse.jdt.core.formatter.keep_empty_array_initializer_on_one_line": v:false,
        \   "org.eclipse.jdt.core.formatter.keep_imple_if_on_one_line": v:false,
        \   "org.eclipse.jdt.core.formatter.keep_then_statement_on_same_line": v:false,
        \   "org.eclipse.jdt.core.formatter.lineSplit": 120,
        \   "org.eclipse.jdt.core.formatter.never_indent_block_comments_on_first_column": v:false,
        \   "org.eclipse.jdt.core.formatter.never_indent_line_comments_on_first_column": v:false,
        \   "org.eclipse.jdt.core.formatter.number_of_blank_lines_at_beginning_of_method_body": 0,
        \   "org.eclipse.jdt.core.formatter.number_of_empty_lines_to_preserve": 1,
        \   "org.eclipse.jdt.core.formatter.put_empty_statement_on_new_line": v:false,
        \   "org.eclipse.jdt.core.formatter.tabulation.char": "space",
        \   "org.eclipse.jdt.core.formatter.tabulation.size": 2,
        \   "org.eclipse.jdt.core.formatter.use_on_off_tags": v:false,
        \   "org.eclipse.jdt.core.formatter.use_tabs_only_for_leading_indentations": v:false,
        \   "org.eclipse.jdt.core.formatter.wrap_before_or_operator_multicatch": v:true,
        \   "org.eclipse.jdt.core.formatter.wrap_outer_expressions_when_nested": v:true,
        \ }


    let g:lsp_document_format_options = {
        \   'typescript.tsx': my_typescript_format_options,
        \   'typescript': my_typescript_format_options,
        \   'typescript-language-server': my_typescript_format_options,
        \   'eclipse-jdt-ls': my_java_format_options,
        \ }

    Plug 'mattn/vim-lsp-settings'
    ", {'tag': 'v0.0.1'}
    nmap <leader>gh :LspDeclaration<CR>
    nmap <leader>ph :LspPeekDeclaration<CR>
    nmap <leader>gd :LspDefinition<CR>
    nmap <leader>pd :LspPeekDefinition<CR>
    nmap <leader>fi :LspCodeAction<CR>
    nmap <leader>df :LspDocumentFormatSync<CR>

    Plug 'prabirshrestha/asyncomplete.vim'
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/async.vim'

    if filereadable('.clang-format')
        Plug 'rhysd/vim-clang-format'
        let g:clang_format#detect_style_file=1 " use .clang-format
        let g:clang_format#auto_format=1 " format on save
        let g:clang_format#auto_format_on_insert_leave=0
    else
        " autocmd BufWritePre * :LspDocumentFormatSync
        " autocmd! BufWritePre *.go :LspDocumentFormatSync
    endif

    Plug 'mattn/vim-goimports'

    Plug 'majutsushi/tagbar'
    let g:tagbar_sort=0 " sort by order in file
    " Outline
    nmap <leader>O :TagbarToggle<CR>
    nmap <leader>o :TagbarOpenAutoClose<CR>
    let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 'n:interfaces',
            \ 't:types',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
        \ },
        \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
        \ },
        \ 'ctagsbin'  : 'gotags',
        \ 'ctagsargs' : '-sort -silent'
    \ }


    Plug 'ntpeters/vim-better-whitespace'
    nmap <leader>w :StripWhitespace<CR>

    " Plug 'w0rp/ale'
    " let g:ale_sign_error = 'EE'
    " let g:ale_sign_warning = 'WW'
    " let g:ale_sign_column_always = 1
    " let g:ale_linters = {
    " \   'python': ['pylint'],
    " \   'c': [],
    " \   'cpp': [],
    " \   'java': [],
    " \   'javascript': [],
    " \   'typescript': [],
    " \}

    Plug 'vim-airline/vim-airline'
    " Set this. Airline will handle the rest.
    let g:airline#extensions#ale#enabled=1
    let g:airline_detect_spell=0
    if g:os == "Windows"
        let g:airline#parts#ffenc#skip_expected_string='utf-8[dos]'
    else
        let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
    endif
    " let g:airline_section_x = '%{airline#util#prepend(airline#extensions#tagbar#currenttag(),0)}'
    let g:airline_section_z ='%p%%%#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#:%v'

    Plug 'MattesGroeger/vim-bookmarks'
    let g:bookmark_disable_ctrlp = 1

    Plug 'lervag/vimtex'
    Plug 'jparise/vim-graphql'
    let g:typescript_indent_disable = 1
    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'

    Plug 'stephpy/vim-yaml'

    call plug#end()
catch
    " dont really care...
endtry

filetype plugin indent on

set encoding=utf-8
set backspace=indent,eol,start


noremap <C-Z> u
noremap <C-S-Z> <C-R>
noremap <C-Tab> <C-W>w
noremap zO zR
noremap zC zM

" Find all, open quickfix
function! FindAll(include_test, pattern)
    execute "grep! \"" . a:pattern . "\""
    if !a:include_test
        let new_results = []
        for qresult in getqflist()
            if bufname(qresult.bufnr) !~ 'TEST'
                call add(new_results, qresult)
            endif
        endfor
        call setqflist(new_results)
    endif
    copen
    wincmd p
endfunction

nmap <leader>fA :call FindAll(1, @/)<CR><CR>
nmap <leader>fa :call FindAll(0, @/)<CR><CR>

vmap <leader>fA "vy\|/<C-R>v<CR>:call FindAll(1, @v)<CR><CR>
vmap <leader>fa "vy\|/<C-R>v<CR>:call FindAll(0, @v)<CR><CR>

set ruler
set textwidth=100
set shiftwidth=4
set tabstop=4
if exists('&colorcolumn')
    set colorcolumn=+1
endif
" turn line numbers on
set number
if exists('&relativenumber')
    set relativenumber
    " augroup numbertoggle
    "     autocmd!
    "     autocmd BufEnter,FocusGained,InsertLeave * if line("$") < 3000 | set relativenumber | endif
    "     autocmd BufEnter,FocusGained,InsertLeave * if line("$") > 3000 | set norelativenumber | endif
    "     autocmd BufLeave,FocusLost,InsertEnter * if line("$") < 3000 | set norelativenumber | endif
    " augroup END
endif
set nowrap

set hlsearch
set ignorecase
set smartcase
set infercase

set expandtab

function SetGrepPrg()
    let l:git_status_output = system('git status')
    if v:shell_error
        set grepprg=grep\ -rn\ --exclude-dir=.git
    else
        set grepprg=git\ grep\ -n
    endif
endfunction
call SetGrepPrg()

syntax on

if has("gui_running")
    set spell spelllang=en_us
    if g:os == "Darwin"
        set guifont=Fira\ Mono:h12
    elseif g:os == "Linux"
        set guifont=Inconsolata\ Medium\ 14
    elseif g:os == "Windows"
        set guifont=Consolas:h10
    endif
else
    set background=dark
    let g:airline_theme='codedark'
    let g:codedark_cterm_background='NONE'
    let g:codedark_cterm_taboutside='NONE'
    try
        colorscheme codedark
    catch
        " whatever
    endtry
endif

let g:tex_verbspell=0

command! Inside let g:solarized_termtran=1 | set background=dark | colorscheme solarized
command! Outside let g:solarized_termtran=0 | set background=light | colorscheme solarized

set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
set guioptions+=c "use console dialog instead of pop up
set guioptions-=r "remove rich scroll bar
set guioptions-=L "remove left scroll bar

if g:os == "Darwin" && executable('gmake')
    set makeprg=gmake
endif

autocmd FileType qf wincmd J | vertical resize 10
autocmd FileType java setlocal shiftwidth=2 tabstop=2
