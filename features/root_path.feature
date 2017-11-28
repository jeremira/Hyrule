Feature: A guest visit the website

Scenario: A guest visit the home page and explore available content
  Given I am logged out
  When  I visit the home page
  Then  I must be on the home page
  Then  I must see the guest top menu
  When  I click on 'Préparer mon voyage'
  Then  I must be on the 'Theme#Index' page
  And   I must see a button 'Voir tous les thèmes de voyage'
  And   I must see a button 'Préparer mon voyage'
  And   I must see themes
  When  I click on 'Une question ?'
  Then  I must be on the home page # contact-row
  And   I must see a button 'contact@tokyhop.fun'
  When  I click on 'Se connecter'
  Then  I must be on the sign-in page
  And   I must see a button 'Se connecter'
  And   I must see a button 'Se connecter via Facebook'
  When  I click on 'Créer un compte'
  Then  I must be on the sign-up page
  And   I must see a button 'Créer mon compte'
  And   I must see a button 'Se connecter via Facebook'
  When  I click on 'Tokyhop!'
  Then  I must be on the home page
