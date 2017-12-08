Feature: An user should be able to visit the homepage and check content

Scenario: A logged in user visit the home page and explore available content
  Given I am a registered user
  And   I log in with email : 'valid@cucumber.com' and password : 'password1234'
  When  I visit the home page
  Then  I should be on the home page
  And   I should see the user top menu

  When  I click on link Que faire à Tokyo ?
  Then  I should be on the Themes#Index
  And   The page should have a link : 'Voir les thèmes des visites'
  And   The page should have a link : 'Préparer mon voyage'
  And   I should see themes select list

  When  I click on link Une question ?
  Then  I should be on the contact form

  When  I click on link Mes voyages
  Then  I should be on the Trips#Index

  When  I click on link Mon profil
  Then  I should be on the user profile page

  When  I click on link Se déconnecter
  Then  I should be logged out


Scenario: A logged in admin visit the home page and explore available content
  Given I am a registered admin
  And   I log in with email : 'admin@cucumber.com' and password : 'password1234'
  When  I visit the home page
  Then  I should be on the home page
  And   I should see the admin top menu
  When  I click on link Admin
  Then  I should be on the admin control center
  When  I click on link Se déconnecter
  Then  I should be logged out
  And   I should be on the home page

Scenario: A guest visit the home page and explore available content
  Given I am logged out
  When  I visit the home page
  Then  I should be on the home page
  And   I should see the guest top menu

  When  I click on link Préparer mon voyage
  Then  I should be on the Themes#Index
  And   The page should have a link : 'Voir les thèmes des visites'
  And   The page should have a link : 'Préparer mon voyage'
  And   I should see themes select list

  When  I click on link Une question ?
  Then  I should be on the contact form
  And   The page should have a link : 'contact@tokyhop.fun'

  When  I click on link Se connecter
  Then  I should be on the sign-in page
  And   The page should have a button : 'Se connecter'
  And   The page should have a link : 'Se connecter via Facebook'

  When  I click on link Créer un compte
  Then  I should be on the sign-up page
  And   The page should have a button : 'Créer mon compte'
  And   The page should have a link : 'Se connecter via Facebook'

  When  I click on link Tokyhop!
  Then  I should be on the home page
