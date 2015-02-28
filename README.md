# positioning_service
Positioning app created for course 1DV450 at Linnéuniversitetet

Beskrivning och instruktioner.

##REST-API
Detta REST-api ska testas i peer review 2. 

Instruktioner för att testa api:et.

1. Ladda ner projektet och kör "bundle install" och därefter "rake db:setup" i terminalen när du står i projekt-mappen.
2. Du finner en Postman Collection-fil i root-mappen namngiven "peer_review_2_postman_collection.json.postman_collection". Denna kan du använda i postman för att testa de olika tillgängliga anrop som finns.
3. Innan du börjar testar api:et måste du gå in på registreringsapplikationen och hämta en api-nyckel. Du kan logga in på en redan skapad användare med e-post: "clientUser@user.se" och lösenord: "hejhej". Härifrån hämtar du din api-nyckel.
4. I Postman kan du sedan göra anrop med hjälp av din nyskapade api-nyckel. Du ersätter headerns värde namngiven apikey, på anropen du gör. 
5. I de olika anrop som kräver en användarautentisering kommer du även att behöva mata in ett json webtoken i headern (Headerns namn är Authentication), vilket står tydligt angivet inom hakparenteser.
6. I en del anrop står det står även angivet inom hakparenteser vad som måste fyllas i för att anropet ska bli fullständigt. Exemeplvis måste id fyllas i när du begär en specifik doodle, från api:et. Detta id fick du exempelvis ut när du skapade en doodle.




##Registreringsapplikationan
Denna app används för att generera api-nycklar till användare som registrerar sig.

Instruktioner för att köra registreringsapplikationen

1. Ladda ner projektet och kör "bundle install" och därefter "rake db:setup" i terminalen när du står i projekt-mappen.

2. Som användare går man in på appens root-sida och klickar på "Registrera" för att skapa ett nytt konto med api-nyckel.

3. Efter lyckad registrering blir man automatiskt inloggad på sitt konto. Det gå räven senare att logga in på sitt konto från appen root-sida. Det går här även att ta bort sitt konto om så önskas!


4. För att logga in på administratörskontot måste man gå till '/admin_login_page' och där logga in med uppgifterna:
  Admin-epost: admin@admin.se
  Admin-lösenord: hejhej

5. Som administratör kan man logga in på en administratörssida för att se samtliga befintliga användare och deras api-nycklar. Man kan även ta bort respektive användares api-nyckel på administratörspanelen.


