json.extract! item, :id, :item_id, :name, :references, :year, :status, :lenght, :height, :width, :thickness, :aquisition_date, :outer_circumference, :inner_circumference, :weight, :conservation_sate, :biography, :description, :created_at, :updated_at
json.url item_url(item, format: :json)
