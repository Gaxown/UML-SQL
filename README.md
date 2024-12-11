# ITThink - Base de Données

## Contexte du Projet

**Objectif** : Concevoir une base de données efficace et bien structurée pour prendre en charge l'ensemble des fonctionnalités de *ITThink*, assurant une gestion optimale des données.

Le schéma de base de données suivant est conçu pour répondre aux besoins de *ITThink*, une plateforme mettant en relation des utilisateurs, des projets, des catégories, des sous-catégories, des freelances, des offres, et des témoignages. Les tables incluent des clés primaires, des clés étrangères, et des informations essentielles pour garantir une gestion efficace des données.

---

## Schéma de la Base de Données

### Tables

1. **Utilisateurs**
   - `id_utilisateur` (Clé primaire)
   - `nom_utilisateur`
   - `mot_de_passe` (haché)
   - `email`
   - Autres informations pertinentes

2. **Catégories**
   - `id_categorie` (Clé primaire)
   - `nom_categorie`

3. **Sous-Catégories**
   - `id_sous_categorie` (Clé primaire)
   - `nom_sous_categorie`
   - `id_categorie` (Clé étrangère vers la table `Categories`)

4. **Projets**
   - `id_projet` (Clé primaire)
   - `titre_projet`
   - `description`
   - `id_categorie` (Clé étrangère vers la table `Categories`)
   - `id_sous_categorie` (Clé étrangère vers la table `Sous-Categories`)
   - `id_utilisateur` (Clé étrangère vers la table `Utilisateurs`)

5. **Freelances**
   - `id_freelance` (Clé primaire)
   - `nom_freelance`
   - `competences`
   - `id_utilisateur` (Clé étrangère vers la table `Utilisateurs`)

6. **Offres**
   - `id_offre` (Clé primaire)
   - `montant`
   - `delai`
   - `id_freelance` (Clé étrangère vers la table `Freelances`)
   - `id_projet` (Clé étrangère vers la table `Projets`)

7. **Témoignages**
   - `id_temoignage` (Clé primaire)
   - `commentaire`
   - `id_utilisateur` (Clé étrangère vers la table `Utilisateurs`)

---

## Documentation SQL/UML

- Réaliser des diagrammes UML décrivant les entités, relations, et cardinalités.
- Documenter les requêtes SQL pour créer la structure de la base de données.

---

## User Stories du Responsable de la Base de Données

En tant que responsable de la base de données :

1. Concevoir un schéma de base de données qui répond aux besoins actuels et futurs de *ITThink*.
2. Documenter clairement les relations entre les entités à l'aide de diagrammes UML.
3. Écrire des scripts SQL pour créer la base de données conformément au schéma défini.
4. Mettre en place des procédures de sauvegarde automatiques et régulières.
5. Planifier des sessions de maintenance pour garantir des performances optimales.
6. Anticiper la croissance de la plateforme en concevant une base de données évolutive.

---

## Scripts SQL

Rédigez les scripts SQL suivants pour répondre aux besoins de la plateforme ITThink :

1. **Créer la base de données et les tables :**  
   - Tables : `Utilisateurs`, `Catégories`, `Sous-Catégories`, `Projets`, `Freelances`, `Offres`, `Témoignages`.

2. **Mise à jour des tables :**  

   - Modifier ou ajouter des champs dans une table existante, par exemple ajouter une colonne `date_creation` dans la table `Projets`.

3. **Réaliser des opérations courantes :**

   - **Insertion :** Ajouter une nouvelle offre dans la table `Offres`.  

   - **Mise à jour :** Modifier les détails d’un projet.  

   - **Suppression :** Supprimer un témoignage.  
  

4. **Requêtes de jointure :**  
   Exemple : Récupérer les détails des projets liés à une catégorie spécifique.

## Bonus et Recommandations:

- Utiliser des index pour optimiser les performances des requêtes.
- Implémenter des contraintes d'intégrité pour assurer la qualité des données.
- Considérer l'utilisation de procédures stockées pour des opérations complexes.
- Effectuer des tests de performance sur des charges simulées pour évaluer la robustesse de la base de données.

