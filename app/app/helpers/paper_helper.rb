module PaperHelper

    # Contrói o input via paper para o app
    #
    # === Parametros
    #
    # - label::             String      com a label
    # - f::                 FormHelper  do formulário
    # - field_name::        String      nome do campo
    # - value::             String/Int  com o valor do campo
    # - icon::              String      opcional com o icone
    # - type::              String      Tipo {Password,text,number,submit}
    # - position::          String      Posição do icone {Prefix, Suffix}
    # - helpText::          String      Texto de ajuda para o campo
    # - helpIcon::          String      Icon para ilustrar a ajuda do helpText
	#
	def paper_input label, f, field_name, value, icon="account_balance", disabled=false, type="text", position="prefix", helpText=nil,helpIcon='help-outline'

        is_disabled = ""
        if disabled == true
            is_disabled = "disabled"
        end

				is_active_label = " "
				if value != "" or value != nil
					is_active_label = " class='active' "
				end

        material_icon = ""
        if icon != "" and icon != nil
            material_icon = "<i class='material-icons prefix'>#{icon}</i>"
        end

        retorno = "<div class='row'><div class='input-field col s12'>
          #{material_icon}<input #{is_disabled} name='#{f.object_name}[#{field_name}]' id='#{f.object_name}_#{field_name}' type='#{type}' class='validate' value='#{value}'>
          <label for='#{f.object_name}_#{field_name}' #{is_active_label}>#{label}</label>
        </div></div>"
		retorno.html_safe
	end


	# Contrói o input para telefones
	#
	# === Parametros
	#
	# - label::        String      com a label
	# - f::            FormHelper  do formulário
	# - field_name::   String      nome do campo
	# - value::        String/Int  com o valor do campo
	# - icon::         String      opcional com o icone
	# - country_code:: String/Int  Código do país
	#
	def paper_input_phone label, f, field_name, value, disabled=false,icon="phone", country_code=nil
        if country_code == nil
          country_code = System::Config.first.country_code
        end
        is_disabled = ""
        if disabled
            is_disabled = "disabled"
        end
        material_icon = ""
        if icon != "" and icon != nil
            material_icon = "<i class='material-icons prefix'>#{icon}</i>"
        end
        retorno = "<div class='row'><div class='input-field col s12'>
          #{material_icon}<input #{is_disabled} name='#{f.object_name}[#{field_name}]' id='#{f.object_name}_#{field_name}'  class='validate' type='text' value='#{value}' placeholder='(#{country_code}) 000-000-000'>
          <label for='#{f.object_name}_#{field_name}'>#{label}</label>
        </div></div>"
        retorno +="<script>$(document).ready(function(){$('##{f.object_name}_#{field_name}').mask('(00) 000-000-000');})</script>"
		retorno.html_safe
	end

    # Contrói o input via paper para o app
    #
    # === Parametros
    #
    # - label::             String      com a label
    # - f::                 FormHelper  do formulário
    # - field_name::        String      nome do campo
    # - value::             String/Int  com o valor do campo
    # - icon::              String      opcional com o icone
    # - type::              String      Tipo {Password,text,number,submit}
    # - position::          String      Posição do icone {Prefix, Suffix}
    # - helpText::          String      Texto de ajuda para o campo
    # - helpIcon::          String      Icon para ilustrar a ajuda do helpText
	#
	def paper_input_money label, f, field_name, value, disabled=false,icon="attach_money"
        if value != nil
            value = "#{'%.02f' % value}"
        end
        is_disabled = ""
        if disabled
            is_disabled = "disabled"
        end
        material_icon = ""
        if icon != "" and icon != nil
            material_icon = "<i class='material-icons prefix'>#{icon}</i>"
        end
        retorno = "<div class='row'><div class='input-field col s12'>
          #{material_icon}<input #{is_disabled} name='#{f.object_name}[#{field_name}]' id='#{f.object_name}_#{field_name}'  class='validate' type='text' value='#{value}' placeholder='00,00'>
          <label for='#{f.object_name}_#{field_name}'>#{label}</label>
        </div></div>"
        retorno +="<script>$(document).ready(function(){$('##{f.object_name}_#{field_name}').mask('000.000.000.000.000,00', {reverse: true});})</script>"
		retorno.html_safe
	end

    def paper_input_cpf label, f, field_name, value, disabled=false,icon="attach_money"

        is_disabled = ""
        if disabled
            is_disabled = "disabled"
        end
        material_icon = ""
        if icon != "" and icon != nil
            material_icon = "<i class='material-icons prefix'>#{icon}</i>"
        end
        retorno = "<div class='row'><div class='input-field col s12'>
          #{material_icon}<input #{is_disabled} name='#{f.object_name}[#{field_name}]' id='#{f.object_name}_#{field_name}'  class='validate' type='text' value='#{value}' placeholder='000.000.000-00'>
          <label for='#{f.object_name}_#{field_name}'>#{label}</label>
        </div></div>"
        retorno +="<script>$(document).ready(function(){$('##{f.object_name}_#{field_name}').mask('000.000.000-00', {reverse: true});})</script>"
		retorno.html_safe
	end

    def paper_input_mask label, f, field_name, value, disabled=false,icon="attach_money",mask="000.0"

        is_disabled = ""
        if disabled
            is_disabled = "disabled"
        end
        material_icon = ""
        if icon != "" and icon != nil
            material_icon = "<i class='material-icons prefix'>#{icon}</i>"
        end
        retorno = "<div class='row'><div class='input-field col s12'>
          #{material_icon}<input #{is_disabled} name='#{f.object_name}[#{field_name}]' id='#{f.object_name}_#{field_name}'  class='validate' type='text' value='#{value}' placeholder='#{mask}'>
          <label for='#{f.object_name}_#{field_name}'>#{label}</label>
        </div></div>"
        retorno +="<script>$(document).ready(function(){$('##{f.object_name}_#{field_name}').mask('#{mask}', {reverse: true});})</script>"
		retorno.html_safe
	end

	# paper para texto longo
    #
    # === Parametros
    #
	# - label::        String      com a label
	# - f::            FormHelper  do formulário
	# - field_name::   String      nome do campo
	# - value::        String/Int  com o valor do campo
	# - icon::         String      opcional com o icone
	# - type::         String      Tipo {Password,text,number,submit}
	#
	def paper_textarea label, f, field_name, value, icon="account_balance",disabled=false
		id = label.clone
        id.gsub!(/[^0-9A-Za-z]/, '')

        is_disabled = ""
        if disabled == true
            is_disabled = "disabled"
        end

        material_icon = ""
        if icon != "" and icon != nil
            material_icon = "<i class='material-icons prefix'>#{icon}</i>"
        end

        retorno = "<div class='row'><div class='input-field col s12'>
          #{material_icon}<textarea #{is_disabled} name='#{f.object_name}[#{field_name}]' id='#{f.object_name}_#{field_name}' class='materialize-textarea' value='#{value}'>#{value}</textarea>
          <label for='#{f.object_name}_#{field_name}'>#{label}</label>
        </div></div>"
        retorno += "
          <script>
            $(document).ready(function(){
                $('##{f.object_name}_#{field_name}').val(\"#{value}\");
                $('##{f.object_name}_#{field_name}').trigger('autoresize');
            })
          </script>
        "
		retorno.html_safe
	end

    # Contrói um seleticondor de data para o app
    #
    # === Parametros
    #
    # - label::         String      com o nome de descrição
    # - f::             FormHelper  do formulário
    # - data::          DATE        com a data
    # - field::         String/Int  com o valor do campo
    # - field_name::    String      nome do campo no formulário
    # - icon::          String      opcional com o icone
    # - disabled::      Boolean     opcional desabilita a manipulação
    # - position::      String      position options {Prefix,Posffix}
    # - helpText::          String      Texto de ajuda para o campo
    # - helpIcon::          String      Icon para ilustrar a ajuda do helpText
    #
	def paper_date_select label, f, date, field, field_name, icon="today", disabled=nil, rangeYearBurn=nil, helpText=nil, helpIcon='help-outline'

        clear_or_date = ""
        if date != nil
            day     = date.day
            month   = date.month
            year    = date.year
            clear_or_date = "$('##{f.object_name}_#{field_name}_picker').pickadate().pickadate('picker').set('select',  [#{year},#{month-1},#{day}]);"
        else
            clear_or_date = "$('##{f.object_name}_#{field_name}_picker').pickadate().pickadate('picker').set('clear')"
        end

        maxYear = Time.now.year + 100
        minYear = Time.now.year - 100

        iron_icon = ""
        if icon != "" and icon != nil
            iron_icon = "<i class='material-icons' style='margin: 0px 15px;'>#{icon}</i>"
        end
        retorno = "<div style='display:flex;align-items: center;' class='row'>#{iron_icon}<div class='row' style='width: 100%;' ><label for='#{f.object_name}_#{field_name}_picker'>#{label}</label><input class='col s12 datepicker input-field' id='#{f.object_name}_#{field_name}_picker' name='#{f.object_name}[#{field_name}]_picker'></div><div style='display:none'>"
        if rangeYearBurn
            retorno += f.date_select field,:start_year=>minYear,:end_year=>maxYear, :include_blank => true, :default => nil
        else
            retorno += f.date_select field,:start_year=>minYear,:end_year=>maxYear, :include_blank => true, :default => nil
        end

        retorno +="</div></div><script>
            $(document).ready(function(){
                #{clear_or_date}
                $('##{f.object_name}_#{field_name}_picker').change(function(){
                    //picker input
                    picker_input = $('##{f.object_name}_#{field_name}_picker').pickadate()
                    // Use the picker object directly.
                    picker = picker_input.pickadate('picker')
                    picker.get('select')

                    //year
                    if(picker.get('select') != null){
                        $('##{f.object_name}_#{field_name}_1i').val(picker.get('select').year.toString())
                    }else{
                        $('##{f.object_name}_#{field_name}_1i').val('')
                    }
                    $('##{f.object_name}_#{field_name}_1i').material_select()
                    //month
                    if(picker.get('select') != null){
                        $('##{f.object_name}_#{field_name}_2i').val((picker.get('select').month+1).toString())
                    }else{
                        $('##{f.object_name}_#{field_name}_2i').val('')
                    }
                    $('##{f.object_name}_#{field_name}_2i').material_select()
                    //day
                    if(picker.get('select') != null){
                        $('##{f.object_name}_#{field_name}_3i').val(picker.get('select').date.toString())
                    }else{
                        $('##{f.object_name}_#{field_name}_3i').val('')
                    }
                    $('##{f.object_name}_#{field_name}_3i').material_select()

                });
            });
        </script>"
        retorno.html_safe
	end

    # método usado para se fazer a seleção, porém é realizada uma busca no sistema
    # indicada para tabelas com alta quantidade de informações
    #
    # === parametros
    #
    # - label::         campo com a label do sistema
    # - f::             form usado para captar formulário
    # - field_name::    nome do campo no qual será gerado o input/campo
    # - field_search::  nome do campo pesquisado na tabela
    # - urlList::       url para a pesquisa
    # - value::         valor default
    # - icon::          icone de exibição
    def paper_select_search(label,f,field_name,field_search,urlList,value='',icon="autorenew")
			app_searching = t("app_search")
			id = label.clone
			id.gsub!(/[^0-9A-Za-z]/, '')
			back = t("app_back")
			app_empty = t("app_empty")
			if icon == "" or icon == nil
				icon_prefix = ""
			else
				icon_prefix = "<i class='material-icons prefix'>search</i>"
			end
			retorno = """
									<div>
										<div id='selecter_list#{id}' class='modal modal-fixed-footer'>
											<div class='modal-content'>
												<h5>"+t("app_search").capitalize+" #{label}</h5>
												<div class='row'>
														<div class='input-field col s12'>
															<i class='material-icons prefix'>youtube_searched_for</i>
															<input id='selecter_search#{id}_input_fake' onkeyup='selecter_search#{id}(this.value)' type='text' class='validate'>
															<label for='selecter_search#{id}_input_fake'>#{value}</label>
														</div>
												</div>
												<div class='row collection' style='border: 1px solid #fafafa; margin: 0px 10px 0px 12px;' id='searched_list#{id}'>
												</div>
											</div>
											<div class='modal-footer'>
												<a href='#!' class='modal-action modal-close waves-effect waves-green btn-flat'>"+t("app_back")+"</a>
											</div>
										</div>
										<div class='row'>
											<div class='input-field col s12' style='padding: 0px;'>
												#{icon_prefix}
												<input id='selecter_dropdown#{id}' type='text' placeholder='Busque #{label}' onclick='selecter_selected#{id}()' class='validate active'>
												<label for='selecter_dropdown#{id}' class='active'>#{label}</label>
											</div>
										</div>
										<input id='#{f.object_name}_#{field_name}' type='hidden'>
										<script>
											function selecter_selected#{id}(){
												document.querySelector('#selecter_dropdown#{id}').value = '';
												document.querySelector('##{f.object_name}_#{field_name}').value = '';
												//$('#selecter_dropdown#{id}').modal('close')
												$('#selecter_list#{id}').modal('open');
											}
											function selecter_set_Value#{id}(value,name){
													console.log('chooset', value, name);
													$('#selecter_list#{id}').modal('close');
													document.querySelector('#selecter_dropdown#{id}').value = name;
													$('#searched_list#{id}').html('');
													if (typeof _function_selecter_set_value === 'function') {
														_function_selecter_set_value(value);
													}
													document.querySelector('##{f.object_name}_#{field_name}').value = value;
													if (typeof _selecter_search_success === 'function') {
														_selecter_search_success();
														console.log('success');
													}
											}
											function selecter_search#{id}(query){
													if( $('#selecter_search#{id}_input_fake').val().length > 2 ){
															$.ajax({
																	method:'get',
																	url: '#{urlList}',
																	type: 'json',
																	data: { query: query },
																	beforeSend: function(){
																			$('#searched_list#{id}').html('');
																			$('#searched_list#{id}').append(\"<a href='' class='collection-item'>#{app_searching}...</a>\");
																	},
																	success: function(data){
																			console.log(data);
																			$('#searched_list#{id}').html('');
																			if(data.length == 0){
																					$('#searched_list#{id}').append(\"<a href='' class='collection-item'>#{app_empty}</a>\");
																			}
																			for(a=0;a <data.length;a++){
																					$('#searched_list#{id}').append(\"<a style='cursor:pointer' class='collection-item' onclick=\\\"selecter_set_Value#{id}(\'\"+data[a].id+\"\',\'\"+data[a].#{field_search}+\"\')\\\">\"+data[a].#{field_search}+\"</a>\")
																			}
																	},
																	error:function(value){
																			Materialize.toast('Erro ao pesquisar', 4000)
																	}
															});
															}else{
																	$('#searched_list#{id}').html('');
															}
													}
										</script>
									</div>
								"""
			retorno += "<input type='hidden' value='#{value}' name='#{f.object_name}[#{field_name}]'  id='#{f.object_name}_#{field_name}'>"
			retorno.html_safe
    end

    # Contrói um checbox para o app
    #
    # === Parametros
    #
    # - label::         String com a label
    # - f::             FormHelper do formulário
    # - checkbox:: 		Symbol checkbox
    # - value::         Bool valor
    # - field_name::	String nome do campo no formulário
    # - icon::       	String opcional com o icone (DEPRECATED)
    #
	def paper_checkbox label, f, checkbox, value, field_name, icon="autorenew", disabled=false, helpText=nil
        if disabled
            disabled = " disabled "
        else
            disabled = " "
        end
        if [true, 'true', 1, '1',].include? value
            retorno = "<div class='row'><div class='col s12' style='margin-left: 5px'><input type='checkbox' name='#{f.object_name}[#{field_name}]_check' class='filled-in' id='#{f.object_name}_#{field_name}_check' #{disabled} checked='checked' /><label style='padding-left: 40px' for='#{f.object_name}_#{field_name}_check'>#{label}</label></div></div>"
        else
            retorno = "<div class='row'><div class='col s12' style='margin-left: 5px'><input type='checkbox' name='#{f.object_name}[#{field_name}]_check' class='filled-in' id='#{f.object_name}_#{field_name}_check' #{disabled}/><label style='padding-left: 40px' for='#{f.object_name}_#{field_name}_check'>#{label}</label></div></div>"
        end
        retorno +=f.check_box checkbox
        retorno+="
                <script>
                    $(document).ready(function(){
                        $('##{f.object_name}_#{field_name}_check').change(function() {
                            if(!this.checked) {
                                document.querySelector(\"input[name='#{f.object_name}[#{field_name}]']\").value = '0';
                                document.querySelector('##{f.object_name}_#{field_name}').value='0';
                                console.log('aaa')
                            }else{
                                document.querySelector(\"input[name='#{f.object_name}[#{field_name}]']\").value = '1';
                                document.querySelector('##{f.object_name}_#{field_name}').value='1';
                                console.log('bbb')
                            }
                        });
                    });
                  </script>"
        retorno.html_safe
    end

    # Contrói um color para o app
    #
    # === Parametros
    #
    # - label:: 		String com a label
    # - value:: 		value
    # - icon::      String opcional com o icone
    #
	def paper_color label, f, field_name, value, disabled=false
		id = label
		id = id.gsub(" ", "_")
		id = id.gsub("(", "_")
		id = id.gsub(")", "_")

        retorno = "<div class='row'>
                        <div class='input-field col s12'>
                            <i class='material-icons prefix' style='margin-top: 5px;'>colorize</i>
                            <input class='jscolor' value='#{value}' name='#{f.object_name}[#{field_name}]' id='#{f.object_name}_#{field_name}' type='text' style='margin-top: 5px; height: 40px;'>
                            <label for='#{f.object_name}_#{field_name}'>#{label}</label>
                        </div>
                    </div>"
		retorno.html_safe
	end

    # Cria o select do rails e também para o de paper-select
    #
    # === Parametros
    #
    # - label::         String 			com o nome
    # - f::             FormHelper      do app
    # - field::         Form_field      com o valor
    # - field_name:: 	Symbol 			com o valor
    # - value::         String 			com o valor a ser exibido
    # - values:: 		Array 			com o valor
    # - value_id:: 		String 			com o campo id do select
    # - value_show:: 	String 			com o campo de exibição do select
    # - icon:: 			String 			opcional com o campo
    # - disabled::   	Boolean			que desabilita a edição do valor
	def paper_select label, f, field, field_name, value_default, values, value_id, value_show, icon='account_balance', disabled=false

        iron_icon = ""
        if icon != "" and icon != nil
            iron_icon = "<i class='material-icons'>#{icon}</i>"
        end
				is_disabled = " "
				if disabled != false
					is_disabled = " disabled "
				end

        retorno = "<div class='row' style='display: flex;align-items: center;'>#{iron_icon}<div class='input-field col s12'><select id='#{f.object_name}_#{field_name}' name='#{f.object_name}[#{field_name}]' #{is_disabled}>"
        retorno += "<option value=''></option>"
        values.each do |value|
            if value["#{value_id}"] == field or value["#{value_id}"] == value_default
                selected = " selected "
            else
                selected = " "
            end

            if value["#{value_show}"] != nil
                value_to_show = value["#{value_show}"]
            else
                value_to_show = value.send("#{value_show}")
            end
            retorno += "<option value='"+value["#{value_id}"].to_s+"' #{selected}>"+value_to_show+"</option>"
        end
        retorno +="</select><label>#{label}</label></div></div>"


		retorno.html_safe
	end

	# Cria um input hidden para o sistema
    #
    # === Parametros
    #
	# - f:: 					FormHelper 	do app
	# - field_name:: 	Symbol 			com o valor
	# - value::  			Valor 			do campo
	def paper_hidden f,field_name,value
		"<input type='hidden' value='#{value}' name='#{f.object_name}[#{field_name}]'  id='#{f.object_name}_#{field_name}'>".html_safe
	end

    # Cria uma escolha entre valores e não sobre id como é o paper_select
    #
    # === Parametros
    #
    # - label::          String      nome dado ao chooser
    # - f::              former      formulário padrão
    # - field_name::     String      nome do campo
    # - values::         Array       com os valores possíveis
    # - valueSelected::  String      valor padrão selecionado (presente no array)
    # - vertical::       String      se diferente de nil, então os elementos são dispostos verticalmente
    # - icon::           String      opcional, adiciona um icon
    def paper_chooser label, f, field_name, values, valueSelected,vertical=nil,icon='check'
        retorno = "<div class='horizontal layout center'>
											<div class='one' style='margin-right:20px;margin-bottom:2px;'>
												<iron-icon icon='#{icon}'></iron-icon>
												<paper-tooltip>#{label}</paper-tooltip>
											</div>
                        <div class='flex'>
                            <paper-radio-group selected='#{valueSelected}'>"
                            values.each do |value|
                                if vertical
                                    retorno += "<paper-radio-button onclick=\"#{field_name}_chooser('#{value}')\" name='#{value}' style='display:block'>#{value}</paper-radio-button>"
                                else
                                    retorno += "<paper-radio-button onclick=\"#{field_name}_chooser('#{value}')\" name='#{value}'>#{value}</paper-radio-button>"
                                end

                            end
        retorno +=      "   </paper-radio-group>
                        </div>
                        <script>
                            function #{field_name}_chooser(value){
                                document.querySelector('input[id=\"#{f.object_name}_#{field_name}\"]').value = value;
                            }
                        </script>
                        <input type='hidden' value='#{valueSelected}' name='#{f.object_name}[#{field_name}]'  id='#{f.object_name}_#{field_name}'>"
        retorno +="</div>"
        retorno.html_safe
    end

    # este é um complexo helper modelado para as relações N:N entre duas tabelas.
    # Porém também conta com sistema de lista, pesquisa, adicionamento e exclusão de registro.
        # Escreva '*' para listar todos
        #
    # === Parametros
    #
    # - label::                  String      nome dado ao chooser
    # - table::                  String      com o nome completo, por exemplo 'japeto_requerentes_processo'
    # - addRelationColumn::      String      nome do campo da relação, por exemplo 'processo_id'
    # - addRelationId::          Integer     id para se fazer a relação, no caso aqui é o valor do campo 'processo_id'
    # - urlList::                String      com o endereço que retorna a lista com todos os registros
    # - urlSearch::              String      com o endereço que será usado para pesquisar os item que podem ser adicionados
    # - urlAdd::                 String      url para a inserção da relação de addRelationColumn e addRelationLeftColumn
    # - urlDelete::              String      url da CONTROLLER para qual será realizado a requisição de remoção
    # - addRelationLeftColumn::  String      nome do campo da direita, ou seja a outra coluna, no exemplo 'pessoa_id'
    # - fieldname::              String      nome do campo que trará a informação que será usada como rótulo (label) na exibição da informação na interface
    # - icon::                   String      (opcional) ele serve para ilustrar iconograficamente o tipo de elemento
    #
    # exemplo de método urlList
    #                                            def list
    #                                                  query = params['processo_id'];
    #                                                  @japeto_requerentes_processos = Japeto::RequerentesProcesso.select ('japeto_requerentes_processos .id,nome').joins (:pessoa).where ("processo_id = ?", "#{query}");
    #                                                  respond_to do |format|
    #                                                      format.json { render :json => @japeto_requerentes_processos }
    #                                                  end
    #                                              end
    # exemplo de método urlSearch
    #                                           Exemplo de
    #                                               def getSearch
    #                                                  query = params['query'];
    #                                                  @search = Japeto::Pessoa.where("nome LIKE ? OR sobrenome LIKE ?", "%#{query}%","%#{query}%");
    #                                                  respond_to do |format|
    #                                                      format.json { render :json => @search }
    #                                                  end
    #                                              end
    #
    # exemplo de método urlAdd
    #                                    def insert
    #                                      @japeto_requerentes_processo =  Japeto::RequerentesProcesso.new ( japeto_requerentes_processo_params )
    #                                      respond_to do |format|
    #                                          if @japeto_requerentes_processo.save
    #                                            format.json { render json: @japeto_requerentes_processo }
    #                                          else
    #                                            format.json { render json: @japeto_requerentes_processo.errors, status: :unprocessable_entity }
    #                                          end
    #                                      end
    #                                  end
    #
    # exemplo de método delete
    #   Aqui foi usado a própria implementação (destroy)
    #
    # Callback
    # 	Defina a função abaixo para receber os valores de acordo com a interação que se realiza no sistema
    #
    # 	 	function paper_relation_nn_<label>_callback(['listed','created','deleted','searched'],value,['success','fail'])
    def paper_relation_nn label, table, addRelationColumn, addRelationId, urlList, urlSearch, urlAdd, urlDelete, addRelationLeftColumn, field='nome', icon='account_box'

        #creating id
        id = label.clone
        id = id.downcase
        id.gsub!(/[^0-9A-Za-z]/, '')

        #creating labels
        app_dialog_sure_delete = t("app_dialog_sure_delete")
        app_relation_nn_adding = t("app_relation_nn_adding")
        app_relation_nn_adding_error =  t("app_relation_nn_adding_error")
        app_relation_nn_removed = t("app_relation_nn_removed")
        app_relation_nn_removed_error = t("app_relation_nn_removed_error")
        app_relation_nn_empty = t("app_relation_nn_empty")
        app_back = t "app_back"
        app_delete = t "app_delete"
        app_search = t "app_search"
        app_yes = t "app_yes"
        app_add = t "app_add"
        app_no = t "app_no"
        app_empty = t "app_empty"
        app_saving = t "app_saving"
        app_searching = t "app_searching"
        app_relation_nn_error_load = t "app_relation_nn_error_load"
        app_searching_err = t "app_searching_err"
        lang_registers = t "app_registers"

        #creating the code
        retorno =  "<div class='row' style='display:flex;align-items: center;margin-left: 15px;margin-bottom: 0px;'>
                        <div class='input-field tooltipped' data-position='top' data-delay='50' data-tooltip='#{app_add} #{label}' style='width: 100%;cursor:pointer' onclick='openDialogAdding#{id}()'>
                            <i class='material-icons prefix'>playlist_add</i>
                            <input disabled id='icon_prefix_#{id}' type='text' class='validate'>
                            <label for='icon_prefix_#{id}'>#{app_add} #{label}</label>
                        </div>
                        <div id='list_size_#{id}' class='tooltipped'  data-position='top' data-delay='50' data-tooltip='#{lang_registers}' style='text-align: center;width: 65px;font-size: 12px;font-weight: 400;'>
                            #{app_searching}...
                        </div>
                    </div>"
        retorno += "<div class='row' style='margin-left: 60px; margin-right: 60px; margin-top: -18px;'>
                        <div class='collection' id='added_#{id}'>
                        </div>
                    </div>"
        retorno +=" <div id='relation_list_dialog_adding_#{id}' class='modal modal-fixed-footer'>
                        <div class='modal-content'>
                            <h4>"+t("app_add")+" #{label}</h4>
                            <div class='row' style='margin-top: 0px;margin-bottom: 0px;display: flex;align-items: center;'>
                                <div class='input-field col s12'>
                                    <i class='material-icons prefix'>search</i>
                                    <input id='search_#{id}_input' style='margin-bottom: 0px;' onkeyup='search_#{id}(this.value)' type='text' class='validate'>
                                    <label for='search_#{id}_input'>"+t("app_search")+"</label>
                                </div>
                                <i class='material-icons prefix' style='cursor:pointer' onclick=\"$('#search_#{id}_input').trigger('focus');$('#search_#{id}_input').val('*');search_#{id}($('#search_#{id}_input').val())\">select_all</i>
                            </div>
                            <div class='row' style='margin-top: 0px;'>
                                <div class='collection' id='searched_#{id}' style='margin-left: 56px;margin-right:35px;    margin-top: 0px;'>
                                </div>
                            </div>
                        </div>
                        <div class='modal-footer'>
                            <a href='#' class='modal-action modal-close waves-effect waves-green btn-flat'>#{app_back}</a>
                        </div>
                    </div>"

        retorno +=" <div id='relation_list_dialog_delete_#{id}' class='modal modal-fixed-footer'>
                        <div class='modal-content'>
                            <h4>"+t("app_delete")+"</h4>
                            <div class='row'>
                                <p>#{app_dialog_sure_delete}</p>
                            </div>
                        </div>
                        <div class='modal-footer'>
                            <a href='#' onclick='forgetRelation#{id}()' class='modal-action modal-close waves-effect waves-green btn-flat'>#{app_no}</a>
                            <a href='#' onclick='deleteRelation_#{id}()' class='modal-action modal-close waves-effect waves-green btn-flat'>#{app_yes}</a>
                        </div>
                    </div>"
        retorno += "<script>
                        var to_delete_relation_left_#{id};
                        var to_delete_relation_id_#{id};
                        var total_#{id} = 0 ;
                        function setTotal#{id}(){
                            $('#list_size_#{id}').html(total_#{id}+' #{lang_registers}')
                        }
                        function openDialogAdding#{id}(){
                            document.querySelector('#search_#{id}_input').value = '';
                            $('#relation_list_dialog_adding_#{id}').modal('open');
                        }
                        function setToDelete#{id}(value){
                            to_delete_relation_id_#{id} = value;
                            $('#relation_list_dialog_delete_#{id}').modal('open');
                        }
                        function forgetRelation#{id}(){
                            to_delete_relation_left_#{id} = '';
                        }
                    "
        # function List()
        retorno += "function list_#{id}(){
                        $.ajax({
                            method:'get',
                            url: '#{urlList}',
                            type: 'json',
                            data: {'action':'list','#{addRelationColumn}':'#{addRelationId}'},
                            beforeSend: function(){
                                $('#added_#{id}').html('');
                                $('#added_#{id}').append(\"<a href='#' class='collection-item'>#{app_searching}...</a>\");
                            },success: function(data){
                                $('#added_#{id}').html('');
                                if(data != null){
                                    for(a=0; a< data.length;a++){
                                        $('#added_#{id}').append(\"<a href='#' id='search_#{id}_\"+data[a].id+\"' class='collection-item'><div>\"+data[a].#{field}+\"<div href='#' class='secondary-content'><i class='material-icons tooltipped' data-position='bottom' data-tooltip='#{app_delete}' onclick=\\\"setToDelete#{id}(\'\"+data[a].id+\"\')\\\">clear</i></div></div></a>\");
                                    }
                                    if(data.length == 0){
                                        $('#added_#{id}').append(\"<a href='#' id='empty_#{id}' class='collection-item'><div>#{app_empty}<div class='secondary-content'><i class='material-icons tooltipped' data-position='bottom' data-tooltip='#{app_empty}'>cloud_queue</i></div></div></a>\")
                                    }
                                    total_#{id} = data.length;
                                    $('#list_size_#{id}').html(data.length+' #{lang_registers}')
                                }else{
                                    $('#list_size_#{id}').html('0 #{lang_registers}')
                                }
                                if(typeof(paper_relation_nn_#{id}_callback) == 'function'){
                                    paper_relation_nn_#{id}_callback('listed',data,'success');
                                }
                            },error:function(value){
                                $('#added_#{id}').html('');
                                $('#list_size_#{id}').html('#{app_relation_nn_error_load}')
                                $('#added_#{id}').append(\"<a href='#' id='empty_#{id}' class='collection-item'><div>#{app_empty}<div href='#' class='secondary-content'><i class='material-icons tooltipped' data-position='bottom' data-tooltip='#{app_delete}'>cloud_off</i></div></div></a>\");
                                if(typeof(paper_relation_nn_#{id}_callback) == 'function'){
                                    paper_relation_nn_#{id}_callback('listed',data,'fail');
                                }
                            }
                        });
                    }</script>"
        # function search
        retorno += "<script>
                        function search_#{id}(query){

                        if( $('#search_#{id}_input').val().length > 2 || $('#search_#{id}_input').val() == '*' ){
                            if($('#search_#{id}_input').val() == '*'){
                                query = '';
                            }
                            $.ajax({
                                method:'get',
                                url: '#{urlSearch}',
                                type: 'json',
                                data: { query: query },
                                beforeSend: function(){
                                    console.log('query',query)
                                    $('#searched_#{id}').html('');
                                    $('#searched_#{id}').append(\"<a href='#' class='collection-item'>#{app_searching}...</a>\");
                                },
                                success: function(data){
                                    //console.log(data);
                                    $('#searched_#{id}').html('');
                                    if(data.length == 0){
                                        $('#searched_#{id}').append(\"<a href='#' id='empty_#{id}' class='collection-item'><div>#{app_empty}<div href='#' class='secondary-content'><i class='material-icons tooltipped' data-position='bottom' data-tooltip='#{app_delete}'>cloud_queue</i></div></div></a>\");
                                    }
                                    for(a=0;a <data.length;a++){
                                        $('#searched_#{id}').append(\"<a href='#' onclick='addRelation_#{id}(\\\"\"+data[a].id+\"\\\",\\\"\"+data[a].#{field}+\"\\\")' id='search_#{id}_\"+data[a].id+\"' class='collection-item'><div>\"+data[a].#{field}+\"<div href='#' class='secondary-content'><i class='material-icons tooltipped' data-position='bottom' data-tooltip='#{app_add}' >#{icon}</i></div></div></a>\");
                                    }
                                    if(typeof(paper_relation_nn_#{id}_callback) == 'function'){
                                        paper_relation_nn_#{id}_callback('searched',data,'success');
                                    }
                                },
                                error:function(value){
                                    var toast = document.querySelector('#toast');
                                    $(toast).attr('text', '#{app_searching_err}');
                                    toast.toggle();
                                    if(typeof(paper_relation_nn_#{id}_callback) == 'function'){
                                        paper_relation_nn_#{id}_callback('searched',data,'fail');
                                    }
                                }
                            });
                        }else{
                            $('#searched_#{id}').html('');
                        }
                    }</script>"
        # funcao pes
        retorno += "<script>
                        function deleteRelation_#{id}(){
                        var element = document.querySelector('#search_#{id}_'+to_delete_relation_id_#{id});
                        var toast;
                        $.ajax({
                            method:'DELETE',
                            url: '#{urlDelete}'+to_delete_relation_id_#{id}+'/',
                            type: 'json',
                            data: {'action':'DELETE'},
                            beforeSend: function(){
                                $(element).css('background-color','#eeeeee');
                            },
                            success: function(data){
                                $(element).remove();
                                toast = document.querySelector('#toast');
                                total_#{id} -=1;
                                setTotal#{id}();
                                $(toast).attr('text', '#{app_relation_nn_removed}');
                                toast.toggle();
                                //console.log(data);
                                if(typeof(paper_relation_nn_#{id}_callback) == 'function'){
                                    paper_relation_nn_#{id}_callback('deleted',data,'success');
                                }
                            },
                            error:function(value){
                                toast = document.querySelector('#toast');
                                //console.log(value);
                                if(value.responseText == 'success'){
                                    $(element).remove();
                                    Materialize.toast('#{app_relation_nn_removed}', 3000);
                                }else{
                                    //console.log('error');
                                    $(element).css('background-color','');
                                    $(toast).attr('text', '#{app_relation_nn_removed_error}');
                                    Materialize.toast('#{app_relation_nn_removed_error}', 3000);
                                }
                                if(typeof(paper_relation_nn_#{id}_callback) == 'function'){
                                    paper_relation_nn_#{id}_callback('deleted',value,'fail');
                                }
                            }
                        });
                    }</script>"
        retorno += "<script>
                        function addRelation_#{id}(value,name){
                        $.ajax({
                            method:'get',
                            url: '#{urlAdd}',
                            type: 'json',
                            data: {
                                #{table}: {#{addRelationLeftColumn}: value,#{addRelationColumn}: '#{addRelationId}' }
                            },
                            beforeSend: function(){
                                $('#searched_#{id}').html('');
                                $('#search_#{id}').val(name);
                                document.querySelector('#search_#{id}_input').disabled = true;
                                $('#searched_#{id}').append(\"<a href='#' class='collection-item'>#{app_saving}...</a>\");
                            },
                            success: function(data){
                                $('#searched_#{id}').html('');
                                document.querySelector('#search_#{id}_input').disabled = false;
                                $('#relation_list_dialog_adding_#{id}').modal('close');
                                console.log('sucess',data);
                                try{
                                    total_#{id} +=1;
                                    setTotal#{id}();
                                    $('#added_#{id}').append(\"<a href='#' id='search_#{id}_\"+data.id+\"' class='collection-item'><div>\"+data.#{field}+\"<div href='#' class='secondary-content'><i class='material-icons tooltipped' data-position='bottom' data-tooltip='#{app_delete}' onclick=\\\"setToDelete#{id}(\'\"+data.id+\"\')\\\">clear</i></div></div></a>\");
                                }catch(err ){
                                    $('#searched_#{id}').html('');
                                    $('#searched_#{id}').append(\"<a href='#' class='collection-item'><div>#{app_relation_nn_adding_error}<div href='#' class='secondary-content'><i class='material-icons tooltipped' data-position='bottom' data-tooltip='#{app_delete}'>cloud_queue</i></div></div></a>\");
                                    Materialize.toast('#{app_relation_nn_adding_error}', 3000);
                                }
                                try{
                                    $('#empty_#{id}').remove();
                                }catch(err){
                                }
                                if(typeof(paper_relation_nn_#{id}_callback) == 'function'){
                                    paper_relation_nn_#{id}_callback('created',data,'success');
                                }
                            },
                            error:function(value){
                                $('#searched_#{id}').html('');
                                document.querySelector('#search_#{id}_input').disabled = false;
                                $('#relation_list_dialog_adding_#{id}').modal('close');
                                Materialize.toast('#{app_relation_nn_adding_error}', 3000);
                                $('#searched').append(\"<a href='#' class='collection-item'><div>#{app_relation_nn_adding_error}<div href='#' class='secondary-content'><i class='material-icons tooltipped' data-position='bottom' data-tooltip='#{app_delete}'>cloud_queue</i></div></div></a>\");
                                if(typeof(paper_relation_nn_#{id}_callback) == 'function'){
                                    paper_relation_nn_#{id}_callback('created',data,'fail');
                                }
                            }
                        });
                    }"
        retorno +="$(document).ready(function(){list_#{id}();})</script>"
        retorno.html_safe
    end


    # Contrói o uploader para realizar o envio de arquivos
    #
    # === Parametros
    #
    # - label:: 					String 			com a label
    # - f:: 							FormHelper 	do formulário
    # - field_name::			String 			nome do campo
    # - icon::						String 			opcional com o icone
    # - multiple_files::	Boolean			permite ou não enviar mais de um arquivo
    #
	def paper_upload_file label,f,field_name,icon="cloud_download",multiple_files=false
        retorno = "<div class='row'>
                        <div class='file-field input-field'>
                          <div class='btn'>
                            <span>#{label} <i class='material-icons'>attach_file</i></span>"
        retorno += f.file_field field_name, multiple: multiple_files
        retorno +="       </div>
                          <div class='file-path-wrapper'>
                            <input class='file-path validate' type='text'>
                          </div>
                        </div>
                    </div>"
		retorno.html_safe
	end

    # Contrói o uploader para realizar o envio de arquivos
    #
    # === Parametros
    #
    # - label:: 					String 			com a label
    # - icon::						String 			opcional com o icone
    def paper_download_file label, path_file,icon="file_download",
        retorno = "<div class='row'>
                    <a href='#{path_file}' download class='waves-effect waves-light btn'><i class='material-icons right'>#{icon}</i> #{label}</a>
                </div>"
        retorno.html_safe
    end

    # Constroi um editor de texto para o
    # 	o sistema atHome
    # === Parametros
    #
    # - label:: 			String 			com a label
    # - f:: 					FormHelper 	do formulário
    # - field_name::	String 			nome do campo
    # - value:: 			String/Int 	com o valor do campo
    #
	def paper_editor label,f,field_name,value,icon="account_balance"
        retorno = "
            <div class='row' style='display: flex;'>
                <div class='input-field col s12'>
                    <i class='material-icons prefix'>#{icon}</i>
                    <div class='class_editor cke_focus' name='editor_#{field_name}' id='editor_#{field_name}' style='margin-left: 45px;'>#{value}</div>
                    <input type='hidden' name='#{f.object_name}[#{field_name}]'  id='#{f.object_name}_#{field_name}'>
                </div>
            </div>
            <style>
                .cke_editable{font-family: 'Times New Roman', Georgia, Serif; !important;font-weight: 300;min-height:150px;clear:both !important;border: 1px #757575 solid;}
            </style>
            <script>
                $(document).ready(function( evt ) {
                    var editorElement = CKEDITOR.document.getById( 'editor_#{field_name}' );
                    editorElement.setAttribute( 'contenteditable', 'true' );
                    setTimeout(function(){
                        CKEDITOR.instances.editor_#{field_name}.on('change',function(){
                            $('##{f.object_name}_#{field_name}').val(CKEDITOR.instances.editor_#{field_name}.getData())
                        })
                        $('##{f.object_name}_#{field_name}').val(CKEDITOR.instances.editor_#{field_name}.getData())
                    }, 3000);
                });
            </script>"
		retorno.html_safe
	end

	def paper_chooser_file label,f,field_name,value,files,icon="editor:insert-photo",url_to_upload='/system/files/new'
		app_helper_paper_choose_file = t "app_helper_paper_choose_file"
		app_cancel = t "app_cancel"
		app_ok = t "app_ok"

		retorno = "
				<div class='horizontal layout start'>
						<div class='one' style='margin-right:20px;margin-bottom:2px;'>
							<iron-icon icon='#{icon}'></iron-icon>
							<paper-tooltip>#{label}</paper-tooltip>
						</div>
						<div class='flex'>
							<div style='cursor:pointer' onClick=\"document.querySelector('#dialog_chooser_#{field_name}').toggle()\" class='horizontal layout end'>
								<paper-material elevation='1' style='padding:5px'>
									<iron-image id='image_show_#{field_name}' src='#{value}' sizing='contain' style='width:250px;height:250px'></iron-image>
								</paper-material>
								<paper-fab icon='image:collections' style='position: relative; margin-left: -30px; margin-bottom: -20px;'></paper-fab>
							</div>
							<input type='hidden' value='#{value}' name='#{f.object_name}[#{field_name}]' id='#{f.object_name}_#{field_name}'  />
						</div>
				</div>
				<paper-dialog style='width:70%;' id='dialog_chooser_#{field_name}' modal >
				<h2>#{app_helper_paper_choose_file}</h2>
				<div class='horizontal layout start'>
						<paper-tabs class='flex' selected='0' style='border-bottom: #fafafa 1px solid;'>
							<paper-tab onclick=\"document.querySelector('#pages_#{field_name}').selected=0\">Imagens</paper-tab>
							<paper-tab onclick=\"document.querySelector('#pages_#{field_name}').selected=1\">Url</paper-tab>
							<paper-tab onclick=\"document.querySelector('#pages_#{field_name}').selected=2\">Upload</paper-tab>
						</paper-tabs>
				</div>
				<div class='horizontal layout start' style='min-height:250px'>
					<iron-pages class='flex' selected='0' id='pages_#{field_name}'>
						<div >"
		files.each do |file|

        type = file.content_type.split('.')
        type = type[type.length-1]
        type = type.downcase
        case type

            when 'pdf','doc','docx'
                url_file_to_show = 'http://placehold.it/350x150/00796B/ffffff/?text='+type
            else
                url_file_to_show = "/data/"+file.name
            end

			if file.original_name.length > 12
				name_file = file.original_name[0,14]+"..."
			else
				name_file =file.original_name
			end

			retorno += " <paper-card onClick=\"card_selected#{field_name}(this,'#{file.name}','#{url_file_to_show}')\" style='cursor:pointer;max-width: 250px;margin-bottom: 15px;' heading='#{name_file}' image='#{url_file_to_show}'>
										</paper-card>"
		end

		retorno+="</div>
                    <div>
                        <div class='horizontal layout start'>
                            <div class='flex'>
                                <div class='horizontal layout end'>
                                    <paper-icon-button icon='http' style='fill:steelblue;'></paper-icon-button>
                                    <paper-input class='flex' onkeyup='setURL#{field_name}(this.value,this.value)'></paper-input>
                                </div>
                            </div>
                        </div>
                        <div class='horizontal layout center-justified'>
                            <iron-image class='flex' id='image_#{field_name}' style='width:300px;height:300px' sizig='cover'></iron-image>
                        </div>
                    </div>
                    <div style='text-align:center'>
                        <iron-image src='/assets/system/upload.png' onclick=\"location.href='#{url_to_upload}'\" sizing='contain' style='cursor:pointer;width:250px;height:250px'></iron-image>
                    </div>
                <iron-pages>
            </div>
                <div class='buttons'>
                    <paper-button dialog-dismiss>#{app_cancel}</paper-button>
                    <paper-button dialog-confirm>"+ t('app_understood')+"</paper-button>
                </div>
            </paper-dialog>

            <script>
                function setURL#{field_name}(input_in,image){
                    document.querySelector('##{f.object_name}_#{field_name}').value = input_in;
                    document.querySelector('#image_#{field_name}').src = input_in;
                    document.querySelector('#image_show_#{field_name}').src = image;
                }
                function card_selected#{field_name}(obj,url,image){
                    obj.elevation = 1;
                    document.querySelector('##{f.object_name}_#{field_name}').value = url;
                    document.querySelector('#dialog_chooser_#{field_name}').toggle();
                    document.querySelector('#image_show_#{field_name}').src = image;
                }
            </script>"

        retorno.html_safe
	end

	# Cria uma lista de valores sem id útil para listas de mongodb
	#
	# === Parametros
	#
	# - label::          String      nome dado ao chooser
	# - f::              former      formulário padrão
	# - field_name::     String      nome do campo
	# - values::         Array       com os valores possíveis
	# - icon::           String      opcional, adiciona um icon
	def paper_array_list label, f, field_name, values, icon='build'
		app_back = t "app_back"
		app_delete = t "app_delete"
		app_add = t"app_add"
		retorno = "<paper-material style='margin-bottom:20px' elevation='1'>
                        <div class='layout horizontal center' style='margin-top:20px'>
                                <div class='flex'>
                                    <paper-icon-item>
                                        <div item-icon style='display:inline-block'>
                                            <iron-icon icon='#{icon}'></iron-icon>
                                            <paper-tooltip >#{label}</paper-tooltip>
                                        </div>
                                        <paper-item-body two-line>
                                            <div>#{label}</div>
                                            <div id='list_size_#{field_name}' secondary></div>
                                        </paper-item-body>
                                        <div style='display:inline-block'>
                                            <paper-icon-button icon='av:playlist-add' onclick='openArraytDialog#{field_name}()' class='system_color'></paper-icon-button>
                                            <paper-tooltip >#{app_add} #{label}</paper-tooltip>
                                        </div>
                                    </paper-icon-item>
                                </div>
                        </div>
                        <div class='layout horizontal start' style='padding: 0px 55px;'>
                            <div class='flex'>
                                  <paper-menu selected='0' class='layout vertical start' id='array_list_added_#{field_name}' >"
                                  position=0
                                            if values != nil
                                      values.each do |value|
                                        retorno+="<paper-item style='width: 100%'><div class='flex'>#{value}</div><paper-icon-button icon='remove-circle-outline' onclick='setToDeleteservices(#{position})' class='system_danger_color'></paper-icon-button></paper-item>"
                                        position +=1
                                      end
                                            end
                        retorno+="</paper-menu>
                            </div>
                        </div>
        </paper-material>"
        retorno +="<paper-dialog id='array_dialog_#{field_name}' modal style='min-width:50%'>
                                        <h2>"+t("app_add")+" #{label}</h2>
                                        <paper-dialog-scrollable>
                                            <div class='horizontal layout start'>
                                                    <div class='flex'>
                                                            <paper-input id='to_add_at_array#{field_name}' onkeypress='enter_pressed_#{field_name}(event)' label='#{label}'></paper-input>
                                                    </div>
                                                    <div class='one'>
                                                            <paper-icon-button icon='save' onclick='add_to_array_#{field_name}()' style='margin-top: 20px;'></paper-icon-button>
                                                    </div>
                                            </div>
                                            <div class='layout vertical' id='list_array_add_#{field_name}'>
                                            </div>
                                        </paper-dialog-scrollable>
                                        <div class='buttons'>
                                            <paper-button dialog-confirm>#{app_back}</paper-button>
                                        </div>
                                </paper-dialog>"
        if values == nil
            values = []
        end
        value_on_input = ""
        values.each do |value|
            value_on_input += value+","
        end
        retorno+="<input type='hidden' value='#{value_on_input}' name='#{f.object_name}[#{field_name}]'  id='#{f.object_name}_#{field_name}'>"
        retorno+="
            <script>
                    var paper_array_list_#{field_name} = [
                    "
        if values == nil
            values = []
        end
        values.each do |value|
            retorno += "\""+value+"\","
        end
        retorno+="
                ]
                function openArraytDialog#{field_name}(){
                    $('#list_array_add_#{field_name}').html('');
                    for(var a=0; a < paper_array_list_#{field_name}.length;a++){
                        $('#list_array_add_#{field_name}').append(\"<paper-item style='width: 100%;' name='\"+paper_array_list_#{field_name}[a]+\"'><iron-icon icon='#{icon}'></iron-icon><div class='flex'>\"+paper_array_list_#{field_name}[a]+\"</div><paper-icon-button class='system_danger_color' onclick='setToDelete#{field_name}(\"+a+\")' title='#{app_delete}' icon='remove-circle-outline'></paper-icon-button></paper-item>\")
                    }
                    document.querySelector('#array_dialog_#{field_name}').toggle()
                }
                function add_to_array_#{field_name}(){
                    value = $('#to_add_at_array#{field_name}').val();
                    value = value.replace('\"','');
                    value = value.replace(\"'\",'');
                    value = value.replace(',','')
                    if(value != ''){
                        paper_array_list_#{field_name}.push(value)
                        $('#list_array_add_#{field_name}').html('');
                        for(var a=0; a < paper_array_list_#{field_name}.length;a++){
                            $('#list_array_add_#{field_name}').append(\"<paper-item style='width: 100%;' name='\"+paper_array_list_#{field_name}[a]+\"'><iron-icon icon='#{icon}'></iron-icon><div class='flex'>\"+paper_array_list_#{field_name}[a]+\"</div><paper-icon-button class='system_danger_color' onclick='setToDelete#{field_name}(\"+a+\")' title='#{app_delete}' icon='remove-circle-outline'></paper-icon-button></paper-item>\")
                        }
                        $('#array_list_added_#{field_name}').html('');
                        for(var a=0; a < paper_array_list_#{field_name}.length;a++){
                            $('#array_list_added_#{field_name}').append(\"<paper-item style='width: 100%;'><div class='flex'>\"+paper_array_list_#{field_name}[a]+\"</div><paper-icon-button class='system_danger_color' onclick='setToDelete#{field_name}(\"+a+\")' title='#{app_delete}' icon='remove-circle-outline'></paper-icon-button></paper-item>\");
                        }
                        $('##{f.object_name}_#{field_name}').val(paper_array_list_#{field_name});
                        $('#to_add_at_array#{field_name}').val('')
                    }
                }
                function enter_pressed_#{field_name}(e){
                    if (e.keyCode == 13) {
                        add_to_array_#{field_name}();
                    }
                }
                function setToDelete#{field_name}(position){
                    paper_array_list_#{field_name}.splice(position, 1);
                    $('#list_array_add_#{field_name}').html('');
                    for(var a=0; a < paper_array_list_#{field_name}.length;a++){
                        $('#list_array_add_#{field_name}').append(\"<paper-item style='width: 100%;' name='\"+paper_array_list_#{field_name}[a]+\"'><iron-icon icon='#{icon}'></iron-icon><div class='flex'>\"+paper_array_list_#{field_name}[a]+\"</div><paper-icon-button class='system_danger_color' onclick='setToDelete#{field_name}(\"+a+\")' title='#{app_delete}' icon='remove-circle-outline'></paper-icon-button></paper-item>\")
                    }
                    $('#array_list_added_#{field_name}').html('');
                    for(var a=0; a < paper_array_list_#{field_name}.length;a++){
                        $('#array_list_added_#{field_name}').append(\"<paper-item style='width: 100%;'><div class='flex'>\"+paper_array_list_#{field_name}[a]+\"</div><paper-icon-button class='system_danger_color' onclick='setToDelete#{field_name}(\"+a+\")' title='#{app_delete}' icon='remove-circle-outline'></paper-icon-button></paper-item>\");
                    }
                    $('##{f.object_name}_#{field_name}').val(paper_array_list_#{field_name});
                }
            </script>
        "

        retorno.html_safe
	end

    def paper_card title_card="", description="", detail="", title_icon="attach_money", detail_icon="keyboard_arrow_up",color="green", bar_chart=[], spark_chart=[]

        id_item = title_card.clone
        id_item.gsub!(/[^0-9A-Za-z]/, "")
        id_chart = id_item+"_chart"

        sparklines = "["
        spark_chart.each do |value|
            sparklines += value.to_s+","
        end
        sparklines += "]"

        barlines = "["
        bar_chart.each do |value|
            barlines += value.to_s+","
        end
        barlines +="]"

        retorno = """
                    <div class='card' id='#{id_item}' style='text-align: center;'>
                        <div class='card-content #{color} white-text'>
                            <p class='card-stats-title'><i class='tiny material-icons'>#{title_icon}</i> #{title_card}</p>
                            <h4 class='card-stats-number'>#{description}</h4>
                            <p class='card-stats-compare'><i class='tiny material-icons'>#{detail_icon}</i> #{detail}
                            </p>
                        </div>
                        <div class='card-action #{color} darken-2'>
                            <div id='#{id_chart}' class='center-align'></div>
                        </div>
                    </div>
                    <script>
                        $(document).ready(function(){
                    """

        compose = "false"
        if bar_chart.length > 0
            compose="true"
            retorno += """
                            $('##{id_chart}').sparkline(#{barlines}, {
                                type: 'bar',
                                barColor: '#ffffff',
                                height: '25',
                                width: '100%',
                                barWidth: '7',
                                barSpacing: 2,
                                //tooltipFormat: $.spformat('{{value}}', 'tooltip-class')
                            });
            """
        end

        if spark_chart.length > 0
            retorno += """
                $('##{id_chart}').sparkline(#{sparklines}, {
                                composite: #{compose},
                                type: 'line',
                                width: '100%',
                                height: '25',
                                lineWidth: 2,
                                lineColor: '#fff3e0',
                                fillColor: 'rgba(0,0,0,0.3)',
                                highlightSpotColor: '#fff3e0',
                                highlightLineColor: '#fff3e0',
                                minSpotColor: '#f44336',
                                maxSpotColor: '#4caf50',
                                spotColor: '#fff3e0',
                                spotRadius: 4,
                                //tooltipFormat: $.spformat('{{value}}', 'tooltip-class')
                            });
            """
        end
        retorno +="})
                    </script>"
        retorno.html_safe
    end

		def paper_item_header label='label',z_depth=1
			id = label.clone
			id.gsub!(/[^0-9A-Za-z]/, "")
			retorno = "<ul id='#{id}' class='collection z-depth-#{z_depth}'>"
			retorno.html_safe
		end

		def paper_item_footer
			retorno = "</ul>"
			retorno.html_safe
		end

    def paper_item title_item="",description="",detail="",avatar="",icon='person_add',href=""
        id = title_item.clone
        id.gsub!(/[^0-9A-Za-z]/, "")
        retorno ="""
            <li id='#{id}' class='collection-item avatar'>
                <img src='#{avatar}' alt='' class='circle' style='width:42px;height:42px'>
                <span class='title'><b>#{title_item}</b></span>
                <p>#{description}
                  <br> <span class='ultra-small'>#{detail}</span>
                </p>
                <a href='#{href}' class='secondary-content'><i class='tiny material-icons'>#{icon}</i></a>
            </li>
        """
        retorno.html_safe
    end

    def paper_alert description="",icon='',color="light-blue",close=true
        close_style=""
        if not close
            close_style = "style='visibility: hidden'"
        end
        retorno ="""
            <div id='card-alert' class='card #{color}'>
              <div class='card-content white-text'>
                <p class='single-alert'>
                  <img src='#{icon}' alt='avatar' class='alert-circle responsive-img valign profile-image'/>
                  <span>#{description}</span>
                </p>
              </div>
              <button type='button' #{close_style} class='close white-text' data-dismiss='alert' onclick=\"$('#card-alert').fadeOut()\"  aria-label='Close'>
                <span aria-hidden='true'>×</span>
              </button>
            </div>
        """
        retorno.html_safe
    end

    def paper_begin_plans id="plans"
        retorno = "<section class='plans-container' id='#{id}'>
        <div class='row'>"
        retorno.html_safe
    end

    def paper_end_plans
        retorno = "</div>
        </section>"
        retorno.html_safe
    end

    def paper_plan title="BASIC", description="200.00", description_sub="", detail="Mais popular", possibles=[{:icon=>"check",:text=>"30 dias"}], button_text="Comprar Agora", button_function="", href="#", color="light-blue" , symbol="R$"
        items = ""
        possibles.each do |possible|
            items += "<li class='collection-item'><i class='tiny material-icons' >#{possible[:icon]}</i> #{possible[:text]}</li>"
        end
        retorno = """
            <article class='col s12 m6 l3'>
              <div class='card z-depth-1'>
                <div onclick=\"location.href='#{href}'\" class='card-image #{color} waves-effect'>
                  <div class='card-title'>#{title}</div>
                  <div class='price'><sup>#{symbol}</sup>#{description}<sub>#{description_sub}</sub></div>
                  <div class='price-desc'>#{detail}</div>
                </div>
                <div class='card-content'>
                  <ul class='collection'>
                    #{items}
                  </ul>
                </div>
                <div class='card-action center-align'>
                  <button #{button_function}  class='waves-effect waves-light #{color} btn'>#{button_text}</button>
                </div>
              </div>
            </article>
        """
        retorno.html_safe
    end

		def paper_range label, f, field_name, value, icon="linear_scale", disabled=false, min="0",max="100"

	        is_disabled = ""
	        if disabled == true
	            is_disabled = "disabled"
	        end

	        material_icon = ""
	        if icon != "" and icon != nil
	            material_icon = "<i class='material-icons prefix'>#{icon}</i>"
	        end

	        retorno = "<div class='row' style='margin: 0px 0px 0px 30px;'>
												<div style='margin-left: 40px;'>
													<label class='active' id='#{f.object_name}_#{field_name}_label'>#{label} #{value}</label>
												</div>
												<div class='range-field' style='display: flex;align-items: center;'>
	          								#{material_icon}
														<input #{is_disabled} name='#{f.object_name}[#{field_name}]' id='#{f.object_name}_#{field_name}' type='range' class='validate' value='#{value}' style='margin-left: 15px;'>
	        							</div>
										</div>
										<script>
											$(document).ready(function(){
												$('##{f.object_name}_#{field_name}').on('input', function() {
												    $(\"##{f.object_name}_#{field_name}_label\").html('#{label} '+this.value)
												});
											})
										</script>"
			retorno.html_safe
		end
end
