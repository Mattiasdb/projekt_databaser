# projekt_databaser
Projektnamn: Carlson Hotel.

Skapad av Henrik Karlsson och Mattias Karlsson.

Databasen Carlson Hotel är en relationsdatabas skapad i MySQL. syftet att hantera data för gästinformation, bokningar av rum, tilläggstjänster, betalningar samt loggning av bokningshändelser.

I databasen har också skapats funktioner för att hantera ankomstlistor. Det finns Triggers för att registrera nya bokningar och ändringar av befintliga. Vi har även skapat en användare vid Anna och tilldelat behörighet och rättighet.

ER-diagram: Huvudentiteterna är Gäst, Rum, Bokning, Service och betalning. Mellan Bokning och service blev det en många till många-relation, därför lade vi till en kopplingstabell med namnet  Booking-service. Utöver dessa finns två svaga entiteter med namn Room-Type och PayMethod. Dessa skapade vi för normalisering av informationen. Till sist skapade vi en tabell för kundlogg som registrerar nytillkomna bokningar samt förändringar i bokningar. Detta för att kunna avläsa historik och åtgärda problem.

Funktionaliteter: Vi har skapat en lagrad procedur för att visa ankomstlista för ett valfritt datum. Det har skapats  för att underlätta för receptionspersonal att förbereda de dagliga ankomsterna av gästerna. Bokningslogg har skapats för att spåra händelser och därmed enklare kunna åtgärda problem. 

Säkerhetsåtgärder som införts är skapandet av användare med begränsade rättigheter. Även en lagrad procedur för hämtning av ankomstlista har skapats. Vi har skapat triggers för bokningsloggning. För datavalidering används CHECK, till exempel säkerställa att utcheckning sker efter incheckning. 

Datatypererna: NOT NULL, UNIQUE och DEFAULT används för att säkerställa datakvalitet. 

Användare kan bara logga in lokalt, genom att vi använder localhost.

Indexering: Skulle databasen vara för ett större hotell skulle vi behöva indexera mer. Just nu har vi skapat index för CheckinDate för att snabba på hämtning av ankomstlista.

Utvecklingsmöjligheter: Om vi hade haft mer tid finns enorma möjligheter att utveckla databasen, allt ifrån att förbättra kategoriseringar och beskrivning av rum till att koppla på weekendpaket, till att lägga till en tabell för personal med olika roller.

