Feature: Working Login/out system

Scenario: An user log in and then log out
  Given I am a registered user
  When  I visit the home page
  And   I click on link Se connecter
  Then  I should be on the sign-in page
  When  I fill in login form with valid@cucumber.com and password1234
  And   I click on button Se connecter !
  Then  I should be on the home page
  And   The page should have a text : 'Vous êtes connecté'
  When  I click on link Se déconnecter
  Then  I should be on the home page
  And   The page should have a text : 'Vous êtes déconnecté'

Scenario: An user log in via FB and log out
  Given I visit the home page
  When  I click on link Se connecter
  And   I log in via Facebook
  Then  I should be on the home page
  And   The page should have a text : 'Connecté avec succés depuis votre compte Facebook.'
  When  I click on link Se déconnecter
  Then  I should be on the home page
  And   The page should have a text : 'Vous êtes déconnecté'

Scenario: An user try to login with invalid credentials
  Given  I am a registered user
  When   I visit the home page
  And    I click on link Se connecter
  Then   I should be on the sign-in page
  When   I fill in login form with invalid@cucumber.com and password1234
  And    I click on button Se connecter !
  Then   I should be on the sign-in page
  And    The page should have a text : 'Email ou mot de passe invalide'
  When   I fill in login form with valid@cucumber.com and invalidpassword
  And    I click on button Se connecter !
  Then   I should be on the sign-in page
  And    The page should have a text : 'Email ou mot de passe invalide'
