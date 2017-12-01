require "rails_helper"

RSpec.feature "Widget management", :type => :feature do
  describe "access top page" do
    it "can sign in user with facebook account" do
      visit new_user_registration_url
      expect(page).to have_link("Se connecter via Facebook")

      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        'provider' => 'facebook',
        'uid' => '123545',
        'info' => {
          'email' => 'test@test.fr',
        },
        'credentials' => {
          'token' => 'mock_token',
          'secret' => 'mock_secret'
        }
      })
      click_link "Se connecter via Facebook"
      expect(page).to have_content "Mon profil"
      expect(page.current_url).to eq root_url
      expect(User.last.email).to eq 'test@test.fr'
    end
  end
end
