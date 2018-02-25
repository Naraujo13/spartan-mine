# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
User.create(:email=>"admin@domum.com",:password => "30271255", :password_confirmation => "30271255", :first_name => "Administrador", :last_name => "do Sistema", :admin =>true, :born => DateTime.strptime("2009/01/19", "%Y/%m/%d"), :confirmed_at => "2017-06-06 12:08:23",:access_token=>"8a19e072")
User.create(:email=>"user@domum.com",:password => "30271255", :password_confirmation => "30271255", :first_name => "Usuário", :last_name => "do Sistema", :admin =>false, :born => DateTime.strptime("1988/07/08", "%Y/%m/%d"), :confirmed_at => "2017-06-06 12:08:23",:access_token=>"3bd9210a")

# Categorias de Programas
System::CategoryProgram.create(:id=>1, :locate_label => "menu_category_applications" ,:icon=>"apps")
System::CategoryProgram.create(:id=>2, :locate_label => "menu_category_configuration" ,:icon=>"settings")
System::CategoryProgram.create(:id=>3, :locate_label => "menu_category_permissions" ,:icon=>"security")
System::CategoryProgram.create(:id=>4, :locate_label => "menu_category_examples" ,:icon=>"code")
System::CategoryProgram.create(:id=>5, :locate_label => "menu_category_help" ,:icon=>"build")

# Programas - Aplicação
System::Program.create(:id=>1,:locate_label=> "menu_program_profile" ,:description=>"", :path=>"/users/edit", :icon=>"account_circle", :category_program_id=>1, :visible=>true, :position => 3)
System::Program.create(:id=>2,:locate_label=> "menu_program_accounts" ,:description=>"", :path=>"/accounts", :icon=>"supervisor_account", :category_program_id=>1, :visible=>true, :position => 2)
System::Program.create(:id=>3,:locate_label=> "menu_program_files", :description=>"", :path=>"/system/files", :icon=>"file_upload", :category_program_id=>1, :visible=>true, :position => 1)
System::Program.create(:id=>23,:locate_label=> "menu_program_vouchers" ,:description=>"", :path=>"/system/vouchers", :icon=>"card_giftcard", :category_program_id=>1, :visible=>true, :position => 4)

# Programas - Configurações
System::Program.create(:id=>4,:locate_label=> "menu_program_category", :description=>"", :path=>"/system/category_programs", :icon=>"menu", :category_program_id=>2, :visible=>true, :position => 5)
System::Program.create(:id=>5,:locate_label=> "menu_program_programs", :description=>"", :path=>"/system/programs", :icon=>"apps", :category_program_id=>2, :visible=>true, :position => 6)
System::Program.create(:id=>6,:locate_label=> "menu_program_bugs", :description=>"", :path=>"/system/bugs", :icon=>"bug_report", :category_program_id=>2, :visible=>true, :position => 2)
System::Program.create(:id=>7,:locate_label=> "menu_program_bug_status", :description=>"", :path=>"/system/bug_statuses", :icon=>"adb", :category_program_id=>2, :visible=>true, :position => 3)
System::Program.create(:id=>8,:locate_label=> "menu_program_bug_messages", :description=>"", :path=>"/system/bug_messages", :icon=>"notifications", :category_program_id=>2,:visible=>false, :position => 4)
System::Program.create(:id=>21,:locate_label=> "menu_program_updater" , :description=>"", :path=>"/system/updater", :icon=>"update", :category_program_id=>2, :visible=>true, :position => 1)
System::Program.create(:id=>22,:locate_label=> "menu_program_config", :description=>"", :path=>"/system/configs", :icon=>"tune", :category_program_id=>2,:visible=>true, :position => 6)

# Programas - Permissões de Acesso
System::Program.create(:id=>9,:locate_label=> "menu_program_permissions" , :description=>"", :path=>"/system/access_tos", :icon=>"notifications", :category_program_id=>3, :visible=>true, :position => 4)
System::Program.create(:id=>10,:locate_label=> "menu_program_permissions_nested", :description=>"", :path=>"/system/access_to_nested_resources", :icon=>"device_hub", :category_program_id=>3,:visible=>false, :position => 5)
System::Program.create(:id=>11,:locate_label=> "menu_program_group_access", :description=>"" ,:path=>"/system/group_accesses", :icon=>"group", :category_program_id=>3, :visible=>true, :position => 1)
System::Program.create(:id=>12,:locate_label=> "menu_program_group_access_programs", :description=>"", :path=>"/system/group_access_programs", :icon=>"group", :category_program_id=>3, :visible=>false, :position => 3)
System::Program.create(:id=>13,:locate_label=> "menu_program_group_access_person" , :description=>"", :path=>"/system/group_access_people", :icon=>"group", :category_program_id=>3, :visible=>false, :position => 2)

# Programas - Exemplos
System::Program.create(:id=>14, :locate_label => "menu_program_posts" , :description=>"", :path=>"/example/posts", :icon=>"attach_file", :category_program_id=>4, :visible=>true, :position => 2)
System::Program.create(:id=>15,:locate_label=> "menu_program_tags", :description=>"", :path=>"/example/tags", :icon=>"chat", :category_program_id=>4, :visible=>true, :position => 3)
System::Program.create(:id=>16,:locate_label=> "menu_program_category" , :description=>"", :path=>"/example/categories", :icon=>"turned_in", :category_program_id=>4, :visible=>true, :position => 1)

# Programas - Tags
Example::Tag.create(:title => "Tag 1")
Example::Tag.create(:title => "Tag 2")
Example::Tag.create(:title => "Tag 3")
Example::Tag.create(:title => "Tag 4")
Example::Tag.create(:title => "Tag 1")
Example::Tag.create(:title => "Tag 7")
Example::Tag.create(:title => "Tag 6")
Example::Tag.create(:title => "Tag 8")
Example::Tag.create(:title => "Tag 9")
Example::Tag.create(:title => "Tag 10")
Example::Tag.create(:title => "Tag 11")
Example::Tag.create(:title => "Tag 12")
Example::Tag.create(:title => "Tag 13")
Example::Tag.create(:title => "Tag 14")
Example::Tag.create(:title => "Tag 15")


# Programas - Suporte e Ajuda
System::Program.create(:id=>17,:locate_label=> "menu_program_developer_info", :description=>"", :path=>"/system/developer", :icon=>"code", :category_program_id=>5, :visible=>true, :position => 2)
System::Program.create(:id=>18,:locate_label=> "menu_program_central", :description=>"", :path=>"/help", :icon=>"code", :category_program_id=>5,:visible=>true, :position => 1)
System::Program.create(:id=>19,:locate_label=> "menu_program_bug_report", :description=>"", :path=>"/system/bugs", :icon=>"code", :category_program_id=>5,:visible=>true, :position => 3)
System::Program.create(:id=>20,:locate_label=> "menu_program_about" , :description=>"", :path=>"/system/about", :icon=>"info_outline", :category_program_id=>5, :visible=>true, :position => 4)

# Groups of Access
System::GroupAccess.create(:id=>1, :name=> I18n.t("access_group_manangers"), :description=>"Acesso para os Gerentes do Sistema",:active=>true)
System::GroupAccess.create(:id=>2, :name=> I18n.t("access_group_users"), :description=>"Acesso para os Usuários do Sistema",:active=>true)

# Programs at Groups of Access
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>2)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>3)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>4)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>5)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>6)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>7)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>8)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>9)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>10)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>11)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>12)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>13)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>17)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>21)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>22)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=>23)

System::GroupAccessProgram.create(:system_group_accesses_id=>2, :system_programs_id=>1)
System::GroupAccessProgram.create(:system_group_accesses_id=>2, :system_programs_id=>8)
System::GroupAccessProgram.create(:system_group_accesses_id=>2, :system_programs_id=>14)
System::GroupAccessProgram.create(:system_group_accesses_id=>2, :system_programs_id=>15)
System::GroupAccessProgram.create(:system_group_accesses_id=>2, :system_programs_id=>16)
System::GroupAccessProgram.create(:system_group_accesses_id=>2, :system_programs_id=>18)
System::GroupAccessProgram.create(:system_group_accesses_id=>2, :system_programs_id=>19)
System::GroupAccessProgram.create(:system_group_accesses_id=>2, :system_programs_id=>20)

# Acessos por Grupo
System::GroupAccessPerson.create(:users_id=>1, :system_group_access_id=>1)
System::GroupAccessPerson.create(:users_id=>1, :system_group_access_id=>2)
System::GroupAccessPerson.create(:users_id=>2, :system_group_access_id=>2)

# Acessos Individual
System::AccessTo.create(:user_id=>2,:program_id=>9)

# Bug Status
System::BugStatus.create(:description=>"Aberto")
System::BugStatus.create(:description=>"Fechado")
System::BugStatus.create(:description=>"Em Análise Técnica")

# categories
Example::Category.create(:description=>"Personal");
Example::Category.create(:description=>"Professional");
Example::Category.create(:description=>"Others");

# System Config
System::Config.create(:name_sort=>"Doumun",:name_company => "Domum Company", :address_company => "Pelotas, Rio Grande do Sul", :country_company=> "Brazil",:email_company=>"contact@domum.com",:phone_company=>"+5553888-888-888",:terms_of_user_last_change=>"08/20/2016",:privacity_last_change=>"08/20/2016",:at_home_version_repository=>"glaucomunsberg/atHome",:google_maps_id=>"AIzaSyB2eyObsdE3SRARbRna057qCthKK7BmD9U",:google_analytics_id=>"UA-71952071-2",:system_color=>"#01579b",:system_color_disabled=>"#039be5",:system_danger_color=>"#f04b57",:country_code=>"55",:email_user =>"email@domum.com",:email_password => "password")

# custom your seeds
eval(File.read('db/custom_seeds.rb'))
