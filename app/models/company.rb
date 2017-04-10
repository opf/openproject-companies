class Company < ActiveRecord::Base
  has_and_belongs_to_many :members, :class_name => 'User'
  has_and_belongs_to_many :projects
  has_one :logo,
          -> { where("#{Attachment.table_name}.description = 'logo'") },
          :class_name => "Attachment",
          :as => :container,
          :dependent => :destroy

  validates_presence_of :name, :identifier, :short_description
  validates_uniqueness_of :identifier
  validates_format_of :identifier, :with => /\A(?!\d+$)[a-z0-9\-_]*\z/

  acts_as_customizable
  acts_as_attachable :view_permission => :view_companies

  after_save :attach_logo

  def to_param
    @to_param ||= identifier.to_s
  end

  def has_custom_values?
    custom_values.any?{ |c| c.value.present? }
  end

  def attachments_deletable?(user = User.current)
    return user.admin?
  end

  def attachments_visible?(user = User.current)
    true
  end

  def project
    nil
  end

  def logo=(logo_file)
    logo.destroy if logo
    @logo_file = logo_file
  end

  def logo_file_exists?
    logo && FileTest.exists?(logo.diskfile) && logo.image?
  end

  def all_projects
    if Setting.plugin_chiliproject_companies['auto_calculate_proyects']
      pr = []
      self.members.each do |u|
        pr << u.project_ids
      end
      Project.find(pr.uniq, :order => 'name')
    else
      self.projects.sorted_alphabetically
    end
  end

  private

  def attach_logo
    Attachment.attach_files(self, "1" => {'file' => @logo_file, 'description' => 'logo'}) if @logo_file
  end

end
