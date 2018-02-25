
# Program Categories
System::CategoryProgram.create(:id=>6, :locate_label => "Gerenciar" ,:icon=>"apps")

# Programs
program_museum = System::Program.create(:locate_label=> "Museus", :description=>"", :path=>"/museums", :icon=>"apps", :category_program_id=>6, :visible=>true, :position => 6)
program_collection = System::Program.create(:locate_label=> "Coleções", :description=>"", :path=>"/collections", :icon=>"apps", :category_program_id=>6, :visible=>true, :position => 6)
program_items = System::Program.create(:locate_label=> "Obras", :description=>"", :path=>"/items", :icon=>"apps", :category_program_id=>6, :visible=>true, :position => 6)

# Permissions
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=> program_museum.id)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=> program_collection.id)
System::GroupAccessProgram.create(:system_group_accesses_id=>1, :system_programs_id=> program_items.id)

System::GroupAccessProgram.create(:system_group_accesses_id=>2, :system_programs_id=> program_museum.id)
System::GroupAccessProgram.create(:system_group_accesses_id=>2, :system_programs_id=> program_collection.id)
System::GroupAccessProgram.create(:system_group_accesses_id=>2, :system_programs_id=> program_items.id)

# Museus
    # Cerâmica
museum_ceramica = Museum.create(:cod_museum=>'CRA', :name=>'Museu de Cerâmica', :director_id=> 1, :technician_id=>2, 
    :address=>'Bento Gonçalves, 207 - Pelotas/RS', :phone=>'(53) 32745527', :opening_hours=>"10:00 às 16:30", 
    :description=>"Museu de Cerâmica da História Pelotense")
    # Empalhados
museum_empalhados = Museum.create(:cod_museum=>'EMP', :name=>'Museu de Empalhados', :director_id=> 1, :technician_id=>2, 
    :address=>'Santos Dummond, 1234 - Pelotas/RS', :phone=>'(53) 31245577', :opening_hours=>"9:00 às 18:00", 
    :description=>"Museu de Empalhados da Fauna Pelotense")
    # Coisas
museum_coisas = Museum.create(:cod_museum=>'COS', :name=>'Museu de Coisas', :director_id=> 1, :technician_id=>2, 
    :address=>'Algum Lugar, 123 - Pelotas/RS', :phone=>'(53) 11111111', :opening_hours=>"15:00 às 16:00", 
    :description=>"Museu de Coisas")

# Coleções
    # Cerâmica
collection_ceramica_indigena = Collection.create(:collection_id=>"CIG", :museum_id=>museum_ceramica.id, :name=>"Coleação de Cerâmica Indígena")
collection_ceramica_charqueadas = Collection.create(:collection_id=>"CCQ", :museum_id=>museum_ceramica.id, :name=>"Coleação de Cerâmica das Charqueadas")
collection_ceramica_inutil = Collection.create(:collection_id=>"CIT", :museum_id=>museum_ceramica.id, :name=>"Coleação de Cerâmica Inútil")
    # Empalhados
collection_empalhados_roedores = Collection.create(:collection_id=>"ERD", :museum_id=>museum_empalhados.id, :name=>"Coleação de Roedores Empalhados")
collection_empalhados_lagartixas = Collection.create(:collection_id=>"ELT", :museum_id=>museum_empalhados.id, :name=>"Coleação de Lagartixas Empalhadas")
collection_empalhados_mosquitos = Collection.create(:collection_id=>"EMQ", :museum_id=>museum_empalhados.id, :name=>"Coleação de Mosquitos Empalhados")
    # Coisas
collection_coisas_legais = Collection.create(:collection_id=>"CLG", :museum_id=>museum_coisas.id, :name=>"Coleação de Coisas Legais")
collection_coisas_chatas = Collection.create(:collection_id=>"CCT", :museum_id=>museum_coisas.id, :name=>"Coleação de Coisas Chatas")
collection_coisas_satanicas = Collection.create(:collection_id=>"CST", :museum_id=>museum_coisas.id, :name=>"Coleação de Coisas Satânicas")
    

# Obras
    # Cerâmica
    # Empalhados
Item.create(:item_id=>"RHG", :name=>"Hamster Gordo", :collection_id=>collection_empalhados_roedores.id, :year=>DateTime.now, :status=>"Morto",
    :lenght=>10, :height=>5, :width=>15, :thickness=>2, :outer_circumference=>20,:inner_circumference=>10, :weight=>3, 
    :conservation_state=>"Em decomposição", :biography=>"Seu nome era Hantaro e ele comia muito.", :description=>"Cadáver de Hamster Gordo chamado Hamtaro")
Item.create(:item_id=>"RRT", :name=>"Ratazana criada a Whey da Esquina", :collection_id=>collection_empalhados_roedores.id, :year=>DateTime.now, :status=>"Viva e Forte",
    :lenght=>50, :height=>20, :width=>25, :thickness=>5, :outer_circumference=>15,:inner_circumference=>5, :weight=>10, 
    :conservation_state=>"Bem cuidade", :biography=>"Ratazana chamada Jorge, sua alimentação é baseada em Whey, batata-doce e gritos apavorados.", :description=>"Ratazana Monstruosa")
Item.create(:item_id=>"LJR", :name=>"Lagartixa Jurema", :collection_id=>collection_empalhados_lagartixas.id, :year=>DateTime.now, :status=>"Viva",
    :lenght=>10, :height=>2, :width=>5, :thickness=>1, :outer_circumference=>3,:inner_circumference=>2, :weight=>0.1, 
    :conservation_state=>"Ágil", :biography=>"Ratazana chamada Jurema, mora no banheiro de sua casa.", :description=>"Lagartixa Amiga")
Item.create(:item_id=>"MBX", :name=>"Mosquito Borrachudo", :collection_id=>collection_empalhados_mosquitos.id, :year=>DateTime.now, :status=>"Rindo da sua cara",
    :lenght=>1, :height=>1, :width=>1, :thickness=>1, :outer_circumference=>0.5,:inner_circumference=>0.25, :weight=>0.01, 
    :conservation_state=>"Faminto", :biography=>"Mosquito Infernal que irá lhe atormentar a noite toda", :description=>"Mosquito que deixa picada parecendo que você apanhou")
Item.create(:item_id=>"MAE", :name=>"Aedes Aegypt", :collection_id=>collection_empalhados_mosquitos.id, :year=>DateTime.now, :status=>"Sumido",
    :lenght=>1, :height=>1, :width=>1, :thickness=>1, :outer_circumference=>0.5,:inner_circumference=>0.25, :weight=>0.01, 
    :conservation_state=>"Molhado", :biography=>"Mosquito Transmissor da Dengue, já esteve mais presente e agora se esconde em um canto húmido.", :description=>"Mosquito mais famoso do brasil, apareceu em muitos comerciais")
    # Coisas