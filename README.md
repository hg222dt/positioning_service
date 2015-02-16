# positioning_service
Positioning app created for course 1DV450 at Linnéuniversitetet

Beskrivning och instruktioner.

Denna app används för att generera api-nycklar till användare som registrerar sig.

Instruktioner

1. Ladda ner projektet och kör "bundle install" och därefter "rake db:setup" i terminalen när du står i projekt-mappen.

2. Som användare går man in på appens root-sida och klickar på "Registrera" för att skapa ett nytt konto med api-nyckel.

3. Efter lyckad registrering blir man automatiskt inloggad på sitt konto. Det gå räven senare att logga in på sitt konto från appen root-sida. Det går här även att ta bort sitt konto om så önskas!


4. För att logga in på administratörskontot måste man gå till '/admin_login_page' och där logga in med uppgifterna:
  Admin-epost: admin@admin.se
  Admin-lösenord: hejhej

5. Som administratör kan man logga in på en administratörssida för att se samtliga befintliga användare och deras api-nycklar. Man kan även ta bort respektive användares api-nyckel på administratörspanelen.


