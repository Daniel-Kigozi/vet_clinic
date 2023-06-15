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