module HelpHelper

	# cria o cabeçalho para o ajuda
    #
    # === Parametros
    #
	# - name_section:: 		          deve ser o mesmo nome da controller que o chamará
	# - name_app::			          nome que será exibido
	# - description_app	descrição::    preve do aplicação
	def helper_header(name_section,name_app,description_app,image=nil,icon='help')
		retorno = "<section id='#{name_section}' style='width:100%'>
					<iron-collapse opened>
						<paper-card >
              <div class='card-content'>
                <div class='avatar'>
                  <iron-icon icon='#{icon}'></iron-icon>
                </div>
                <div class='title'>
                  #{name_app}
                </div>"
    if not image == nil
      retorno += "<img src='#{image}'>"
    end
    retorno += "<div style='margin-top:20px' class='medium'>#{description_app}<div>"
    retorno.html_safe
	end

	# Mostra um problema ou pergunta recorrente e a solução para o usuário
    #
    # === Parametros
    #
	# - action_name::			Nome da dúvida ou problema
	# - action_description::	descriçnao de como soluciona essa dúvida ou problema
	def helper_action action_name,action_description
		retorno = "<div class='big'> #{action_name}</div>
		          <div class='medium'>#{action_description}</div>"
		retorno.html_safe
	end

	# Pé para o helper
	def helper_footer
		retorno = "</div>
  </paper-card>
  </iron-collapse>
  </section>".html_safe
	end
end
