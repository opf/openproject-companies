class CompaniesController < ApplicationController
  layout "no_menu"

  before_action :require_admin, except: [:index, :show]
  before_action :get_company_by_identifier, except: [:index, :new, :create]
  before_action :get_members, only: [:edit, :update, :show]
  before_action :get_projects, only: [:edit, :update]
  before_action :get_settings

  helper :projects, :custom_fields

  def index
    @companies = Company.all.order(name: :asc)
    @custom_fields = CompanyCustomField.all.order(position: :asc)
  end

  def show
    @projects = @company.all_projects
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new company_attributes

    if @company.save
      render_attachment_warning_if_needed(@company)
      flash[:notice] = t(:notice_successful_create)

      redirect_to @company
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @company.update company_attributes
      render_attachment_warning_if_needed(@company)
      flash[:notice] = t(:notice_successful_update)

      redirect_to @company
    else
      render action: 'edit'
    end
  end

  def destroy
    @company.destroy
    flash[:notice] = t(:notice_company_deleted)

    redirect_to companies_url
  end

  def delete_member
    member = User.find(params[:member_id])
    @company.members.delete(member)

    flash[:notice] = t(:notice_company_member_deleted)

    redirect_to edit_company_path(id: @company.identifier)
  end

  def add_members
    member_ids = params[:member_ids]
    @company.member_ids += member_ids

    flash[:notice] = t(:notice_company_member_added)

    redirect_to edit_company_path(id: @company.identifier)
  end

  def filter_available_members
    @members = @company.members.sorted_alphabetically
    found = params[:q].blank? ? User.active : User.active.like(params[:q])
    @available_members = found.sorted_alphabetically.limit(100) - @members

    render partial: 'available_members'
  end

  def delete_project
    project = Project.find(params[:project_id])
    @company.projects.delete(project)

    flash[:notice] = t(:notice_company_project_deleted)

    redirect_to edit_company_path(id: @company.identifier)
  end

  def add_projects
    project_ids = params[:project_ids]
    @company.project_ids += project_ids

    flash[:notice] = t(:notice_company_project_added)

    redirect_to edit_company_path(id: @company.identifier)
  end

  def filter_available_projects
    @projects = @company.projects.sorted_alphabetically
    found = params[:q].blank? ? Project.active : Project.active.like(params[:q])
    @available_projects = found.sorted_alphabetically.limit(100) - @projects

    render partial: 'available_projects'
  end

  private

  def get_settings
    @settings = Setting.plugin_openproject_companies
  end

  def get_members
    @members = @company.members.sorted_alphabetically
    @available_members = User.active.sorted_alphabetically.limit(100) - @members
  end

  def get_projects
    @projects = @company.projects.sorted_alphabetically

    all_projects = Project.active.sorted_alphabetically.order(name: :asc).limit(100)
    @available_projects = all_projects - @projects
  end

  def get_company_by_identifier
    @company = Company.find_by!(identifier: params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def company_attributes
    custom_field_values = [params.require(:company)[:custom_field_values]]
      .reject(&:nil?)
      .map(&:permit!)
      .first

    params
      .require(:company)
      .permit(:name, :identifier, :short_description, :description, :url, :logo)
      .merge(custom_field_values: custom_field_values || {})
  end

  def default_breadcrumb
    if action_name == 'index'
      t('label_company_plural')
    else
      ActionController::Base.helpers.link_to(t('label_company_plural'), companies_path)
    end
  end

  def show_local_breadcrumb
    true
  end
end
