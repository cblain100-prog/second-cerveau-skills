---
name: trier-mails-brouillon
description: "Vide ta boîte de réception Gmail non lue jusqu'au bout : identifie chaque expéditeur (ton CRM si tu en as un, ton historique Gmail, ton dossier de contexte), rédige une réponse en brouillon dans le même fil (jamais envoyée), supprime spam et promotions, étiquette et archive le reste avec tes vraies étiquettes Gmail. Utiliser quand l'utilisateur dit \"trie mes mails jusqu'au brouillon\", \"vide mon inbox\", \"fais le tri Gmail\", \"traite mes mails non lus\", ou tape \"/trier-mails-brouillon\"."
---

# Trier les mails jusqu'au brouillon

Le skill construit en direct dans la vidéo « Rends ton entreprise AI native », en version à adapter : remplace les sources de contexte par les tiennes.

## Ce qu'il faut avant

- Gmail connecté à Claude (Personnaliser → Connecteurs → Gmail) : recherche, lecture de fil, brouillons, étiquettes, corbeille.
- Optionnel : ton CRM connecté (Notion, HubSpot, Salesforce…) pour savoir qui est qui.
- Optionnel : ton dossier de contexte (dossier clients) si tu en as un.
- La première fois, demande à l'utilisateur en une question : où vit le contexte de ses clients (CRM, dossier, rien), et s'il veut archiver les mails triés ou les laisser visibles. Note la réponse dans le dossier de contexte s'il existe.

## Étapes

1. **Ouvrir la boîte non lue** : chercher `in:inbox is:unread`, sans limite de date. Au-delà d'une quarantaine de fils, le dire en une phrase et continuer.
2. **Identifier la personne**, pour chaque mail : chercher l'expéditeur dans le CRM et le dossier clients s'ils existent, puis lire l'historique du fil Gmail. Personne inconnue : ton neutre, aucune hypothèse.
3. **Rédiger la réponse**, seulement si le mail appelle une vraie réponse humaine (pas pour un accusé de réception, une notification, une confirmation automatique). S'appuyer sur le contexte trouvé, jamais sur un prix ou un chiffre inventé. Vérifier qu'aucun brouillon n'attend déjà sur ce fil.
4. **Poser en brouillon** dans le même fil que le mail d'origine. Jamais envoyé : l'utilisateur relit et envoie lui-même.
5. **Trier et classer** : lire les vraies étiquettes Gmail de l'utilisateur (jamais une liste mémorisée). Spam et promotions non sollicitées → corbeille (récupérable 30 jours). Le reste → l'étiquette la plus proche, puis archivage (la boîte se vide au fil du tri). En cas de doute sur un mail d'une vraie personne : étiqueter et archiver, jamais supprimer.

## Règles

- Jamais d'envoi direct : uniquement des brouillons.
- Jamais de prix ou d'offre inventés.
- Le ton de l'utilisateur (lu dans son dossier de contexte s'il existe, sinon neutre et poli).
- Ne jamais supprimer le mail d'une personne identifiable en cas de doute.
- Ne pas poser un second brouillon sur un fil qui en a déjà un.

## Vérification avant de dire « fait »

Compter ce qui a vraiment été fait (brouillons créés, mails supprimés, mails étiquetés et archivés), pas le nombre de mails vus au départ.

## Confirmer

`✓ X mails traités : Y brouillons posés, Z supprimés, W étiquetés et archivés` en une ligne.
