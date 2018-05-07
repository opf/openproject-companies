#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2017 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2017 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See doc/COPYRIGHT.rdoc for more details.
#++

require 'spec_helper'

describe 'Edit Company', type: :feature do
  let(:company) { FactoryBot.create :company, projects: [project] }
  let(:admin) { FactoryBot.create :admin }
  let(:user) { FactoryBot.create :user }

  let(:project) { FactoryBot.create :project }
  let(:role) { FactoryBot.create :role }

  before do
    project.add_member! user, role

    company.members.push user

    login_as admin

    visit "/companies/#{company.identifier}/edit"
  end

  it "lists the company's members" do
    expect(page).to have_css(".list.members", text: user.name)
  end

  it "adds members" do
    expect(page).to have_css("#available_members", text: admin.name)
    page.find("#available_members input").set true

    within ".splitcontentright form" do
      click_on "Add"
    end

    expect(page).to have_text("Member added")
    expect(page).to have_css(".list.members", text: admin.name)
  end

  it "deletes members" do
    expect(page).to have_css(".list.members", text: user.name)

    within ".list.members" do
      click_on "Delete"
    end

    expect(page).to have_text("Member removed")
    expect(page).not_to have_css(".list.members", text: user.name)
  end
end
