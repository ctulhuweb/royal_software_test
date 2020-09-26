class CompaniesController < ApplicationController
  def index
    contacts_subquery = Company.select("companies.id as id, count(contacts.id) as contacts_count")
      .joins(:contacts)
      .where(contacts: {user_id: permit_params[:user_id]})
      .group(:id).to_sql

    companies = Company.includes(:tags).select("contacts_count").references(:tags)
      .joins("INNER JOIN (#{contacts_subquery}) as total_contacts ON companies.id = total_contacts.id")
      .order(:name)
    render json: companies
  end
  
  # def index
  #   tags_subquery = Company.select("companies.name, companies.id,  string_agg(tags.name, ',') as total_tags")
  #     .joins(:tags)
  #     .group(:id).to_sql
  #   contacts_subquery = Company.select('companies.id, count(contacts.id) as contacts_count')
  #     .joins(:contacts)
  #     .where(contacts: {user_id: permit_params[:user_id]})
  #     .group(:id).to_sql  
    
  #   @companies = Company.select('company_tags.name, total_tags, contacts_count')
  #     .from("(#{contacts_subquery}) as total_contacts, (#{tags_subquery}) as company_tags")
  #     .where("total_contacts.id = company_tags.id")
  #     .order("company_tags.name")
  #   render json: @companies.as_json(except: :id)
  # end
    
  # def index
  #   contacts_subquery = Company.select('companies.name as name, companies.id as id, count(contacts.id) as contacts_count')
  #     .joins(:contacts)
  #     .where(contacts: {user_id: permit_params[:user_id]})
  #     .group(:id).to_sql 

  #   join_tags_sql = "INNER JOIN companies_tags ON companies_tags.company_id = total_contacts.id INNER JOIN tags ON tags.id = companies_tags.tag_id"
    
  #   @companies = Company.select("total_contacts.*, string_agg(tags.name, ',')")
  #     .from("(#{contacts_subquery}) as total_contacts").joins(join_tags_sql)
  #     .group('total_contacts.id, total_contacts.name, contacts_count')
  #   render json: @companies
  # end

  private

  def permit_params
    params.permit(:user_id)
  end
end