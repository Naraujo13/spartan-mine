module ItemsHelper
    def items_list_item register_id, register_description, collection_id, register_edit_path, icon="account_balance", deletable=true, elements=[], format_strftime = '%d %b %Y %H:%m:%S'
        
         collection = Collection.where(id: collection_id).take
         if collection != nil
            collection_name = collection.name
         else
            collection_name = " - "
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
 
         retorno = "<a href='#' class='collection-item avatar' style='min-height: 65px !important;' id='field_#{register_id}'><div style='margin-right: 70px;cursor:pointer' onClick=\"document.location.href='#{register_edit_path}'\" >#{icon_list}<p class='title' style='color:black;font-weight: 300;text-transform: capitalize !important;' >#{register_description}</p><p style='font-size: 13px; color: gray;'>#{collection_name}</p></div><div href='#'class='secondary-content'>"
 
         if deletable
             retorno += "<i class='material-icons' to_delete_id='#{register_id}' onClick=\"dialog_confirmation_#{@page_index}('#{register_id}')\" style='color: black;cursor:pointer'>delete</i>"
         end
 
         retorno += string_elements
 
         retorno += "</div></a>"
 
         retorno.html_safe
     end

end
