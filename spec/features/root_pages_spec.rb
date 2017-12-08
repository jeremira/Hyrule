require 'rails_helper'

RSpec.feature "RootPages", type: :feature do
  scenario "it do stuff" do
    visit root_path
    expect(page).to have_content 'Tokyhop'
  end

end
