class CompaniesController < ApplicationController
  def index
    tags_subquery = Company.select("companies.name, companies.id,  string_agg(tags.name, ',') as total_tags").joins(:tags).group(:id).to_sql
    contacts_subquery = Company.select('companies.id, count(contacts.id) as contacts_count').joins(:contacts).where(contacts: {user_id: permit_params[:user_id]}).group(:id).to_sql  
    
    @companies = Company.select('company_tags.name, total_tags, contacts_count').from("(#{contacts_subquery}) as total_contacts, (#{tags_subquery}) as company_tags").where("total_contacts.id = company_tags.id").order("company_tags.name")
    render json: @companies.as_json(except: :id)
  end

  private

  def permit_params
    params.permit(:user_id)
  end
end