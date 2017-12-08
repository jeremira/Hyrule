Feature: An user can create, book and pay trip.

Scenario: An user create a first new trip and pay.
  Given I am a registered user
  And   I log in with email : 'valid@cucumber.com' and password : 'password1234'
  When  I click on link Mes voyages
  And   I click on link Créer mon premier voyage
  And   I create a new trip
  Then  The page should have a text : 'Votre nouveau séjour a bien été créé.'
  And   The page should have a text : '0 journées prévues'

  Given A 'Gastronome' theme exist
  When  I click on link Ajouter une journée
  And  I add a day 'Gastronome' to a trip
  Then  The page should have a text : 'Une journée a été ajoutée à votre séjour.'
  And   The page should have a text : 'Gastronome'
  And   The page should have a text : 'Le Japon possède une culture gastronomique extraordinaire.'
  When  I click on link Organisation du séjour
  Then  The page should have a text : '1 journées prévues'

  Given A 'Tradition' theme exist
  When  I click on link Ajouter une journée
  And  I add a day 'Tradition' to a trip
  Then  The page should have a text : 'Une journée a été ajoutée à votre séjour.'
  And   The page should have a text : 'Tradition'
  And   The page should have a text : 'qui le souhaite dans un monde mystique'
  When  I click on link Organisation du séjour
  Then  The page should have a text : '2 journées prévues'

  When  I click on link Réserver mon voyage
  Then  The page should have a text : 'Merci pour votre réservation'
  When  I pay my trip
  Then  The page should have a text : 'Voyage réservé et payé !'
  And   The page should have a text : 'Voyage confirmé'
