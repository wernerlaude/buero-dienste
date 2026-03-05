# README

<%# Startseite – Standard mit Sidebar %>
<div class="page">

<%# Visitenkarte Show – volle Breite %>
<div class="page page--full">

<%# Blog-Eintrag, Impressum, Datenschutz – schmal zentriert %>
<div class="page page--narrow">

<%# Blog-Index, FAQ – mittelbreit %>
<div class="page page--medium">

<%# z.B. Impressum %>
<div class="page page--narrow">
  <main class="page__main prose">
    <h1>Impressum</h1>
    <p>...</p>
    <h2>Kontakt</h2>
    <p>...</p>
  </main>
</div>

<%# Visitenkarte Show – Main nutzt volle Breite, Sidebar bleibt %>
<% content_for :main_class, "prose" %>

<%# Impressum %>
<% content_for :main_class, "prose" %>

<%# Blog-Eintrag %>
<% content_for :main_class, "prose" %>