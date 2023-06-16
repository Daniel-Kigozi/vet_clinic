/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
id            INT GENERATED ALWAYS AS IDENTITY,
name          VARCHAR(250),
date_of_birth DATE,
escape_attempts INT,
neutered      BOOLEAN,
weight_kg     DECIMAL(10, 2)
);

ALTER TABLE animals
ADD species VARCHAR(255);

CREATE TABLE owners(
id          INT GENERATED ALWAYS AS IDENTITY,
full_name   VARCHAR(250),
age         INT,
PRIMARY KEY(id)
);

CREATE TABLE species(
id          INT GENERATED ALWAYS AS IDENTITY,
name        VARCHAR(250),
PRIMARY KEY(id) 
);

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY(species_id) REFERENCES species(id);

ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  age INTEGER,
  date_of_graduation DATE
);

CREATE TABLE specializations (
  vet_id INTEGER REFERENCES vets (id),
  species_id INTEGER REFERENCES species (id),
  PRIMARY KEY (vet_id, species_id)
);

ALTER TABLE animals
ADD CONSTRAINT animals_pk PRIMARY KEY (id);

CREATE TABLE visits (
  animal_id INTEGER,
  vet_id INTEGER,
  visit_date DATE,
  PRIMARY KEY (animal_id, vet_id, visit_date),
  FOREIGN KEY (animal_id) REFERENCES animals (id),
  FOREIGN KEY (vet_id) REFERENCES vets (id)
);