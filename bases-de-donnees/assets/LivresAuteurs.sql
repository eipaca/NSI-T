DROP TABLE Ecrit;
DROP TABLE Auteur;
DROP TABLE Livre;
DROP TABLE Pays;

CREATE TABLE Auteur (
	Num_auteur	INTEGER NOT NULL UNIQUE,
	Nom_pays	TEXT,
	Nom	TEXT,
	Prenom	TEXT,
	FOREIGN KEY("Nom_pays") REFERENCES "Pays"("Nom_pays") ON UPDATE CASCADE ON DELETE CASCADE ,
	PRIMARY KEY("Num_auteur")
); 

CREATE TABLE "Livre" (
	Num_ISBN	TEXT,
	Titre	TEXT,
	Editeur	TEXT,
	Annee	INTEGER NOT NULL CHECK(Annee BETWEEN 1900 AND 2100),
	PRIMARY KEY(Num_ISBN)
);

CREATE TABLE Ecrit (
	Num_ISBN	INTEGER,
	Num_Auteur	INTEGER,
	FOREIGN KEY(Num_Auteur) REFERENCES Auteur(Num_Auteur),
	FOREIGN KEY(Num_ISBN) REFERENCES Livre(Num_ISBN),
	PRIMARY KEY(Num_Auteur,Num_ISBN)
);

CREATE TABLE "Pays" (
	"Nom_pays"	TEXT,
	"Population"	INTEGER,
	"Superficie"	INTEGER,
	PRIMARY KEY("Nom_pays")
);

INSERT INTO Pays 
VALUES
("Allemagne", 83,357),
("Argentine", 44, 2780),
("Autriche", 8, 83),
("Belgique", 11, 30),
("Canada", 38, 9985),
("Colombie", 49, 1143),
("Egypte", 98, 1000),
("Espagne", 46, 505), 
("Etats-Unis", 330, 9834),
("France", 66, 643),
("Grèce", 10, 131),
("Haïti", 11, 27),
("Ireland", 4, 70),
("Italie", 60, 301),
("Japon", 125, 377),
("Mexique", 126, 1973),
("Nigéria", 195, 923),
("Norvège", 5, 385),
("Pologne",  38, 312),
("Portugal", 10, 92),
("Republique Tchèque", 10, 78) ,
("Royaume-Uni", 65, 246),
("Russie", 114, 17100),
("Sénégal", 15, 196),
("Suède", 10 , 450);


INSERT INTO Auteur VALUES (0, "Etats-Unis", "Twain", "Mark");
INSERT INTO Livre VALUES ("978-2228887359","A la dure II", "Payot", 1993);
INSERT INTO Ecrit VALUES ("978-2228887359", 0);
INSERT INTO Livre VALUES ("978-2081509511", "Les Aventures de Huckleberry Finn", "Flammarion", 2020);
INSERT INTO Ecrit VALUES ("978-2081509511", 0);
INSERT INTO Livre VALUES ("978-2207249123", "Fondation et Empire", "Editions Denoël", 1999);
INSERT INTO Auteur VALUES (1, "Russie", "Asimov", "Isaac");
INSERT INTO Ecrit VALUES ("978-2207249123", 1);
INSERT INTO Livre VALUES ("978-2723428262", "Akira", "Glénat", 2000);
INSERT INTO Auteur VALUES (2, "Japon","Ōtomo", "Katsuhiro");
INSERT INTO Ecrit VALUES ("978-2723428262", 2);
INSERT INTO Livre VALUES ("978-2745989857", "Les Robots", "Editions Milan", 2017);
INSERT INTO Auteur VALUES (3, "France", "Martelle", "Myriam");
INSERT INTO Ecrit VALUES ("978-2745989857", 3);
INSERT INTO Auteur VALUES (4, "France", "Touache", "Sébastien");
INSERT INTO Ecrit VALUES ("978-2745989857", 4);
INSERT INTO Livre VALUES ("978-2864972662", "Astérix chez les Pictes", "Editions Albert René", 2013);
INSERT INTO Auteur VALUES (5, "France", "Goscinny", "René");
INSERT INTO Ecrit VALUES ("978-2864972662", 5);
INSERT INTO Auteur VALUES (6, "France", "Ferri", "Jean-Yves");
INSERT INTO Ecrit VALUES ("978-2864972662", 6);
INSERT INTO Auteur VALUES (7, "France", "Uderzo", "Albert");
INSERT INTO Ecrit VALUES ("978-2864972662", 7);
INSERT INTO Auteur VALUES (8, "France", "Conrad", "Didier");
INSERT INTO Ecrit VALUES ("978-2864972662", 8);
INSERT INTO Livre VALUES ("978-2221197691", "Les Monades urbaines", "Robert Laffont", 2016);
INSERT INTO Auteur VALUES (9, "Etats-Unis", "SILVERBERG", "Robert");
INSERT INTO Ecrit VALUES ("978-2221197691", 9);
INSERT INTO Livre VALUES ("978-2335008586", "Les Voyages de Gulliver", "Primento", 2015);
INSERT INTO Auteur VALUES (10, "Ireland", "Swift", "Jonathan");
INSERT INTO Ecrit VALUES ("978-2335008586", 10);
INSERT INTO Auteur VALUES (11, "France", "Ligaran", "");
INSERT INTO Ecrit VALUES ("978-2335008586", 11);
INSERT INTO Livre VALUES ("978-0141391601", "Lolita", "Penguin UK", 2012);
INSERT INTO Auteur VALUES (12, "Russie", "Nabokov", "Vladimir");
INSERT INTO Ecrit VALUES ("978-0141391601", 12);
INSERT INTO Livre VALUES ("978-2258116429", "La Nuit des temps", "Presses de la Cité", 2014);
INSERT INTO Auteur VALUES (13, "France", "BARJAVEL", "René");
INSERT INTO Ecrit VALUES ("978-2258116429", 13);
INSERT INTO Livre VALUES ("978-2072534911", "Ravage", "Editions Gallimard", 2014);
INSERT INTO Auteur VALUES (14, "France", "Barjavel", "René");
INSERT INTO Ecrit VALUES ("978-2072534911", 14);
INSERT INTO Livre VALUES ("978-2012101500", "Les Lauriers de César", "Educa Books", 2008);
INSERT INTO Ecrit VALUES ("978-2012101500", 5);
INSERT INTO Ecrit VALUES ("978-2012101500", 7);
INSERT INTO Livre VALUES ("979-1025100639", "Niourk", "French Pulp éditions", 2018);
INSERT INTO Auteur VALUES (15, "France", "Wul", "Stefan");
INSERT INTO Ecrit VALUES ("979-1025100639", 15);
INSERT INTO Livre VALUES ("978-2259221702", "Le Meilleur des mondes", "Plon", 2013);
INSERT INTO Auteur VALUES (16, "Royaume-Uni", "HUXLEY", "Aldous");
INSERT INTO Ecrit VALUES ("978-2259221702", 16);
INSERT INTO Livre VALUES ("978-2070219292", "Berlin Alexanderplatz", "Editions Gallimard", 1933);
INSERT INTO Auteur VALUES (17, "Allemagne", "Döblin", "Alfred");
INSERT INTO Ecrit VALUES ("978-2070219292", 17);
INSERT INTO Livre VALUES ("978-1439142677", "Fahrenheit 451", "Simon and Schuster", 2011);
INSERT INTO Auteur VALUES (18, "Etats-Unis", "Bradbury", "Ray");
INSERT INTO Ecrit VALUES ("978-1439142677", 18);
INSERT INTO Livre VALUES ("978-2081364509", "La Mort d'Ivan Ilitch", "Flammarion", 2015);
INSERT INTO Auteur VALUES (19, "Russie", "Tolstoï", "Léon");
INSERT INTO Ecrit VALUES ("978-2081364509", 19);
INSERT INTO Livre VALUES ("978-2207500293", "Croisière sans escale", "Editions Denoël", 1990);
INSERT INTO Auteur VALUES (20, "Royaume-Uni", "Aldiss", "Brian Wilson");
INSERT INTO Ecrit VALUES ("978-2207500293", 20);
INSERT INTO Livre VALUES ("978-2072762093", "Le Vieil Homme et la Mer", "Editions Gallimard", 2018);
INSERT INTO Auteur VALUES (21, "Etats-Unis", "Hemingway", "Ernest");
INSERT INTO Ecrit VALUES ("978-2072762093", 21);
INSERT INTO Livre VALUES ("978-2081358881", "Mrs Dalloway", "Flammarion", 2015);
INSERT INTO Auteur VALUES (22, "Royaume-Uni", "Woolf", "Virginia");
INSERT INTO Ecrit VALUES ("978-2081358881", 22);
INSERT INTO Livre VALUES ("978-1911572909", "L'Idiot", "Les Editions de Londres", 2019);
INSERT INTO Auteur VALUES (23, "Russie", "Fiodor", "Dostoïevski");
INSERT INTO Ecrit VALUES ("978-1911572909", 23);
INSERT INTO Livre VALUES ("978-2253025320", "Le Carnet d'or", "Le Livre de poche", 1980);
INSERT INTO Auteur VALUES (24, "Royaume-Uni", "Lessing", "Doris");
INSERT INTO Ecrit VALUES ("978-2253025320", 24);
INSERT INTO Livre VALUES ("978-2322185801", "Les Grandes Espérances", "BoD - Books on Demand", 2019);
INSERT INTO Auteur VALUES (25, "Royaume-Uni", "Dickens", "Charles");
INSERT INTO Ecrit VALUES ("978-2322185801", 25);
INSERT INTO Livre VALUES ("978-2012100060", "Astérix et Cléopâtre", "Dargaud", 1999);
INSERT INTO Ecrit VALUES ("978-2012100060", 5);
INSERT INTO Ecrit VALUES ("978-2012100060", 7);
INSERT INTO Livre VALUES ("978-2759902293", "Madame Bovary", "UPblisher", 2016);
INSERT INTO Auteur VALUES (26, "France", "Flaubert", "Gustave");
INSERT INTO Ecrit VALUES ("978-2759902293", 26);
INSERT INTO Livre VALUES ("978-2371131118", "Les Frères Karamazov", "Les éditions Pulsio", 2016);
INSERT INTO Auteur VALUES (27, "Russie", "Dostoïevski", "Fiodor");
INSERT INTO Ecrit VALUES ("978-2371131118", 27);
INSERT INTO Livre VALUES ("978-8190732673", "Moby Dick", "Campfire Graphic Novels", 2010);
INSERT INTO Auteur VALUES (28, "France", "Melville", "Herman");
INSERT INTO Ecrit VALUES ("978-8190732673", 28);
INSERT INTO Livre VALUES ("978-2290112168", "Demain les chiens", "J'ai Lu", 2015);
INSERT INTO Auteur VALUES (29, "Etats-Unis", "Simak", "Clifford D.");
INSERT INTO Ecrit VALUES ("978-2290112168", 29);
INSERT INTO Livre VALUES ("978-2012101685", "Le Tour de Gaule d'Astérix", "Educa Books", 2007);
INSERT INTO Ecrit VALUES ("978-2012101685", 5);
INSERT INTO Ecrit VALUES ("978-2012101685", 7);
INSERT INTO Livre VALUES ("978-0547249643", "1984", "Houghton Mifflin Harcourt", 1983);
INSERT INTO Auteur VALUES (30, "Royaume-Uni", "Orwell", "George");
INSERT INTO Ecrit VALUES ("978-0547249643", 30);
INSERT INTO Livre VALUES ("978-2371130418", "Don Quichotte", "Les éditions Pulsio", 2016);
INSERT INTO Auteur VALUES (31, "Espagne", "Cervantes", "Miguel de");
INSERT INTO Ecrit VALUES ("978-2371130418", 31);
INSERT INTO Livre VALUES ("978-2221216361", "Le Château de Lord Valentin", "Robert Laffont", 2017);
INSERT INTO Ecrit VALUES ("978-2221216361", 9);
INSERT INTO Livre VALUES ("978-2806231697", "Le Père Goriot", "Primento", 2012);
INSERT INTO Auteur VALUES (32, "France", "Balzac", "Honoré de");
INSERT INTO Ecrit VALUES ("978-2806231697", 32);
INSERT INTO Livre VALUES ("978-2081351981", "Le Procès", "Flammarion", 2014);
INSERT INTO Auteur VALUES (33, "Republique Tchèque", "Kafka", "Franz");
INSERT INTO Ecrit VALUES ("978-2081351981", 33);
INSERT INTO Livre VALUES ("978-2072457340", "L'Homme qui rétrécit", "Editions Gallimard", 2017);
INSERT INTO Auteur VALUES (34, "Etats-Unis", "Matheson", "Richard");
INSERT INTO Ecrit VALUES ("978-2072457340", 34);
INSERT INTO Livre VALUES ("978-2072455162", "Chroniques martiennes", "Editions Gallimard", 2016);
INSERT INTO Ecrit VALUES ("978-2072455162", 18);
INSERT INTO Livre VALUES ("978-2330052768", "Le Roi Lear", "Éditions Actes Sud", 2015);
INSERT INTO Auteur VALUES (35, "France", "Py", "Olivier");
INSERT INTO Ecrit VALUES ("978-2330052768", 35);
INSERT INTO Auteur VALUES (36, "Royaume-Uni", "Shakespeare", "William");
INSERT INTO Ecrit VALUES ("978-2330052768", 36);
INSERT INTO Livre VALUES ("978-2012101531", "Le Cadeau de César", "Educa Books", 2005);
INSERT INTO Ecrit VALUES ("978-2012101531", 5);
INSERT INTO Ecrit VALUES ("978-2012101531", 7);
INSERT INTO Livre VALUES ("978-2260019183", "La Planète des singes", "Julliard", 2011);
INSERT INTO Auteur VALUES (37, "France", "BOULLE", "Pierre");
INSERT INTO Ecrit VALUES ("978-2260019183", 37);
INSERT INTO Livre VALUES ("978-2215130475", "Orgueil et Préjugés", "Fleurus", 2015);
INSERT INTO Auteur VALUES (38, "Royaume-Uni", "Austen", "Jane");
INSERT INTO Ecrit VALUES ("978-2215130475", 38);
INSERT INTO Livre VALUES ("978-2330068349", "Une maison de poupée", "Éditions Actes Sud", 2016);
INSERT INTO Auteur VALUES (39, "Norvège", "Ibsen", "Henrik");
INSERT INTO Ecrit VALUES ("978-2330068349", 39);
INSERT INTO Livre VALUES ("978-0881844221", "Vermilion Sands", "Carroll & Graf Pub", 1988);
INSERT INTO Auteur VALUES (40, "Royaume-Uni", "Ballard", "J. G.");
INSERT INTO Ecrit VALUES ("978-0881844221", 40);
INSERT INTO Livre VALUES ("979-1023500448", "La Grande Traversée", "Seuil Jeunesse", 2014);
INSERT INTO Auteur VALUES (41, "France", "Demois", "Agathe");
INSERT INTO Ecrit VALUES ("979-1023500448", 41);
INSERT INTO Auteur VALUES (42, "France", "Godeau", "Vincent");
INSERT INTO Ecrit VALUES ("979-1023500448", 42);
INSERT INTO Livre VALUES ("978-2072376429", "L Étranger", "Editions Gallimard", 2012);
INSERT INTO Auteur VALUES (43, "France", "Camus", "Albert");
INSERT INTO Ecrit VALUES ("978-2072376429", 43);
INSERT INTO Livre VALUES ("978-2846825573", "L Île des morts", "POL Editeur", 2010);
INSERT INTO Auteur VALUES (44, "France", "Frémon", "Jean");
INSERT INTO Ecrit VALUES ("978-2846825573", 44);
INSERT INTO Livre VALUES ("978-2824904269", "Par-delà le mur du sommeil", "République des Lettres", 2018);
INSERT INTO Auteur VALUES (45, "Etats-Unis", "Lovecraft", "H. P.");
INSERT INTO Ecrit VALUES ("978-2824904269", 45);
INSERT INTO Livre VALUES ("978-2864972716", "Le Papyrus de César", "Editions Albert René", 2015);
INSERT INTO Ecrit VALUES ("978-2864972716", 6);
INSERT INTO Livre VALUES ("978-2820511034", "La Main de Zeï", "Bragelonne Classic", 2016);
INSERT INTO Auteur VALUES (46, "Etats-Unis", "Camp", "Lyon Sprague de");
INSERT INTO Ecrit VALUES ("978-2820511034", 46);
INSERT INTO Livre VALUES ("978-2267028133", "Beloved", "Christian Bourgois", 2015);
INSERT INTO Auteur VALUES (47, "Etats-Unis", "Morrison", "Toni");
INSERT INTO Ecrit VALUES ("978-2267028133", 47);
INSERT INTO Livre VALUES ("978-2824902371", "La Conscience de Zeno", "République des Lettres", 2015);
INSERT INTO Auteur VALUES (48, "Italie", "Svevo", "Italo");
INSERT INTO Ecrit VALUES ("978-2824902371", 48);
INSERT INTO Livre VALUES ("978-2820508935", "Delirium Circus", "Bragelonne", 2013);
INSERT INTO Auteur VALUES (49, "France", "Pelot", "Pierre");
INSERT INTO Ecrit VALUES ("978-2820508935", 49);
INSERT INTO Livre VALUES ("978-2218972324", "Médée", "Hatier", 2013);
INSERT INTO Auteur VALUES (50, "France", "Corneille", "");
INSERT INTO Ecrit VALUES ("978-2218972324", 50);
INSERT INTO Auteur VALUES (51, "France", "Faerber", "Johan");
INSERT INTO Ecrit VALUES ("978-2218972324", 51);
INSERT INTO Livre VALUES ("978-0199555918", "Nostromo", "Oxford University Press", 2009);
INSERT INTO Auteur VALUES (52, "Pologne", "Conrad", "Joseph");
INSERT INTO Ecrit VALUES ("978-0199555918", 52);
INSERT INTO Livre VALUES ("978-2277118473", "Au carrefour des étoiles", "J'ai Lu", 1997);
INSERT INTO Ecrit VALUES ("978-2277118473", 29);
INSERT INTO Auteur VALUES (53, "France", "Deutsch", "Michel");
INSERT INTO Ecrit VALUES ("978-2277118473", 53);
INSERT INTO Livre VALUES ("978-2346014453", "Le Vagabond", "BnF collection ebooks", 2016);
INSERT INTO Auteur VALUES (54, "France", "Maupassant", "Guy de");
INSERT INTO Ecrit VALUES ("978-2346014453", 54);
INSERT INTO Livre VALUES ("978-2253063193", "Les Buddenbrook", "LGF/Le Livre de Poche", 1993);
INSERT INTO Auteur VALUES (55, "Allemagne", "Mann", "Thomas");
INSERT INTO Ecrit VALUES ("978-2253063193", 55);
INSERT INTO Livre VALUES ("978-2253158677", "Les Métamorphoses", "Le Livre de Poche", 2011);
INSERT INTO Auteur VALUES (56, "Italie", "Ovide", "");
INSERT INTO Ecrit VALUES ("978-2253158677", 56);
INSERT INTO Livre VALUES ("978-2290105504", "Jack Barron et l'Éternité", "J'ai Lu", 2016);
INSERT INTO Auteur VALUES (57, "Etats-Unis", "Spinrad", "Norman");
INSERT INTO Ecrit VALUES ("978-2290105504", 57);
INSERT INTO Livre VALUES ("978-0201914658", "Hacker's Delight", "Addison-Wesley Professional", 2003);
INSERT INTO Auteur VALUES (58, "Etats-Unis", "Warren", "Henry S.");
INSERT INTO Ecrit VALUES ("978-0201914658", 58);
INSERT INTO Livre VALUES ("978-2012101418", "Astérix et les Normands", "Dargaud", 2005);
INSERT INTO Ecrit VALUES ("978-2012101418", 5);
INSERT INTO Ecrit VALUES ("978-2012101418", 7);
INSERT INTO Livre VALUES ("978-2221119709", "Le Temps incertain", "Robert Laffont", 2011);
INSERT INTO Auteur VALUES (59, "France", "JEURY", "Michel");
INSERT INTO Ecrit VALUES ("978-2221119709", 59);
INSERT INTO Livre VALUES ("978-2012101524", "Astérix en Corse", "Dargaud", 2005);
INSERT INTO Auteur VALUES (60, "France", "Goscinny", "");
INSERT INTO Ecrit VALUES ("978-2012101524", 60);
INSERT INTO Ecrit VALUES ("978-2012101524", 7);
INSERT INTO Livre VALUES ("978-2742744824", "Les Fils de la Médina", "Arles [France] : Actes sud", 2003);
INSERT INTO Auteur VALUES (61, "Egypte", "Maḥfūẓ", "Naǧīb");
INSERT INTO Ecrit VALUES ("978-2742744824", 61);
INSERT INTO Livre VALUES ("978-2258116405", "Le Grand secret", "Presses de la Cité", 2014);
INSERT INTO Ecrit VALUES ("978-2258116405", 13);
INSERT INTO Livre VALUES ("978-2012101517", "Le Devin", "Educa Books", 2010);
INSERT INTO Ecrit VALUES ("978-2012101517", 5);
INSERT INTO Ecrit VALUES ("978-2012101517", 7);
INSERT INTO Livre VALUES ("978-2253062820", "Le Noir Dessein", "Livre de poche", 1998);
INSERT INTO Auteur VALUES (62, "Etats-Unis", "Farmer", "Philip José");
INSERT INTO Ecrit VALUES ("978-2253062820", 62);
INSERT INTO Livre VALUES ("978-2012101784", "Astérix légionnaire", "Educa Books", 2011);
INSERT INTO Ecrit VALUES ("978-2012101784", 5);
INSERT INTO Ecrit VALUES ("978-2012101784", 7);
INSERT INTO Livre VALUES ("978-8832957402", "Romancero gitano", "Greenbooks editore", 2020);
INSERT INTO Auteur VALUES (63, "Espagne", "Lorca", "Federico Garcia");
INSERT INTO Ecrit VALUES ("978-8832957402", 63);
INSERT INTO Livre VALUES ("978-0201615869", "The Practice of Programming", "Addison-Wesley Professional", 1999);
INSERT INTO Auteur VALUES (64, "Canada", "Kernighan", "Brian W.");
INSERT INTO Ecrit VALUES ("978-0201615869", 64);
INSERT INTO Auteur VALUES (65, "Canada", "Pike", "Rob");
INSERT INTO Ecrit VALUES ("978-0201615869", 65);
INSERT INTO Livre VALUES ("979-1021900486", "Crime et Châtiment", "Editions Humanis", 2012);
INSERT INTO Auteur VALUES (66, "Russie", "Dostoïevski", "Fédor Mikhaïlovitch");
INSERT INTO Ecrit VALUES ("979-1021900486", 66);
INSERT INTO Livre VALUES ("978-2253031536", "La Promenade au phare", "LGF/Le Livre de Poche", 1983);
INSERT INTO Ecrit VALUES ("978-2253031536", 22);
INSERT INTO Livre VALUES ("978-2757803691", "L'Homme sans qualités", "Contemporary French Fiction", 2011);
INSERT INTO Auteur VALUES (67, "Autriche", "Musil", "Robert");
INSERT INTO Ecrit VALUES ("978-2757803691", 67);
INSERT INTO Livre VALUES ("978-2070361625", "Le Bruit et la Fureur", "Gallimard Education", 1972);
INSERT INTO Auteur VALUES (68, "Etats-Unis", "Faulkner", "William");
INSERT INTO Ecrit VALUES ("978-2070361625", 68);
INSERT INTO Livre VALUES ("000-0000000162", "Les Plus qu'humains", "adsaa", 1999);
INSERT INTO Auteur VALUES (69, "France", "Fransa", "France");
INSERT INTO Ecrit VALUES ("000-0000000162", 69);
INSERT INTO Livre VALUES ("978-2221128121", "La Main gauche de la nuit", "Robert Laffont", 2012);
INSERT INTO Auteur VALUES (70, "Etats-Unis", "GUIN", "Ursula LE");
INSERT INTO Ecrit VALUES ("978-2221128121", 70);
INSERT INTO Livre VALUES ("978-2070369218", "Mémoires d'Hadrien", "Gallimard Education", 1974);
INSERT INTO Auteur VALUES (71, "France", "Yourcenar", "Marguerite");
INSERT INTO Ecrit VALUES ("978-2070369218", 71);
INSERT INTO Livre VALUES ("978-2266006095", "Contes de l'absurde", "Presses Pocket", 1978);
INSERT INTO Auteur VALUES (72, "France", "Boulle", "Pierre");
INSERT INTO Ecrit VALUES ("978-2266006095", 72);
INSERT INTO Livre VALUES ("978-2864973270", "Astérix et la Transitalique", "Editions Albert René", 2017);
INSERT INTO Ecrit VALUES ("978-2864973270", 6);
INSERT INTO Livre VALUES ("978-2864972051","L'Odyssée d'Astérix", "Educa Books", 2008);
INSERT INTO Auteur VALUES (73, "France", "Gascony", "Rene");
INSERT INTO Ecrit VALUES ("978-2864972051", 73);
INSERT INTO Ecrit VALUES ("978-2864972051", 7);
INSERT INTO Livre VALUES ("978-2221119693", "Les Singes du temps", "Robert Laffont", 2011);
INSERT INTO Ecrit VALUES ("978-2221119693", 59);
INSERT INTO Livre VALUES ("978-2070406340", "Les Contes de Canterbury", "Gallimard Education", 2000);
INSERT INTO Auteur VALUES (74, "Royaume-Uni", "Chaucer", "Geoffrey");
INSERT INTO Ecrit VALUES ("978-2070406340", 74);
INSERT INTO Livre VALUES ("978-2371270060", "Sécheresse", "La Cheminante", 2014);
INSERT INTO Auteur VALUES (75, "Haïti", "Chenet", "Gérard");
INSERT INTO Ecrit VALUES ("978-2371270060", 75);
INSERT INTO Livre VALUES ("978-0321635747", "The Art of Computer Programming", "Addison-Wesley Professional", 1997);
INSERT INTO Auteur VALUES (76, "Etats-Unis", "Knuth", "Donald E.");
INSERT INTO Ecrit VALUES ("978-0321635747", 76);
INSERT INTO Livre VALUES ("978-2020403436", "L'Aveuglement", "Contemporary French Fiction", 2000);
INSERT INTO Auteur VALUES (77, "Portugal", "Saramago", "José");
INSERT INTO Ecrit VALUES ("978-2020403436", 77);
INSERT INTO Livre VALUES ("978-2757820919", "Le Berceau du chat", "Contemporary French Fiction", 2010);
INSERT INTO Auteur VALUES (78, "Etats-Unis", "Vonnegut", "Kurt");
INSERT INTO Ecrit VALUES ("978-2757820919", 78);
INSERT INTO Livre VALUES ("978-2371240087", "Anna Karénine", "Bibliothèque russe et slave", 2018);
INSERT INTO Ecrit VALUES ("978-2371240087", 19);
INSERT INTO Livre VALUES ("978-2213703848", "La Montagne magique", "Fayard", 2016);
INSERT INTO Ecrit VALUES ("978-2213703848", 55);
INSERT INTO Livre VALUES ("978-0785909903", "Le Domaine des dieux", "French & European Publications", 1992);
INSERT INTO Auteur VALUES (79, "France", "Goscinny", "Rene");
INSERT INTO Ecrit VALUES ("978-0785909903", 79);
INSERT INTO Ecrit VALUES ("978-0785909903", 7);
INSERT INTO Livre VALUES ("978-2020238113", "Cent ans de solitude", "Contemporary French Fiction", 1995);
INSERT INTO Auteur VALUES (80, "Colombie", "Márquez", "Gabriel García");
INSERT INTO Ecrit VALUES ("978-2020238113", 80);
INSERT INTO Livre VALUES ("978-2013230827", "Gargantua et Pantagruel", "Livre de Poche Jeunesse", 2009);
INSERT INTO Auteur VALUES (81, "France", "Rabelais", "François");
INSERT INTO Ecrit VALUES ("978-2013230827", 81);
INSERT INTO Auteur VALUES (82, "France", "Laporte", "Michel");
INSERT INTO Ecrit VALUES ("978-2013230827", 82);
INSERT INTO Auteur VALUES (83, "France", "Nadel", "Olivier-Marc");
INSERT INTO Ecrit VALUES ("978-2013230827", 83);
INSERT INTO Livre VALUES ("978-2290117965", "Contes", "J'ai Lu", 2015);
INSERT INTO Auteur VALUES (84, "Allemagne", "Grimm", "Jacob");
INSERT INTO Ecrit VALUES ("978-2290117965", 84);
INSERT INTO Auteur VALUES (85, "Allemagne", "Grimm", "Wilhelm");
INSERT INTO Ecrit VALUES ("978-2290117965", 85);
INSERT INTO Livre VALUES ("978-2352879183", "Guerre et Paix", "Archipoche", 2016);
INSERT INTO Ecrit VALUES ("978-2352879183", 19);
INSERT INTO Livre VALUES ("978-2251013039", "Énéide", "Belles Lettres", 1993);
INSERT INTO Auteur VALUES (86, "Italie", "Vergilius", "Publius Maro");
INSERT INTO Ecrit VALUES ("978-2251013039", 86);
INSERT INTO Auteur VALUES (87, "Italie", "Virgile", "");
INSERT INTO Ecrit VALUES ("978-2251013039", 87);
INSERT INTO Livre VALUES ("000-0000000097", "Seconde Fondation", "adsaa", 1979);
INSERT INTO Ecrit VALUES ("000-0000000097", 1);
INSERT INTO Livre VALUES ("978-2402281775", "Les Jeux de l'esprit", "FeniXX", 1971);
INSERT INTO Ecrit VALUES ("978-2402281775", 72);
INSERT INTO Livre VALUES ("978-1853262371", "Middlemarch", "Wordsworth Editions", 1994);
INSERT INTO Auteur VALUES (88, "Royaume-Uni", "Eliot", "George");
INSERT INTO Ecrit VALUES ("978-1853262371", 88);
INSERT INTO Livre VALUES ("978-2290080207", "Œdipe roi", "J'ai Lu", 2013);
INSERT INTO Auteur VALUES (89, "Grèce", "Sophocle", "");
INSERT INTO Ecrit VALUES ("978-2290080207", 89);
INSERT INTO Livre VALUES ("978-2246819554", "L'Amour aux temps du choléra", "Grasset", 2009);
INSERT INTO Auteur VALUES (90, "Colombie", "Márquez", "Gabriel Garcia");
INSERT INTO Ecrit VALUES ("978-2246819554", 90);
INSERT INTO Livre VALUES ("978-2070366149", "Fictions", "Gallimard Education", 1974);
INSERT INTO Auteur VALUES (91, "Argentine", "Borges", "Jorge Luis");
INSERT INTO Ecrit VALUES ("978-2070366149", 91);
INSERT INTO Livre VALUES ("978-2012100084", "Astérix chez les Bretons", "Dargaud", 2002);
INSERT INTO Ecrit VALUES ("978-2012100084", 5);
INSERT INTO Ecrit VALUES ("978-2012100084", 7);
INSERT INTO Livre VALUES ("978-2757827413", "Le Château", "Points", 2011);
INSERT INTO Ecrit VALUES ("978-2757827413", 33);
INSERT INTO Livre VALUES ("978-2072535031", "Le Voyageur imprudent", "Editions Gallimard", 2014);
INSERT INTO Ecrit VALUES ("978-2072535031", 14);
INSERT INTO Livre VALUES ("978-2072457388", "Je suis une légende", "Editions Gallimard", 2013);
INSERT INTO Ecrit VALUES ("978-2072457388", 34);
INSERT INTO Livre VALUES ("978-2290157268", "Le Maître du Haut Château", "J'ai Lu", 2017);
INSERT INTO Auteur VALUES (92, "Etats-Unis", "Dick", "Philip K.");
INSERT INTO Ecrit VALUES ("978-2290157268", 92);
INSERT INTO Livre VALUES ("978-2371240001", "Les Âmes mortes", "Bibliothèque russe et slave", 2018);
INSERT INTO Auteur VALUES (93, "Russie", "Gogol", "Nikolaï");
INSERT INTO Ecrit VALUES ("978-2371240001", 93);
INSERT INTO Livre VALUES ("978-2020314305", "Le Tambour", "Contemporary French Fiction", 1997);
INSERT INTO Auteur VALUES (94, "Allemagne", "Grass", "Günter");
INSERT INTO Ecrit VALUES ("978-2020314305", 94);
INSERT INTO Livre VALUES ("978-1921746864", "Polymath", "iMinds Pty Ltd", 2014);
INSERT INTO Auteur VALUES (95, "Belgique", "iMinds", "");
INSERT INTO Ecrit VALUES ("978-1921746864", 95);
INSERT INTO Livre VALUES ("978-2072487958", "Seigneur de lumière", "Editions Gallimard", 2014);
INSERT INTO Auteur VALUES (96, "Etats-Unis", "Zelazny", "Roger");
INSERT INTO Ecrit VALUES ("978-2072487958", 96);
INSERT INTO Livre VALUES ("978-2092532195", "Ulysse", "Nathan", 2012);
INSERT INTO Auteur VALUES (97, "France", "Montardre", "Hélène");
INSERT INTO Ecrit VALUES ("978-2092532195", 97);
INSERT INTO Livre VALUES ("000-0000000069", "Pedro Páramo", "New York : Grove Press", 1959);
INSERT INTO Auteur VALUES (98, "Mexique", "Rulfo", "Juan");
INSERT INTO Ecrit VALUES ("000-0000000069", 98);
INSERT INTO Livre VALUES ("978-0547728247", "Ubik", "Houghton Mifflin Harcourt", 2012);
INSERT INTO Ecrit VALUES ("978-0547728247", 92);
INSERT INTO Livre VALUES ("978-0132762564", "Algorithms", "Addison-Wesley Professional", 2011);
INSERT INTO Auteur VALUES (99, "Etats-Unis", "Sedgewick", "Robert");
INSERT INTO Ecrit VALUES ("978-0132762564", 99);
INSERT INTO Auteur VALUES (100, "Etats-Unis", "Wayne", "Kevin");
INSERT INTO Ecrit VALUES ("978-0132762564", 100);
INSERT INTO Livre VALUES ("978-2011179043", "Fifi Brindacier", "Hachette Romans", 2013);
INSERT INTO Auteur VALUES (101, "Suède", "Lindgren", "Astrid");
INSERT INTO Ecrit VALUES ("978-2011179043", 101);
INSERT INTO Livre VALUES ("978-2708701915", "Le monde s'effondre", "Editions Présence Africaine", 1972);
INSERT INTO Auteur VALUES (102, "Nigéria", "Achebe", "Chinua");
INSERT INTO Ecrit VALUES ("978-2708701915", 102);
INSERT INTO Livre VALUES ("978-2331035531", "La Naissance des dieux", "Glénat BD", 2017);
INSERT INTO Auteur VALUES (103, "France", "Bruneau", "Clotilde");
INSERT INTO Ecrit VALUES ("978-2331035531", 103);
INSERT INTO Auteur VALUES (104, "France", "D.", "Dim");
INSERT INTO Ecrit VALUES ("978-2331035531", 104);
INSERT INTO Auteur VALUES (105, "Italie", "Santagati", "Federico");
INSERT INTO Ecrit VALUES ("978-2331035531", 105);
INSERT INTO Auteur VALUES (106, "France", "Ferry", "Luc");
INSERT INTO Ecrit VALUES ("978-2331035531", 106);
INSERT INTO Auteur VALUES (107, "France", "Poli", "Didier");
INSERT INTO Ecrit VALUES ("978-2331035531", 107);
INSERT INTO Livre VALUES ("978-2806240187", "Hamlet", "Primento", 2012);
INSERT INTO Ecrit VALUES ("978-2806240187", 36);
INSERT INTO Livre VALUES ("978-2070402632", "Les Enfants de minuit", "Gallimard Education", 2010);
INSERT INTO Auteur VALUES (108, "Royaume-Uni", "Rushdie", "Salman");
INSERT INTO Ecrit VALUES ("978-2070402632", 108);
INSERT INTO Livre VALUES ("978-1101658055", "Dune", "Penguin", 2003);
INSERT INTO Auteur VALUES (109, "Etats-Unis", "Herbert", "Frank");
INSERT INTO Ecrit VALUES ("978-1101658055", 109);
INSERT INTO Livre VALUES ("978-2814510012", "La Couleur tombée du ciel", "Tiers Livre Éditeur", 2014);
INSERT INTO Auteur VALUES (110, "Etats-Unis", "Lovecraft", "Howard Phillips");
INSERT INTO Ecrit VALUES ("978-2814510012", 110);
INSERT INTO Livre VALUES ("978-2402282697", "L'Éducation sentimentale", "FeniXX", 1990);
INSERT INTO Auteur VALUES (111, "France", "Rincé", "Dominique");
INSERT INTO Ecrit VALUES ("978-2402282697", 111);
INSERT INTO Livre VALUES ("978-2012101555", "Obélix et Compagnie", "Educa Books", 2008);
INSERT INTO Ecrit VALUES ("978-2012101555", 5);
INSERT INTO Ecrit VALUES ("978-2012101555", 7);
INSERT INTO Livre VALUES ("978-2824709420", "Le Journal d'un fou", "Bibebook", 2013);
INSERT INTO Auteur VALUES (112, "Russie", "Gogol", "Nikolai");
INSERT INTO Ecrit VALUES ("978-2824709420", 112);
INSERT INTO Livre VALUES ("978-2253174561", "Les Hauts de Hurlevent", "Le Livre de Poche", 2012);
INSERT INTO Auteur VALUES (113, "Royaume-Uni", "Brontë", "Emily");
INSERT INTO Ecrit VALUES ("978-2253174561", 113);
INSERT INTO Livre VALUES ("978-2402255462", "La Plaie", "FeniXX", 1967);
INSERT INTO Auteur VALUES (114, "Sénégal", "Fall", "Malick");
INSERT INTO Ecrit VALUES ("978-2402255462", 114);
INSERT INTO Livre VALUES ("978-2012101562", "Astérix chez les Belges", "Dargaud", 1979);
INSERT INTO Ecrit VALUES ("978-2012101562", 5);
INSERT INTO Ecrit VALUES ("978-2012101562", 7);
INSERT INTO Livre VALUES ("978-2367881171", "Le Rouge et le Noir", "Les Éditions de l'Ebook malin", 1971);
INSERT INTO Auteur VALUES (115, "France", "Stendhal", "");
INSERT INTO Ecrit VALUES ("978-2367881171", 115);
INSERT INTO Livre VALUES ("978-1153611725", "À la recherche du temps perdu", "Books LLC, Wiki Series", 2010);
INSERT INTO Auteur VALUES (116, "Etats-Unis", "Wikipedia", "Source");
INSERT INTO Ecrit VALUES ("978-1153611725", 116);
INSERT INTO Livre VALUES ("978-2070315017", "La storia", "Editions Gallimard", 2004);
INSERT INTO Auteur VALUES (117, "Italie", "Morante", "Elsa");
INSERT INTO Ecrit VALUES ("978-2070315017", 117);
INSERT INTO Livre VALUES ("978-2130592150", "L'Homme total", "Presses Universitaires de France - PUF", 2011);
INSERT INTO Auteur VALUES (118, "France", "Karsenti", "Bruno");
INSERT INTO Ecrit VALUES ("978-2130592150", 118);