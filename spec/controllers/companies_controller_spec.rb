#-- copyright
# OpenProject ProtoPlugin Plugin
#
# Copyright (C)2016-2017 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License version 3.
#
# OpenProject Backlogs is a derivative work based on ChiliProject Backlogs.
# The copyright follows:
# Copyright (C) 2010-2011 - Emiliano Heyns, Mark Maglana, friflaj
# Copyright (C) 2011 - Jens Ulferts, Gregor Schmidt - Finn GmbH - Berlin, Germany
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

describe CompaniesController, type: :controller do
  let(:user) { FactoryBot.create :admin }

  let!(:companies) { FactoryBot.create_list :company, 5 }

  before do
    login_as user
  end

  render_views

  describe "index" do
    before do
      get :index
    end

    it "lists existing companies" do
      companies.each do |company|
        expect(response.body).to have_text company.name
      end
    end

    it "shows Companies' short descriptions" do
      companies.each do |company|
        expect(response.body).to have_text company.short_description
      end
    end

    it "shows Company custom fields" do
      pending("figure out how to enhance custom fields factory")
      companies.each do |company|
        expect(response.body).to have_text company.custom_field_values.first.value
      end
    end

    it 'renders a template' do
      expect(response).to be_success
      expect(response).to render_template 'companies/index'
    end
  end
end
