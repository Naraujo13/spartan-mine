class ExportJsonController < ApplicationController
  def users
    users_json
  end

  def museums
    museums_json
  end

  def collections
    collections_json
  end

  def items
    items_json
  end

  private
    # -------------- JSON API -------------- #

    # All Database
    def all_json
      users_json
      museums_json
      collections_json
      items_json
    end

    # All Users
    def users_json
      data = User.all.to_json
      users_json = File.open("users.json", "w") { |f| f << data }
      send_data data, :type => 'application/json; header=present', :disposition => "attachment; filename=spartan_users_#{(Time.now.to_f * 1000).to_i}.json"
    end

    # All Museums
    def museums_json
      data = Museum.all.to_json
      museum_json = File.open("museums.json", "w") { |f| f << data }
      send_data data, :type => 'application/json; header=present', :disposition => "attachment; filename=spartan_museums_#{(Time.now.to_f * 1000).to_i}.json"

    end

    # All Collections
    def collections_json
      data = Collection.all.to_json
      colletions_json = File.open("collections.json", "w") { |f| f << data }
      send_data data, :type => 'application/json; header=present', :disposition => "attachment; filename=spartan_collections_#{(Time.now.to_f * 1000).to_i}.json"
    end

    # All Items
    def items_json
      data = Item.all.to_json
      items_json = File.open("items.json", "w") { |f| f << data }
      send_data data, :type => 'application/json; header=present', :disposition => "attachment; filename=spartan_items_#{(Time.now.to_f * 1000).to_i}.json"
    end
	
end
