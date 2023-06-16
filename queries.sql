/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE (neutered=True) AND (escape_attempts < 3);
SELECT date_of_birth FROM animals WHERE (name = 'Agumon' OR name = 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg>10.5;
SELECT * FROM animals WHERE neutered=True;
SELECT * FROM animals WHERE (weight_kg>=10.4 AND weight_kg<=17.3);
SELECT * FROM animals WHERE (name!='Gabumon');

BEGIN;
UPDATE animals
SET species='unspecified';

ROLLBACK;

BEGIN
UPDATE animals
SET species='digimon'
WHERE name LIKE '%mon%';

UPDATE animals
SET species='pokemon'
WHERE species='';

BEGIN;
DELETE FROM animals;

ROLLBACK;

BEGIN
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP1;
UPDATE animals
SET weight_kg = weight_kg * -1;

ROLLBACK TO SP1

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

SELECT COUNT(name) FROM animals;
SELECT COUNT(name) FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT SUM(escape_attempts) FROM animals
WHERE neutered = True;

SELECT SUM(escape_attempts) FROM animals
WHERE neutered = False;

SELECT MAX(weight_kg) FROM animals
WHERE species = 'pokemon';

SELECT MIN(weight_kg) FROM animals
WHERE species = 'pokemon';

SELECT MAX(weight_kg) FROM animals
WHERE species = 'digimon';

SELECT MIN(weight_kg) FROM animals
WHERE species = 'digimon';

SELECT AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';

UPDATE animals
SET species_id = CASE
    WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
    ELSE (SELECT id FROM species WHERE name = 'Pokemon')
  END;

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name AS animal
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

SELECT s.name AS species, COUNT(*) AS animal_count
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(*) AS animal_count
FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;

SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vet ON v.vet_id = vet.id
JOIN (
  SELECT MAX(visit_date) AS last_visit
  FROM visits
  WHERE vet_id = (
    SELECT id
    FROM vets
    WHERE name = 'William Tatcher'
  )
) AS sub ON v.visit_date = sub.last_visit;

SELECT COUNT(DISTINCT animal_id) AS animal_count
FROM visits v
JOIN vets vet ON v.vet_id = vet.id
JOIN (
  SELECT id
  FROM vets
  WHERE name = 'Stephanie Mendez'
) AS sub ON vet.id = sub.id;

SELECT v.name, s.specialty
FROM vets v
LEFT JOIN specializations vs ON v.id = vs.vet_id
LEFT JOIN specializations s ON vs.specialty_id = s.id;

SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vet ON v.vet_id = vet.id
JOIN (
  SELECT id
  FROM vets
  WHERE name = 'Stephanie Mendez'
) AS sub ON vet.id = sub.id
WHERE v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY COUNT(v.animal_id) DESC
LIMIT 1;

SELECT v.name
FROM vets v
JOIN visits vs ON v.id = vs.vet_id
JOIN animals a ON vs.animal_id = a.id
WHERE v.name = 'Maisy Smith'
ORDER BY vs.visit_date
LIMIT 1;

SELECT a.name AS animal_name, v.name AS vet_name, vs.visit_date
FROM animals a
JOIN visits vs ON a.id = vs.animal_id
JOIN vets v ON vs.vet_id = v.id
WHERE vs.visit_date = (
  SELECT MAX(visit_date)
  FROM visits
);

SELECT COUNT(*) AS mismatched_visits
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vet ON v.vet_id = vet.id
LEFT JOIN specializations vs ON vet.id = vs.vet_id AND a.species_id = vs.species_id
WHERE vs.vet_id IS NULL;

SELECT s.specialty
FROM Specialties s
JOIN specializations vs ON s.id = vs.specialty_id
JOIN (
  SELECT a.species, COUNT(*) AS species_count
  FROM animals a
  JOIN visits v ON a.id = v.animal_id
  WHERE a.owner = 'Maisy Smith'
  GROUP BY a.species
  ORDER BY species_count DESC
  LIMIT 1
) AS sub ON s.id = sub.species;




