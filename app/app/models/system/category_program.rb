class System::CategoryProgram < ActiveRecord::Base
  def self.search(search)
    if search
        categories_program              = self.all
        categories_program_to_return    = []
        categories_program.each do |category_program|
            if I18n.t(category_program.locate_label).include? "#{search}"
                categories_program_to_return << category_program
            end
        end
        Kaminari.paginate_array(categories_program_to_return)
    else
      self.all
    end
  end
end
