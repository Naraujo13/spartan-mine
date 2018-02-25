class System::Program < ActiveRecord::Base
  belongs_to :category_program
  def self.search(search)
    if search
        programs = self.all
        programs_to_return = []
        programs.each do |program|
            if I18n.t(program.locate_label).include? "#{search}"
                programs_to_return << program
            end
        end
        Kaminari.paginate_array(programs_to_return)
    else
      self.all
    end
  end
end
