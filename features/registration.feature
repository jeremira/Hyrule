Feature: As a first time visitor, I can create an account and log in to the site.

Scenario: A visitor create an account with valid credential
  Given I visit the home page
  When  I click on link Créer un compte
  Then  I should be on the sign up page
  When  I register my new account with valid credential
  Then  I should be on the home page
  And   The page should have a text : 'Bienvenue. Votre compte a été créé avec succés.'
  And   I should see the user top menu

Scenario: A visitor try to create an account with invalid credential
  Given I visit the home page
  When  I click on link Créer un compte
  Then  I should be on the sign up page
  When  I register my new account with invalid credential
  Then   The page should have a text : 'Une erreur a empéché d'enregistrer ce utilisateur :'
  And   I should see the guest top menu

Scenario: A visitor create an account using the Connect via Facebook feature
  Given I visit the home page
  When  I click on link Créer un compte
  Then  I should be on the sign up page
  When  I create a new account via Facebook
  Then  I should be on the home page
  And   The page should have a text : 'Connecté avec succés depuis votre compte Facebook.'
  And   I should see the user top menu
