<% if remotipart_submitted? %>
	//alert('submitted via remotipart')
<%	@files.each do | file | 							%>

<%		if file['id'] != '' 						  	%>

<%			if file['fileName'] == '' or file['fileName'] == nil 	%>


				//var progress                    = document.querySelector('#progress_dialog');
				//var progress_dialog_menssage    = document.querySelector('#progress_dialog_menssage');
				//changeProccess(0);
				//$(progress).css('display','');
				//$(progress_dialog_menssage).html('<h2>Erro ao enviar para servidor</h2><p>Tente mais tarde</p>');
				//progress.toggle();
<%			else 	%>

				parserFilesOnServer("<%= file['file'] %>", "<%= file['fileName']%>");

<%			end 	%>
<%		else 		%>
			alert("Nenhum Arquivo foi encaminhado. Tente novamente!");
<%		end 		%>
<% 	end 			%>
<% end %>
