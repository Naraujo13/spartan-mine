module ApplicationHelper

    @page_index
    @app_all_script = ""
    @app_all_style  = ""
    @table_num_elements= 0
    @has_tab = false
	# Método que retorna o cabeçalho do sistema
	# ele é composto pelo paper-dialog de erro e o template iniciada da página
	#
	# === Parametros
	#
	# - array_tabs_name::      Array[String]   array de nome de tabs se existir
	# - page_index_selected::  Int/String      opcional e escolha qual é a tab padrão selecionada
	# - helpUrl::              String          com a url do ajuda daquela página
    def app_header array_tabs_name=nil,page_index_selected="0",helpUrl=nil, new_edit=nil
        @app_all_script = ""
        @app_all_style  = ""

        if not helpUrl
           helpUrl = controller.controller_name
           helpUrl = helpUrl.downcase
        end

        lang_delete = t('app_dialog_sure_delete')
        lang_atenction = t('app_dialg_attention')
        lang_delete_many = t('app_dialog_sure_delete_many')
        lang_selecteds = t "app_selecteds"
        lang_ok = t "app_understood"
        lang_cancel = t "app_cancel"

        retorno = "<div name='app_tabs' id='app_tabs' class='nav-content'>"
        # Deixa a área de tabs maior para comportar as tabs
        if array_tabs_name != nil
            @has_tab = true
            retorno +="<ul class='tabs tabs-transparent'>"
            val = 0
            array_tabs_name.each do |name|
                retorno +="<li class='tab' name='#{val}'><a href='#tab_#{val}'>#{name}</a></li>"
                val +=1
            end
            retorno += "</ul>"
        end
        retorno += "</div>"

        # Breadcrumb builder
        path = request.env['PATH_INFO']
        path_array = path.split("/")
        path_array = path_array[0..2]
        path = ''
        path_array.each do |v|
          path+= v+'/'
        end
        n = path.size
        path= path[0..n-2]

        results = System::Program.where("path like '#{path}'")
        breadcrumb = []
        if path != "/dashboard"
          breadcrumb << {:name => t("app_home"), :path => "/"}
        end
        string_breadcrumb = "<nav style='box-shadow: none;'><div class='nav-wrapper'><div class='col s12'>"
        if not results.blank?
          results.each do |result|
            category = System::CategoryProgram.find(result.category_program_id)
            if not category.blank?
              breadcrumb  << {:name=>t(category.locate_label, :default => "..."), :path=>nil}
            end
            breadcrumb << {:name=>t(result.locate_label, :default => "..."), :path=>result.path}
          end
        end

        breadcrumb.each do |step|
            if step[:path] != nil
                string_breadcrumb+= "<a href='#!' class='breadcrumb' onclick=\\\"location.href='"+step[:path]+"'\\\" >"+step[:name]+"</a>"
            else
                string_breadcrumb+= "<a href='#!' class='breadcrumb' onclick=\\\"document.querySelector('#navicon').click()\\\" >"+step[:name]+"</a>"
            end
        end

        if new_edit == 'new'
            string_breadcrumb+= "<a  class='breadcrumb'>"+t('app_new')+"</a>"
        elsif new_edit == 'edit'
            string_breadcrumb+= "<a  class='breadcrumb'>"+t('app_edit')+"</a>"
        end

        string_breadcrumb +="</div></div></nav>"

        retorno += "</nav>"

        retorno += "<script>$(document).ready(function(){$('#controllers').html(\"#{string_breadcrumb}\");});$('#controllers').css('margin-left','60px');$('#controllers').css('margin-right','210px');function help(){location.href='/system/help/##{helpUrl}'}</script>"
        #script context menu
        retorno += "<script>$(document).ready(function(){ $('ul.tabs').tabs('select_tab', '#{page_index_selected}'); });</script>"
        retorno.html_safe
    end

    def app_header_new array_tabs_name=nil,page_index_selected="0",helpUrl=nil
        app_header array_tabs_name,page_index_selected,helpUrl, 'new'
    end

    def app_header_edit array_tabs_name=nil,page_index_selected="0",helpUrl=nil
        app_header array_tabs_name,page_index_selected,helpUrl, 'edit'
    end

	# Método que inicia cada uma das das páginas do sistema
	#
	# === Parametros
	#
	# - page_index::   Int/String  informa qual é o index daquela página
	#
    def app_header_page page_index=0, register = nil
        # da página cria-se então uma div > paper-material
        @page_index = page_index.to_s
        retorno ="<div id='tab_#{@page_index}' class='row' style='margin: 35px 15px 15px 15px;'>
                    <div id='paper_material_list_#{@page_index}' class='z-depth-4 col s12' style='padding: 1px 10px;'>"
        retorno.html_safe
    end


    def app_footer_page registros, controller=nil, total=nil, paginator=true
        lang_cancel = t"app_no"
        lang_ok = t "app_yes"
        lang_empty = t"app_empty"
        understood = t"app_understood"

        if @app_all_script == nil
            @app_all_script = ""

        end


        retorno = ""

        if defined? registros.length and registros.length == 0
            retorno += "<div id='empty_show_#{@page_index}' class='tooltipped' data-position='top' data-tooltip='#{lang_empty}' style='text-align: center;cursor:pointer' onclick=\"$('a.btn-floating').addClass('pulse')\"><div class='row'><div class='col s3'></div><img class='col s6' src='/assets/system/empty_registers.gif' style='cursor:pointer'><div class='col s3'></div></div><div>"
        else
            if defined? registros.errors and registros.errors.present?
                mensagens = "<ul class='collection'>"

                registros.errors.full_messages.each do |message|
                    mensagens+= "<li class='collection-item' style='display: flex;'><i style='margin-right: 10px;' class='material-icons'>error</i>#{message}</li>"
                end
                mensagens += "</ul>"

                retorno+="<script>$(document).ready(function() {dialogOpen('Erro ao Salvar',\""+mensagens+"\",'#{understood}','','','');});console.log('ERROR')</script>"
            end
            retorno += "<div id='empty_show_#{@page_index}' class='tooltipped' data-position='top' data-tooltip='#{lang_empty}' style='text-align: center;cursor:pointer;display:none' onclick=\"$('a.btn-floating').addClass('pulse')\"><div class='row'><div class='col s3'></div><img class='col s6' src='/assets/system/empty_registers.gif' style='cursor:pointer'><div class='col s3'></div></div><div>"
        end


        if controller != nil
          lang_delete = t('app_dialog_sure_delete')
          lang_atenction = t('app_dialg_attention')
          lang_success = t('app_relation_nn_removed')
          lang_error = t('app_relation_nn_removed_error')

          @app_all_script +="<script type='text/javascript'>function dialog_confirmation_#{@page_index}(value){dialogOpen('#{lang_atenction}','#{lang_delete}','#{lang_ok}','#{lang_cancel}','deleting_#{@page_index}(\"'+value+'\")','');}function deleting_#{@page_index}(value){$.ajax({type: 'POST',url: '#{controller}/' + value,dataType: 'json',data: {'_method':'delete'},sucess: function(){delete_element_#{@page_index}('\'+value+'\');Materialize.toast('#{lang_success}',1500);},error: function(){Materialize.toast('#{lang_error}',2500);},complete: function(xhr){if(xhr.status >= 200 && xhr.status <= 302){delete_element_#{@page_index}('\'+value+'\');Materialize.toast('#{lang_success}',1500);}}});try{event.preventDefault();}catch(err){}}</script>"
        end
        retorno +="</div></div></div></div>"
        retorno.html_safe
    end

    # Método que fecha do template, mas também cria a função
    # de deletar elementos da interface e do banco de dados
    #
    def app_footer
        retorno = ""+@app_all_script.to_s
        @app_all_script = ""
        retorno.html_safe
    end


    def table_header label='',elements = [],icon_main_action='person_add',show_data=true,icon_search='search'
        @table_show_data = show_data
        @table_num_elements = elements.length+1
        main_action = "<a href='#add_users' class='modal-trigger waves-effect btn-flat nopadding'>
                            <i class='material-icons'>#{icon_main_action}</i>
                       </a>"
        main_action=""
        retorno = "<div class='material-table'><div class='table-header'>
                        <span class='table-title'>#{label}</span>
                        <div class='actions'>
                            #{main_action}
                            <a href='#' class='search-toggle waves-effect btn-flat nopadding'>
                                <i class='material-icons'>#{icon_search}</i>
                            </a>
                        </div>
                    </div>
                    <table id='datatable_#{@page_index}'>
                        <thead>
                            <tr>"
                                elements.each do |element|
                                    retorno += "<th>#{element[:name]}</th>"
                                end
                                if @table_show_data
                                    retorno += "<th>Data</th>"
                                end
                                retorno +="<th></th>" #delete th
                retorno += "</tr>
                        </thead>
                    <tbody>"
        retorno.html_safe
    end


    def table_row register_id, elements,path_element='/',element_date=nil,deletable=true,data_format='%d/%m/%Y %H:%M', icon_delete='delete'
        retorno = "<tr id='#{register_id}'>"
        elements.each do |element|
            retorno += "<td style='cursor:pointer' onclick=\"location.href='#{path_element}'\">#{element}</td>"
        end
        if element_date != nil
            retorno +="<td style='cursor:pointer' onclick=\"location.href='#{path_element}'\">#{element_date.strftime(data_format)}</td>"
        end
        if deletable
            retorno += "<td style='cursor:pointer' onClick=\"dialog_confirmation_#{@page_index}('#{register_id}')\" ><i class='material-icons'>#{icon_delete}</i></td>"
        else
            retorno += "<td style='cursor:pointer'></td>"
        end
        retorno += "</tr>"
        retorno.html_safe
    end

    def table_footer
        app_search = t 'app_search_registers'
        app_all = t 'app_all'
        app_registers_por_page = t 'app_registers_por_page'
        retorno = "</tbody>
                </table>"
        retorno += "<script>
                    (function(window, document, undefined) {
                      var factory = function($, DataTable) {
                        'use strict';
                        $('.search-toggle').click(function() {
                          if ($('.hiddensearch').css('display') == 'none')
                            $('.hiddensearch').slideDown();
                          else
                            $('.hiddensearch').slideUp();
                        });
                        /* Set the defaults for DataTables initialisation */
                        $.extend(true, DataTable.defaults, {
                          dom: \"<'hiddensearch\'f'>\" +
                            \"tr\" +
                            \"<\'table-footer\'lip\'>\",
                          renderer: 'material'
                        });
                        /* Default class modification */
                        $.extend(DataTable.ext.classes, {
                          sWrapper: 'dataTables_wrapper',
                          sFilterInput: 'form-control input-sm',
                          sLengthSelect: 'form-control input-sm'
                        });
                        /* Bootstrap paging button renderer */
                        DataTable.ext.renderer.pageButton.material = function(settings, host, idx, buttons, page, pages) {
                          var api = new DataTable.Api(settings);
                          var classes = settings.oClasses;
                          var lang = settings.oLanguage.oPaginate;
                          var btnDisplay, btnClass, counter = 0;
                          var attach = function(container, buttons) {
                            var i, ien, node, button;
                            var clickHandler = function(e) {
                              e.preventDefault();
                              if (!$(e.currentTarget).hasClass('disabled')) {
                                api.page(e.data.action).draw(false);
                              }
                            };
                            for (i = 0, ien = buttons.length; i < ien; i++) {
                              button = buttons[i];
                              if ($.isArray(button)) {
                                attach(container, button);
                              } else {
                                btnDisplay = '';
                                btnClass = '';
                                switch (button) {
                                  case 'first':
                                    btnDisplay = lang.sFirst;
                                    btnClass = button + (page > 0 ?
                                      '' : ' disabled');
                                    break;
                                  case 'previous':
                                    btnDisplay = \"<i class='material-icons'>chevron_left</i>\";
                                    btnClass = button + (page > 0 ?
                                      '' : ' disabled');
                                    break;
                                  case 'next':
                                    btnDisplay = \"<i class='material-icons'>chevron_right</i>\";
                                    btnClass = button + (page < pages - 1 ?
                                      '' : ' disabled');
                                    break;
                                  case 'last':
                                    btnDisplay = lang.sLast;
                                    btnClass = button + (page < pages - 1 ?
                                      '' : ' disabled');
                                    break;
                                }
                                if (btnDisplay) {
                                  node = $('<li>', {
                                      'class': classes.sPageButton + ' ' + btnClass,
                                      'id': idx === 0 && typeof button === 'string' ?
                                        settings.sTableId + '_' + button : null
                                    })
                                    .append($('<a>', {
                                        'href': '#',
                                        'aria-controls': settings.sTableId,
                                        'data-dt-idx': counter,
                                        'tabindex': settings.iTabIndex
                                      })
                                      .html(btnDisplay)
                                    )
                                    .appendTo(container);
                                  settings.oApi._fnBindAction(
                                    node, {
                                      action: button
                                    }, clickHandler
                                  );
                                  counter++;
                                }
                              }
                            }
                          };

                          // IE9 throws an 'unknown error' if document.activeElement is used
                          // inside an iframe or frame.
                          var activeEl;
                          try {
                            // Because this approach is destroying and recreating the paging
                            // elements, focus is lost on the select button which is bad for
                            // accessibility. So we want to restore focus once the draw has
                            // completed
                            activeEl = $(document.activeElement).data('dt-idx');
                          } catch (e) {}
                          attach(
                            $(host).empty().html(\"<ul class='material-pagination'/>\").children('ul'),
                            buttons
                          );
                          if (activeEl) {
                            $(host).find('[data-dt-idx=' + activeEl + ']').focus();
                          }
                        };
                        /*
                         * TableTools Bootstrap compatibility
                         * Required TableTools 2.1+
                         */
                        if (DataTable.TableTools) {
                          // Set the classes that TableTools uses to something suitable for Bootstrap
                          $.extend(true, DataTable.TableTools.classes, {
                            'container': 'DTTT btn-group',
                            'buttons': {
                              'normal': 'btn btn-default',
                              'disabled': 'disabled'
                            },
                            'collection': {
                              'container': 'DTTT_dropdown dropdown-menu',
                              'buttons': {
                                'normal': '',
                                'disabled': 'disabled'
                              }
                            },
                            'print': {
                              'info': 'DTTT_print_info'
                            },
                            'select': {
                              'row': 'active'
                            }
                          });

                          // Have the collection use a material compatible drop down
                          $.extend(true, DataTable.TableTools.DEFAULTS.oTags, {
                            'collection': {
                              'container': 'ul',
                              'button': 'li',
                              'liner': 'a'
                            }
                          });
                        }
                      }; // /factory

                      // Define as an AMD module if possible
                      if (typeof define === 'function' && define.amd) {
                        define(['jquery', 'datatables'], factory);
                      } else if (typeof exports === 'object') {
                        // Node/CommonJS
                        factory(require('jquery'), require('datatables'));
                      } else if (jQuery) {
                        // Otherwise simply initialise as normal, stopping multiple evaluation
                        factory(jQuery, jQuery.fn.dataTable);
                      }
                    })(window, document);
                    $(document).ready(function() {
                      $('#datatable_#{@page_index}').dataTable({
                        select: true,
                        columnDefs: [ { orderable: false, targets: [#{@table_num_elements}] },{ width: 60, targets: #{@table_num_elements} },{ width: 200, targets: #{@table_num_elements-1} } ],
                        'oLanguage': {
                          'sStripClasses': '',
                          'sSearch': '',
                          'sSearchPlaceholder': '#{app_search}',
                          'sInfo': '_START_ -_END_ of _TOTAL_',
                          'sLengthMenu': \"<span>#{app_registers_por_page}:</span><select class='browser-default'>\" +
                            '<option value=\"10\">10</option>' +
                            '<option value=\"20\">20</option>' +
                            '<option value=\"30\">30</option>' +
                            '<option value=\"40\">40</option>' +
                            '<option value=\"50\">50</option>' +
                            '<option value=\"-1\">#{app_all}</option>' +
                            '</select></div>'
                        },
                        bAutoWidth: false
                      });
                        table = $('#datatable_#{@page_index}').DataTable();
                        if(table.data().rows()[0].length==0){
                            document.querySelector('.material-table').style.display = 'none';
                            document.querySelector('#empty_show_0').style.display = ''
                        }
                    });
                    // function remove to table
                    function delete_element_#{@page_index}(id){
                        table = $('#datatable_#{@page_index}').DataTable();
                        $(\"tr[id='\"+id+\"']\").addClass('selected');
                        table.row('.selected').remove().draw( false );
                        if(table.data().rows()[0].length==0){
                            document.querySelector('.material-table').style.display = 'none';
                            document.querySelector('#empty_show_0').style.display = ''
                        }
                    }
                    </script>
                </div>
                    "
        retorno.html_safe
    end

    def list_header registros, controller=nil,total=nil,paginator=true
        retorno = "<style>.collection .collection-item{border-bottom:initial}.collection{border:initial}</style>"
        retorno += "<script>
                    function delete_element_#{@page_index}(id){
                        $('#paginator_#{@page_index}_first').click()
                    }
                    function search_#{@page_index}(){
                        search_input = document.querySelector('#search_#{@page_index}')
                        href = $('#paginator_#{@page_index}_first').attr('href');
                        if(href.indexOf('&search=') > -1){
                            to_cut = href.slice(href.indexOf('&search='),href.length);
                            href = href.replace(to_cut,'');
                            href += '&search='+search_input.value.replace(' ','+')
                        }
                        $('#paginator_#{@page_index}_first').attr('href',href);
                        $('#paginator_#{@page_index}_first').click();
                    }
                    $(document).ready(function(){
                        $('#search_#{@page_index}').keyup(search_#{@page_index});
                        $('#search_#{@page_index}_field').focusout(function(){
                            console.log('aaaa')
                            document.querySelector('#search_#{@page_index}_field').style.visibility = 'hidden';
                            document.querySelector('#search_#{@page_index}_remove').style.visibility = 'hidden';
                        });
                        $('#search_#{@page_index}_icon').click(function(){
                            console.log('bbbb')
                            document.querySelector('#search_#{@page_index}_field').style.visibility = 'visible';
                            document.querySelector('#search_#{@page_index}_remove').style.visibility = 'visible';
                        });
                    });
                    </script>"
        if params[:search] == nil
          params[:search] = ''
        end

        if @app_all_script == nil
            @app_all_script = ""
        end

        if registros.try(:total_pages)
            messenge = t("app_search")+" em "+registros.length.to_s+" "+t('app_registers')
            if total
                messenge = t("app_search")+" em "+total.to_s+" "+t('app_registers')
            end
            retorno += "<div style='display:flex'>
                            <div style='margin-left: 18px;'>
                                <form accept-charset='UTF-8' action='#{controller}?paginator=#{@page_index}&tab=#{@page_index}' method='get' style='display: flex;'>
                                    <div style='visibility:hidden'>
                                        <input name='utf8' type='hidden' value='✓'/>
                                        <input name='tab' type='hidden' value='#{@page_index}'/>
                                    </div>
                                    <div class='input-field'>
                                        <i id='search_#{@page_index}_icon' class='material-icons prefix' style='margin-top: 15px;cursor:pointer'>search</i>
                                    </div>
                                    <div id='search_#{@page_index}_field' class='input-field' style='min-width:240px;visibility:hidden;margin-left: 40px;'>
                                        <input search id='search_#{@page_index}' type='text' class='validate' name='search' value='"+params[:search]+"'>
                                        <label for='search'>#{messenge}</label>
                                    </div>
                                    <div class='input-field' id='search_#{@page_index}_remove' style='visibility:hidden'>
                                        <i onclick=\"document.querySelector('#search_#{@page_index}').value = '';$(this.parentElement).attr('action') ;$('#paginator_#{@page_index}_first').click()\" class='material-icons prefix' style='margin-top: 15px;cursor:pointer;padding-left: 10px;'>clear</i>
                                    </div>
                                </form>
                            </div>
                            <div style='flex-grow: 1'></div>
                            <div style='margin-top: 35px;margin-right: 10px;'>
                                <div id='paginator_#{@page_index}' style='display: flex;'>"
            if paginator == true
                retorno += paginate registros, :remote => true, params: { tab: @page_index }
            end
            retorno+= "         </div>
                                <a id='paginator_#{@page_index}_first' data-remote='true' href='"+request.original_url+"?page=1&tab=#{@page_index}&search=' rel='next'></a>
                            </div>
                        </div>"
        end
        retorno += "    <div class='collection' id='collection_#{@page_index}' style='margin-top: 0px;'>"
        retorno.html_safe
    end

    def list_footer
        retorno = "     </div>"
        retorno.html_safe
    end


    def card_header registros, controller=nil, total=nil, paginator=true
        #retorno = "<div class='row' id='collection_#{@page_index}'>"
        #retorno.html_safe
        list_header registros, controller, total, paginator
    end

    #
    #
    def card_footer
        list_footer
    end

    # Método que constrói cada um dos elementos que serão exibidos
    # na forma de lista. Contém método de deletar e editar e
    # também o icone de exibição
    #
    # === Parametros
    #
    # - registro_id::          Int/String     do registro que será manipulado (editar/excluir)
    # - register_description:: String  string com a descrição que deve ser visivel
    # - secondary_description:: Secundary description Opcional
    # - register_edit_path::   URL     url para a edição do registro
    #
	def card_item register_id, register_description, secondary_description, register_edit_path, deletable=true, image_default='/assets/system/card_archive.jpg', url_file='', col_size_default='col s3', format_strftime = '%d %b %Y %H:%m:%S'
        if secondary_description.is_a? Time
            secondary_description = secondary_description.strftime(format_strftime)
        end

        i_download = ""
        if url_file != ''
            i_download = "<i class='material-icons right' onclick=\"document.querySelector('#download_#{register_id}').submit()\">cloud_download</i>"
        end

        i_delete = ""
        if deletable
            i_delete = "<i class='material-icons right' to_delete_id='#{register_id}' onClick=\"dialog_confirmation_#{@page_index}('#{register_id}')\">delete</i>"
        end

        retorno = "<div class='col #{col_size_default}' style='padding:5px 5px 0px 5px' id='field_#{register_id}'><div class='card'><div class='card-image waves-effect waves-block waves-light'><img onClick=\"document.location.href='#{register_edit_path}'\" class='activator' src='#{image_default}'></div><div class='card-content'><span class='card-title activator grey-text text-darken-4'>#{register_description}<i class='material-icons right'>more_vert</i>#{i_download}#{i_delete}</span></div><div class='card-reveal'><span class='card-title grey-text text-darken-4'>#{register_description}<i class='material-icons right'>close</i></span><p>#{secondary_description}.</p></div></div></div>"
        if url_file != ''
            retorno +="</div><form id='download_#{register_id}' method='get' action='#{url_file}'></form>"
        end

        retorno.html_safe
    end

    def list_item register_id, register_description, secondary_description, register_edit_path, icon="account_balance", deletable=true, elements=[], format_strftime = '%d %b %Y %H:%m:%S'
        if secondary_description.is_a? Time
            secondary_description = secondary_description.strftime(format_strftime)
        end

        string_elements = ""
        elements.each do |element|
            string_elements += "<i class='material-icons tooltipped' id='#{element[:id]}' onClick=\"#{element[:method]}\" data-position='top' data-tooltip='#{element[:tooltip]}' style='color: black;margin-left: 15px;'>#{element[:icon]}</i>"
        end

        icon_list = ""
        if icon.start_with?('/') or icon.start_with?('http') or icon.start_with?('https')
            icon_list = "<img src='#{icon}' alt='' class='circle'>"
        else
            icon_list = "<i class='material-icons circle'>#{icon}</i>"
        end

        retorno = "<a href='#' class='collection-item avatar' style='min-height: 65px !important;' id='field_#{register_id}'><div style='margin-right: 70px;cursor:pointer' onClick=\"document.location.href='#{register_edit_path}'\" >#{icon_list}<p class='title' style='color:black;font-weight: 300;text-transform: capitalize !important;' >#{register_description}</p><p style='font-size: 13px; color: gray;'>#{secondary_description}</p></div><div href='#'class='secondary-content'>"

		if deletable
			retorno += "<i class='material-icons' to_delete_id='#{register_id}' onClick=\"dialog_confirmation_#{@page_index}('#{register_id}')\" style='color: black;cursor:pointer'>delete</i>"
		end

        retorno += string_elements

        retorno += "</div></a>"

        retorno.html_safe
    end

    def delete_button register_id
        retorno  = "<i class='material-icons' to_delete_id='#{register_id}' onClick=\"dialog_confirmation_#{@page_index}('#{register_id}')\" style='color: black;cursor:pointer'>delete</i>"        
        retorno.html_safe
    end

    def gallery_header index=0
        index = index.to_s
        retorno = """
                    <div id='gallery_#{index}' class='masonry-gallery-wrapper'>
                        <div class='popup-gallery'>
                          <div class='gallary-sizer'></div>
                    """
        retorno.html_safe
    end

    def gallery_image title="",url=""
        retorno = "<div class='gallary-item'><a href=\"#{url}\" title='#{title}'><img src=\"#{url}\"></a></div>"
        retorno.html_safe
    end

    def gallery_footer index=0, by="Sistema"
        index = index.to_s
        index = index.to_s
        retorno = """
                        </div>
                    </div>
                    <script>
                    var $containerGallery;
                    $(document).ready(function(){

                            $containerGallery_#{index} = $(\"#gallery_#{index}\");

                            $containerGallery_#{index}.imagesLoaded(function() {
                                $containerGallery_#{index}.masonry({
                                    itemSelector: '.gallary-item img',
                                    columnWidth: '.gallary-sizer',
                                    isFitWidth: true
                                });
                            });
                        });
                        $('.popup-gallery').magnificPopup({
                            delegate: 'a',
                            type: 'image',
                            closeOnContentClick: true,
                            fixedContentPos: true,
                            tLoading: 'Loading image #%curr%...',
                            mainClass: 'mfp-img-mobile mfp-no-margins mfp-with-zoom',
                            gallery: {
                              enabled: true,
                              navigateByImgClick: true,
                              preload: [0,1] // Will preload 0 - before current, and 1 after the current image
                            },
                            image: {
                              verticalFit: true,
                              tError: \"<a href='#'>The image #%curr%</a> could not be loaded.\",
                              titleSrc: function(item) {
                                return item.el.attr('title') + '<small>by #{by}</small>';
                              },
                                zoom: {
                                  enabled: true,
                                  duration: 300 // don't foget to change the duration also in CSS
                                }
                            }
                          });
                    </script>
                    """
        retorno.html_safe
    end

    # Método que retorna o botão de adicionar novos registros no app
    #   recebe dois parametros que ajudam a gerar o botão
    #
    # === Parametros
    #
    # - add_path::   URL     para criação de novo elemento do app
    # - has_method:: String
    #
    def app_botton_add add_path, has_method = nil, add_icon='add'
        lang_add = t "app_add"
        if @has_tab
            tab_top_padding = '86px'
        else
            tab_top_padding = '38px'
        end
        if !has_method
            retorno = "<div style='position: absolute;top: #{tab_top_padding};right: 70px;z-index: 999'><a class='btn-floating btn-large waves-effect waves-light tooltipped' onClick=\"try{ga('send', 'event', 'atHome', 'sysCreateAction')}catch(exception){};document.location.href='#{add_path}'\" data-tooltip='#{lang_add}'><i class='material-icons'>#{add_icon}</i></a></div>"
        else
            retorno = "<div style='position: absolute;top: #{tab_top_padding};right: 70px;z-index: 999'><a class='btn-floating btn-large waves-effect waves-light tooltipped' onClick=\"try{ga('send', 'event', 'atHome', 'sysCreateAction')}catch(exception){};#{add_path}\" data-tooltip='#{lang_add}'><i class='material-icons'>#{add_icon}</i></a></div>"
        end
        retorno +="<script>function keyNPressed(){location.href = '#{add_path}';}</script>"
        retorno.html_safe
    end

    # Método que retorna o botão de adicionar novos registros no app
    #   recebe dois parametros que ajudam a gerar o botão
    #
    # === Parametros
    #
    # - add_path::   URL     para criação de novo elemento do app
    # - has_method:: String
    #
    def app_botton_save app_path, add_icon='save'
        lang_save = t "app_save"
        id = app_path.gsub('/', '_')
        if @has_tab
            tab_top_padding = '86px'
        else
            tab_top_padding = '35px'
        end
        retorno = "<div style='position: absolute;top: #{tab_top_padding};right: 70px;z-index: 999'><a class='btn-floating btn-large waves-effect waves-light tooltipped' onClick='save_#{id}()' data-tooltip='#{lang_save}'><i class='material-icons'>#{add_icon}</i></a></div>"

        retorno +="<script>function app_back(){document.location.href='#{app_path}';try{ga('send', 'event', 'atHome', 'sysBackAction')}catch(exception){};}function keySPressed(){$(document.querySelector('form')).submit();}function keyIPressed(){location.href = '#{app_path}';}function keyNPressed(){location.href = '#{app_path}/new'}function save_#{id}(){try{ga('send', 'event', 'atHome', 'sysSaveAction')}catch(exception){};loader(true);$(document.querySelector(\"form[action^='#{app_path}']\")).submit()}</script>"
        retorno.html_safe
    end

    # Método que retorna um botão que permite mais de
    #   uma função para ser executado.
    #
    # === Parametros
    #
    # - options::       Array     [{name: 'title',icon: 'explore', url:"", method: true, disabled:false,primary_botton:true}]
    # - has_method::    Bool
    #
    def app_botton_options options, icon_default = 'menu'
        lang_add = t "app_add"
        add_path = ""

        if @has_tab
            tab_top_padding = '86px'
        else
            tab_top_padding = '38px'
        end

        speed_dial= "<div style='position: absolute;top: #{tab_top_padding};right: 70px;z-index: 999' class='fixed-action-btn horizontal click-to-toggle'><a class='btn-floating btn-large'><i class='material-icon'>#{icon_default}</i></a><ul>"

        options.each do |option|
            disabled = ""
            icon = ""
            if option[:disabled]
                disabled = " disabled "
            end
            if option[:icon].include? "/"
                icon = "#{option[:icon]}"
            else
                icon = "#{option[:icon]}"
            end

            if option[:primary_botton]
                add_path = "<script>function keyNPressed(){#{option[:url]};}</script>"
            end
            if option[:method] == true
                speed_dial += "<li><a class='btn-floating' onclick=\"#{option[:url]}\"><i class='material_icons'>#{icon}</i></a></li>"
            else
                speed_dial += "<li><a class='btn-floating' onclick=\"document.location.href='#{option[:url]}'\"><i class='material_icons'>#{icon}</i></a></li>"
            end
        end
        speed_dial += "<ul></div>"
        retorno.html_safe
    end

    # finaliza o footer do novo
    def app_footer_new
        app_footer
    end


    # finaliza o footer do editar
    def app_footer_edit
        app_footer
    end

    # Este help ajuda a construir tutorias rapidos para o sistema
    #
    # === Parametros
    #
    # - f::        FormHelper do forumálirio
    # - app_name:: String com o nome do app
    # - app_path:: URL para a raiz do app
    #
    def app_tutorial(cards,opened=true,icon='explorer')
        retorno = "<script>"
        position = 0
        cards.each do |card|
            retorno += "tutorial_title[#{position}]= \"#{card['title']}\";\n"
            retorno += "tutorial_message[#{position}]= \"#{card['message']}\";\n"
            retorno += "tutorial_image[#{position}]= \"#{card['image']}\";\n"
            position +=1
        end
        if opened
            retorno += "$(document).ready(function(){openTutorial()});"
        end
        retorno += "$(document).ready(function(){document.querySelector('#tutorial_icon').icon= '#{icon}';document.querySelector('#tutorial_icon').style.display = '';})</script>"
        retorno.html_safe
    end
end
