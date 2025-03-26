# projekt_databaser
Projektnamn: Carlson Hotel. <BR>
Skapad av Henrik Karlsson och Mattias Karlsson.

Databasen är döpt till Carlson Hotel för ändamålet att hantera data för gästinformation, bokningar av rum, tilläggstjänster, betalningar samt loggning av bokningshändelser.

I databasen har också skapats funktioner för att hantera ankomstlistor, bokningslogg samt användaråtkomst och behörigheter.

ER-diagram: Huvudentiteterna är Gäst, Rum, Bokning, Service och betalning. Mellan Bokning och service blev det en många till många-relation, därför lades det till en kopplingstabell med namn Booking-service. Utöver dessa finns två svaga entiteter med namn Room-Type och PayMethod. Dessa har skapats för att underlätta uppdateringar. Till sist har en tabell för kundlogg skapats som registrerar nytillkomna bokningar samt förändringar i bokningar. Detta för att kunna avläsa historik och åtgärda problem.

Funktionaliteter:  ankomstlista har skapats för att underlätta för receptionspersonal att förbereda de dagliga ankomsterna av gästerna. Bokningslogg har skapats för att spåra händelser och enklare kunna åtgärda problem. 

Säkerhetsåtgärder som införts är skapandet av användare med begränsade rättigheter. Även en lagrad procedur för hämtning av ankomstlista har skapats. Det har skapats triggers för loggningar. För datavalidering används CHECK, till exempel säkerställandet att utcheckning måste vara större än incheckning. 

Datatypererna: NOT NULL, UNIQUE och DEFAULT används för att säkerställa datakvalitet. 

Användare kan bara logga in lokalt, genom att vi använder localhost.
