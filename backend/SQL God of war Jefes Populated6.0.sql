-- Si ya existe la base de datos con este nombre, la borra para empezar desde cero --
DROP DATABASE IF EXISTS SQL_Gow_Jefes;

-- Crear una nueva base de datos con este nombre --
CREATE DATABASE SQL_Gow_Jefes;

-- Le decimos a MySQL que vamos a trabajar con esa base de datos --
USE SQL_Gow_Jefes;

-- Guardamos los archivos de audio de los diálogos que tienen los jefes en combate --
CREATE TABLE `Audio_Dialogos` (
	`ID_AudioDialogo` INT AUTO_INCREMENT PRIMARY KEY, -- ID automático del audio
	`Path_AudioDialogo` VARCHAR(255) NOT NULL -- Ruta del archivo de audio (ej: "audios/jefe1.mp3")
);

-- Guarda efectos de sonido (gritos, pisadas, golpes, etc.) --
CREATE TABLE `Sonido` (
	`ID_Sonido` INT AUTO_INCREMENT PRIMARY KEY, -- ID automático
	`Path_SFX` VARCHAR(255) NOT NULL -- Ruta del archivo del sonido
);

-- Aquí se guardan los ataques normales (básicos) --
CREATE TABLE `Ataque_Normal` (
	`ID_Ataques_Normales` INT PRIMARY KEY, -- ID del ataque
	`Nombre_Ataques` VARCHAR(255) NOT NULL -- Nombre del ataque (ej: "combo_1")
);

-- Ataques especiales (se habilitan después de la primera fase) --
CREATE TABLE `Ataques_Especiales` (
	`ID_Ataque_Especial` INT PRIMARY KEY, -- ID del ataque especial
	`Nombre_Ataques_Especiales` VARCHAR(255) NOT NULL -- Nombre del ataque especial
);

-- Aquí se guarda la cinemática de transición de fase --
CREATE TABLE `Cinematica_Transicion` (
	`ID_Cinematica_Transicion` INT AUTO_INCREMENT PRIMARY KEY, -- ID automático
	`Nombre_Cinematica` VARCHAR(255) NOT NULL -- Nombre de la cinemática (ej: "Zeus pierde primer round")
);

-- Guarda información de las fases del jefe (Ataques, Especiales, Cinemáticas) --
CREATE TABLE `Fase` (
	`ID_Fase` INT AUTO_INCREMENT PRIMARY KEY, -- ID automático
	`Nombre_Fase` VARCHAR(255) NOT NULL, -- Nombre de la primera fase
	`ID_Ataques_Normales` INT, -- Ataques normales disponibles
	`ID_Ataques_Especiales` INT, -- Ataques especiales disponibles
	`ID_Cinematica_Transicion` INT NOT NULL, -- Cinemática de transición
	FOREIGN KEY (`ID_Ataques_Normales`) REFERENCES `Ataque_Normal`(`ID_Ataques_Normales`)
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY (`ID_Ataques_Especiales`) REFERENCES `Ataques_Especiales`(`ID_Ataque_Especial`)
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY (`ID_Cinematica_Transicion`) REFERENCES `Cinematica_Transicion`(`ID_Cinematica_Transicion`)
		ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- Crear la tabla donde se guardan los diálogos que dicen los jefes --
CREATE TABLE `Dialogo` (
	`ID_Dialogo` INT AUTO_INCREMENT PRIMARY KEY, -- ID del diálogo (único)
	`ID_AudioDialogo` INT NOT NULL, -- ID del archivo de audio que se reproduce
	`ID_Fase` INT NOT NULL, -- ID de la fase donde se dice este diálogo
	FOREIGN KEY (`ID_AudioDialogo`) REFERENCES `Audio_Dialogos`(`ID_AudioDialogo`)
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY (`ID_Fase`) REFERENCES `Fase`(`ID_Fase`)
		ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- Crear la tabla donde se guardan los jefes del juego --
CREATE TABLE `Jefe` (
	`ID_Jefe` INT AUTO_INCREMENT PRIMARY KEY, -- ID único del jefe
	`Nombre_Jefe` VARCHAR(255) NOT NULL, -- Nombre del jefe
	`Descripcion_Jefe` VARCHAR(255) NOT NULL, -- Texto que describe al jefe
	`Vida_Jefe` INT NOT NULL, -- Cantidad de vida que tiene el jefe
	`Recompensa_Jefe` VARCHAR(255) NOT NULL, -- Qué gana el jugador al vencerlo
	`ID_Dialogo` INT NOT NULL, -- Qué diálogo dice este jefe
	`ID_Sonido` INT NOT NULL, -- Sonidos especiales del jefe
	`ID_Fase` INT NOT NULL, -- Primera fase del jefe
	`ID_Fase2` INT NOT NULL, -- Segunda fase del jefe
	FOREIGN KEY (`ID_Dialogo`) REFERENCES `Dialogo`(`ID_Dialogo`)
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY (`ID_Sonido`) REFERENCES `Sonido`(`ID_Sonido`)
		ON UPDATE NO ACTION ON DELETE NO ACTION,
	FOREIGN KEY (`ID_Fase`) REFERENCES `Fase`(`ID_Fase`)
		ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- Poblar tabla Audio_Dialogos --
INSERT INTO Audio_Dialogos (Path_AudioDialogo) VALUES

('Audio/Dialogues/Poseidon.mp3'),
('Audio/Dialogues/Hades.mp3'),
('Audio/Dialogues/Helios.mp3'),
('Audio/Dialogues/Hermes.mp3'),
('Audio/Dialogues/Hercules.mp3'),
('Audio/Dialogues/Cronos.mp3'),
('Audio/Dialogues/Hephaestus.mp3'),
('Audio/Dialogues/Skorpius.mp3'),
('Audio/Dialogues/Zeus.mp3'),
('Audio/Dialogues/Hydra.mp3'),
('Audio/Dialogues/Medusa.mp3'),
('Audio/Dialogues/Dessert Syrens.mp3'),
('Audio/Dialogues/Cerberus Breeder.mp3'),
('Audio/Dialogues/Pandoras Guardian.mp3'),
('Audio/Dialogues/Ares.mp3'),
('Audio/Dialogues/Colossus of Rhodes.mp3'),
('Audio/Dialogues/Typhon.mp3'),
('Audio/Dialogues/Dark Raider and Dark Griffin.mp3'),
('Audio/Dialogues/Theseus.mp3'),
('Audio/Dialogues/Barbarian King.mp3'),
('Audio/Dialogues/Mole Cerberus.mp3'),
('Audio/Dialogues/Euryale.mp3'),
('Audio/Dialogues/Perseus.mp3'),
('Audio/Dialogues/Icarus.mp3'),
('Audio/Dialogues/The Last Spartan.mp3'),
('Audio/Dialogues/Kraken.mp3'),
('Audio/Dialogues/Lahkesis and Atropos.mp3'),
('Audio/Dialogues/Clotho.mp3');

-- Poblar tabla Sonido --
INSERT INTO Sonido (Path_SFX) VALUES

('sfx/Poseidon.mp3'),
('sfx/Hades.mp3'),
('sfx/Helios.mp3'),
('sfx/Hermes.mp3'),
('sfx/Hercules.mp3'),
('sfx/Cronos.mp3'),
('sfx/Hephaestus.mp3'),
('sfx/Skorpius.mp3'),
('sfx/Zeus.mp3'),
('sfx/Hydra.mp3'),
('sfx/Medusa.mp3'),
('sfx/Desert Syrens.mp3'),
('sfx/Cerberus Breeder.mp3'),
('sfx/Pandoras Guardian.mp3'),
('sfx/Ares.mp3'),
('sfx/Colossus of Rhodes.mp3'),
('sfx/Typhon.mp3'),
('sfx/Dark Raider and Dark Griffin.mp3'),
('sfx/Theseus.mp3'),
('sfx/Barbarian King.mp3'),
('sfx/Mole Cerberus.mp3'),
('sfx/Euryale.mp3'),
('sfx/Perseus.mp3'),
('sfx/Icarus.mp3'),
('sfx/The Last Spartan.mp3'),
('sfx/Kraken.mp3'),
('sfx/Lahkesis and Atropos.mp3'),
('sfx/Clotho.mp3');

-- Poblar tabla Ataque_Normal --
INSERT INTO Ataque_Normal (ID_Ataques_Normales, Nombre_Ataques) VALUES

(1, 'tidal lash'),                         -- Poseidon
(2, 'spectral strike'),                    -- Hades
(3, 'solar arrow'),                        -- Helios
(4, 'blazing dash'),                       -- Hermes
(5, 'devastating punch'),                  -- Hercules
(6, 'colossal slam'),                      -- Cronos
(7, 'molten hammer blow'),                 -- Hephaestus
(8, 'venomous sting'),                     -- Skorpius
(9, 'heavenly bolt'),                      -- Zeus
(10, 'tail sweep'),                        -- Hydra
(11, 'freezing gaze'),                     -- Medusa
(12, 'piercing wail'),                     -- Dessert Syrens
(13, 'chain toss'),                        -- Cerberus Breeder
(14, 'flame-back strike'),                 -- Pandora's Guardian
(15, 'fiery smash'),                       -- Ares
(16, 'iron stomp'),                        -- Colossus of Rhodes
(17, 'frost breath'),                      -- Typhon
(18, 'sky charge'),                        -- Dark Raider and Dark Griffin
(19, 'dual thrust'),                       -- Theseus
(20, 'brutal cleave'),                     -- Barbarian King
(21, 'feral bite'),                        -- Mole Cerberus
(22, 'stone stare'),                       -- Euryale
(23, 'aerial slash'),                      -- Perseus
(24, 'chaotic shove'),                     -- Icarus
(25, 'spartan charge'),                    -- The Last Spartan
(26, 'tentacle lash'),                     -- Kraken
(27, 'temporal ripple'),                   -- Lahkesis and Atropos
(28, 'flesh slam');    					   -- Clotho

-- Poblar tabla Ataques_Especiales --
INSERT INTO Ataques_Especiales (ID_Ataque_Especial, Nombre_Ataques_Especiales) VALUES

(1, 'tsunami wrath'),                     -- Poseidon
(2, 'soul vortex'),                       -- Hades
(3, 'solar flare burst'),                -- Helios
(4, 'divine acceleration'),              -- Hermes
(5, 'pillar quake'),                     -- Hercules
(6, 'earth-crushing stomp'),             -- Cronos
(7, 'lava eruption'),                    -- Hephaestus
(8, 'scorpion swarm'),                   -- Skorpius
(9, 'storm of judgment'),                -- Zeus
(10, 'hydra head lunge'),                -- Hydra
(11, 'stone gaze blast'),                -- Medusa
(12, 'siren’s scream'),                  -- Dessert Syrens
(13, 'infernal hound release'),          -- Cerberus Breeder
(14, 'flaming shoulder charge'),         -- Pandora's Guardian
(15, 'blade storm'),                     -- Ares
(16, 'fiery core beam'),                 -- Colossus of Rhodes
(17, 'blizzard breath'),                 -- Typhon
(18, 'skyfall slam'),                    -- Dark Raider and Dark Griffin
(19, 'arena spike trap'),                -- Theseus
(20, 'ghost warrior summon'),            -- Barbarian King
(21, 'volcanic bite blast'),             -- Mole Cerberus
(22, 'gorgon gaze explosion'),           -- Euryale
(23, 'mirror decoy strike'),             -- Perseus
(24, 'plunge into chaos'),               -- Icarus
(25, 'spartan fury'),                    -- The Last Spartan
(26, 'abyssal tentacle storm'),          -- Kraken
(27, 'time distortion wave'),            -- Lahkesis and Atropos
(28, 'flesh-consuming slam');            -- Clotho

-- Poblar tabla Cinematica_Transicion --
INSERT INTO Cinematica_Transicion (Nombre_Cinematica) VALUES

('Poseidon’s appearance with hippocampus'),
('Hades emerge from the underworld'),
('Solar blinding by Helios'),
('Chase of Hermes'),
('Hercules enters the coliseum'),
('Ascent through Cronos body'),
('Hephaestus activates the forge'),
('Skorpius bursts into the arena'),
('Zeus descends with lightning'),
('Hydra breaks the ship’s mast'),
('Medusa’s petrifying gaze'),
('Dessert Syrens’ illusory song'),
('Cerberus Breeder releases the beasts'),
('Pandora’s Guardian emerges from fire'),
('Ares summons the battlefield'),
('Awakening of the Colossus of Rhodes'),
('Typhon unleashes the wind'),
('Dark Griffin covers the skies'),
('Theseus blocks the labyrinth gate'),
('Barbarian King reappears'),
('Mole Cerberus erupts from the ground'),
('Euryale appears among broken columns'),
('Perseus turns invisible'),
('Icarus falls from the ceiling'),
('The Last Spartan joins the battle'),
('Kraken emerges from the portal'),
('Lahkesis and Atropos temporarily split'),
('Clotho activates the Loom');

-- Poblar tabla Fase --
INSERT INTO Fase (Nombre_Fase, ID_Ataques_Normales, ID_Ataques_Especiales, ID_Cinematica_Transicion) VALUES

("Poseidon's Hippocampus Assault", 1, 1, 1),
("Poseidon God of the Seas", 1, 1, 1),
("Hades in the Throne Room", 2, 2, 2),
("Hades in the Stygian Depths", 2, 2, 2),
("Helios Flying on His Chariot", 3, 3, 3),
("Helios Cornered by Kratos", 3, 3, 3),
("Hermes Taunting on the Bridge", 4, 4, 4),
("Hermes Desperate Sprint", 4, 4, 4),
("Hercules in the Coliseum", 5, 5, 5),
("Hercules with Nemean Cestus", 5, 5, 5),
("Cronos Awakens", 6, 6, 6),
("Climbing the Titan Cronos", 6, 6, 6),
("Hephaestus at the Forge", 7, 7, 7),
("Hephaestus Strikes Back", 7, 7, 7),
("Skorpius Emerges from the Sand", 8, 8, 8),
("Skorpius Venom Rage", 8, 8, 8),
("Zeus in the Throne Hall", 9, 9, 9),
("Zeus Final Showdown", 9, 9, 9),
("Hydra Breaks the Mastil", 10, 10, 10),
("Hydra Triple Attack", 10, 10, 10),
("Medusa’s Petrifying Gaze", 11, 11, 11),
("Medusa’s Serpent Wrath", 11, 11, 11),
("Desert Sirens’ Song", 12, 12, 12),
("Sirens Summon the Storm", 12, 12, 12),
("Cerberus Breeder’s Whip", 13, 13, 13),
("Cerberus Pup Release", 13, 13, 13),
("Guardian of Pandora Appears", 14, 14, 14),
("Pandora’s Guardian Flame", 14, 14, 14),
("Ares in the Temple of Pandora", 15, 15, 15),
("Final Battle against Ares", 15, 15, 15),
("Colossus Awakens in Rhodes", 16, 16, 16),
("Colossus Raging Fury", 16, 16, 16),
("Typhon’s Breath", 17, 17, 17),
("Typhon’s Icy Roar", 17, 17, 17),
("Dark Griffin’s Sky Charge", 18, 18, 18),
("Dark Raider’s Ground Onslaught", 18, 18, 18),
("Theseus on the Bridge", 19, 19, 19),
("Theseus Summons Minotaurs", 19, 19, 19),
("Barbarian King’s First Blow", 20, 20, 20),
("Barbarian Soul Army", 20, 20, 20),
("Mole Cerberus Digging Out", 21, 21, 21),
("Mole Cerberus Frenzy", 21, 21, 21),
("Euryale’s Petrifying Eyes", 22, 22, 22),
("Euryale’s Snake Fang Strike", 22, 22, 22),
("Perseus’ Shield Bash", 23, 23, 23),
("Perseus’ Winged Attack", 23, 23, 23),
("Icarus’ Winged Dive", 24, 24, 24),
("Icarus’ Sun Blaze", 24, 24, 24),
("The Last Spartan’s Charge", 25, 25, 25),
("The Last Spartan’s Shield Wall", 25, 25, 25),
("Kraken’s Appears", 26, 26, 26),
("Kraken’s Whirlpool", 26, 26, 26),
("Lahkesis and Atropos’ Time Warp", 27, 27, 27),
("Lahkesis and Atropos’ Fate Strike", 27, 27, 27),
("Clotho’s Thread Weaving", 28, 28, 28),
("Clotho’s Destiny Cut", 28, 28, 28);

-- Poblar tabla Dialogo --
INSERT INTO Dialogo (ID_AudioDialogo, ID_Fase) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25),
(26, 26),
(27, 27),
(28, 28);


-- Poblar tabla Jefe --
INSERT INTO Jefe (Nombre_Jefe, Descripcion_Jefe, Vida_Jefe, Recompensa_Jefe, ID_Dialogo, ID_Sonido, ID_Fase, ID_Fase2) VALUES

('Poseidon', 'God of the seas and ruler of Atlantis', 100, 'Pleasure', 1, 1, 1, 2),
('Hades', 'God of the Dead and the Ruler of the Underworld', 200, 'Claws of Hades', 2, 2, 3, 4),
('Helios', 'Titan God of the Sun and Guardian of Oaths', 50, 'Head of Helios', 3, 3, 5, 6),
('Hermes', 'The Messenger of Mount Olympus and God of Travelers, Messengers, Thieves, Commerce, Sports, Athletics, and Speed', 50, 'Boots of Hermes', 4, 4, 7, 8),
('Hercules', ' Demigod son of Zeus and a mortal woman named Alcmene', 300, 'Nemean Cestus', 5, 5, 9, 10),
('Cronos', 'Titan of time and father of the Olympian gods', 500, 'Sand of Time', 6, 6, 11, 12),
('Hephaestus', 'God of forge and craftsmanship, master blacksmith', 150, 'Forge Hammer', 7, 7, 13, 14),
('Skorpius', 'Scorpion beast born of poison and rage', 180, 'Venom Fang', 8, 8, 15, 16),
('Zeus', 'King of Olympus and god of thunder and lightning', 600, 'Thunderbolt', 9, 9, 17, 18),
('Hydra', 'Multi-headed sea serpent, resurrecting by its own heads', 250, 'Hydra Fang', 10, 10, 19, 20),
('Medusa', 'Gorgon whose gaze turns mortals into stone', 120, 'Medusas Head', 11, 11, 21, 22),
('Desert Syrens', 'Desert-dwelling sirens whose song lures travelers', 130, 'Siren’s Song Crystal', 12, 12, 23, 24),
('Cerberus Breeder', 'Master of the hounds guarding the underworld gate', 150, 'Cerberus Collar', 13, 13, 25, 26),
('Pandoras Guardian', 'Protector of Pandora’s secret box and its horrors', 180, 'Pandora’s Key', 14, 14, 27, 28),
('Ares', 'God of war, embodies bloodlust and battlefield fury', 500, 'Blades of Ares', 15, 15, 29, 30),
('Colossus of Rhodes', 'Giant statue come to life to guard ancient Rhodes', 400, 'Colossus Shield', 16, 16, 31, 32),
('Typhon', 'Father of monsters, storm-bringer and earth-shaker', 350, 'Storm Heart', 17, 17, 33, 34),
('Dark Raider and Dark Griffin', 'Dual guardians riding into darkness atop a Griffin', 300, 'Griffin Feather', 18, 18, 35, 36),
('Theseus', 'Hero turned adversary who conquered the Minotaur', 220, 'Minotaur Helmet', 19, 19, 37, 38),
('Barbarian King', 'Warlord from distant lands, commanding savage armies', 250, 'Barbarian Crown', 20, 20, 39, 40),
('Mole Cerberus', 'Subterranean variant of Cerberus, foul and tunneling', 200, 'Cerberus Tunnel Shard', 21, 21, 41, 42),
('Euryale', 'One of the Gorgons, sister of Medusa, fierce and deadly', 150, 'Gorgon Scale', 22, 22, 43, 44),
('Perseus', 'Slayer of Medusa, armed with winged cap and reflective shield', 180, 'Mirror Shield Fragment', 23, 23, 45, 46),
('Icarus', 'Son of Daedalus, the master craftsman who built the Labyrinth of the Minotaur for King Minos', 100, 'Wings of Icarus', 24, 24, 47, 48),
('The Last Spartan', 'Survivor of a fallen Spartan army, fighting for honor', 150, 'Spartan Spear', 25, 25, 49, 50),
('Kraken', 'Legendary sea monster, terrorizing ships in deep waters', 400, 'Kraken Tentacle', 26, 26, 51, 52),
('Lahkesis and Atropos', 'Fates who spin and cut the threads of mortal lives', 300, 'Clotho’s Thread', 27, 27, 53, 54),
('Clotho', 'Spinner of destiny’s loom, guardian of mortal fates', 350, 'Fate Weave', 28, 28, 55, 56);

SELECT*FROM Jefe
WHERE ID_Jefe >= 0;