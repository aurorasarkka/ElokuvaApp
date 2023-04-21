# Elokuva App (Oona & Aurora)

Tämä sovellus tarjoaa käyttäjille mahdollisuuden selata elokuvia, etsiä elokuvia nimeltä, lisätä niitä suosikkeihin ja poistaa niitä, rekisteröityä ja kirjautua sisään, sekä löytää satunnaisen elokuvan erillisellä painikkeella. Suuri osa sovelluksen ominaisuuksista on vain kirjautuneille käyttäjille, mistä sovellus ilmoittaa snackbar ilmoitusten muodossa. Sovelluksen käyttäminen mobiililaitteella on suositeltavaa, sillä emulaattorilla testatessa kaikki ominaisuudet eivät toimineet oikein. 

### Ominaisuudet: 
- Rekisteröinti ja kirjautuminen
- Elokuvien haku (nimellä)
- Suosikkien tallentaminen/poistaminen
- Random elokuvan hakeminen (erillinen nappi)

### Paketit (flutter pub deps)
Lisäsimme sovellukseen mm. nämä paketit: 

- **carousel_slider 4.2.1** --> etusivun kuvakaruselli
- **firebase_auth 4.4.0** --> tietojen tallennus
- **flutter 0.0.0** --> toiminta
- **material_color_utilities 0.2.0** --> sovelluksen värien hallinta

### Ulkoiset palvelut 
- **API (TMDB):** 
Valitsimme käyttää työssä TMDB:n APIa, koska se oli ilmainen ja siihen löytyi selkeä dokumentaatio mitä hyödyntää. API:sta voimme hakea elokuvia erilaisten kriteerien perusteella (suositut, top rated yms). Saamme myös elokuvien tiedot APIn perusteella, kuten näyttelijät, arvosanat, esittely tekstin, kuvat yms. 
- **Firebase:**
Käytämme Firebasea käyttäjien tallentamiseen,sekä rekisteröinnin ja kirjautumisen validointiin. Lisäksi tallennamme jokaisen käyttäjän suosikit-listan Firebase Realtime tietokantaan, mistä tiedot haetaan sovellukseen suosikit näkymään. 

### Näkymät
- Etusivu
- Rekisteröinti (latausnäkymä jää jumiin, mutta siitä voi poistua nuolen avulla)
- Kirjautuminen
- Kirjautunut käyttäjä
- Elokuvan info/tiedot
- Haku
- Suosikit
<img src="https://github.com/aurorasarkka/ElokuvaApp/blob/master/Kuvakaappaukset/Etusivu.jpeg" width=20% height=20%>
<img src="https://github.com/aurorasarkka/ElokuvaApp/blob/master/Kuvakaappaukset/Rekisteröinti.jpeg" width=20% height=20%>
<img src="https://github.com/aurorasarkka/ElokuvaApp/blob/master/Kuvakaappaukset/Kirjautuminen.jpeg" width=20% height=20%>
<img src="https://github.com/aurorasarkka/ElokuvaApp/blob/master/Kuvakaappaukset/Kirjautunut%20käyttäjä.jpeg" width=20% height=20%>
<img src="https://github.com/aurorasarkka/ElokuvaApp/blob/master/Kuvakaappaukset/Elokuva%20info.jpeg" width=20% height=20%>
<img src="https://github.com/aurorasarkka/ElokuvaApp/blob/master/Kuvakaappaukset/Haku.jpeg" width=20% height=20%>
<img src="https://github.com/aurorasarkka/ElokuvaApp/blob/master/Kuvakaappaukset/Suosikit.jpeg" width=20% height=20%>

### Linkki esimerkkikoodiin
Käytimme työn pohjana valmista GitHub repositoriota, mutta lisäsimme siihen itse uusia näkymiä ja ominaisuuksia. Lisäsimme muun muassa rekisteröinnin ja kirjautumisen, suosikki näkymän ja suosikkien merkkaamisen ja random elokuva painikkeen. Valitsimme pohjan sillä perusteella, että se hyöndynsi samaa APIa, jota halusimme käyttää työssä.

Tässä linkki alkuperäiseen sivuun: https://github.com/bimsina/Matinee-Flutter
