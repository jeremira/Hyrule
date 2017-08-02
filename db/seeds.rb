# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Theme.create(
name:      'Shibuya',
descr:     "Quartier vibrant de Tokyo, célèbre pour son carrefour bondé, Shibuya est le quartier de la mode et de la jeunesse.",
image:     "shibuya000.jpg",
gallery:   "shibuya001.jpg shibuya002.jpg shibuya003.jpg shibuya004.jpg shibuya005.jpg shibuya006.jpg shibuya007.jpg shibuya008.jpg",
style:     "tokyo"
)
Theme.create(
name:      'Shinjuku',
descr:     "Le coeur nocturne de Tokyo, Shinjuku,  et son quartier rouge, Kabuchiko, font face au quartier des affaires où s'èlevent les gratte-ciels.",
image:     "shinjuku001.jpg",
gallery:   "shinjuku002.jpg shinjuku003.jpg shinjuku004.jpg shinjuku005.jpg",
style:     "tokyo"
)
Theme.create(
name:      'Asakusa',
descr:     "Le long de la rivière Sumida s'étend le quartier d'Akasuka : complexe de temples majestueux et ruelles commerçantes.",
image:     "akasuka001.jpg",
gallery:   "asakusa002.jpg asakusa003.jpg asakusa004.jpg asakusa005.jpg",
style:     "tokyo"
)
Theme.create(
name:      'Chiyoda',
descr:     "Au centre de Tokyo, ce quartier offre des visages très différents : des jardins impèriaux au quartier électonique d'Akihabara en passant par les très chics rues commerciales de Ginza",
image:     "kanda001.jpg",
gallery:   "kanda002.jpg kanda003.jpg kanda004.jpg kanda005.jpg",
style:     "tokyo"
)
Theme.create(
name:      'Ueno',
descr:     "Quartier populaire de Tokyo centré autour d'un gigantesque parc parsemé de charmants temples.",
image:     "ueno001.jpg",
gallery:   "ueno002.jpg ueno003.jpg",
style:     "tokyo"
)
Theme.create(
name:      'Roppongi',
descr:     "Proche de la tour de Tokyo et du magnifique temple Sozoji, ce quartier à la vie nocturne agité ravira les amoureux des grandes villes.",
image:     "roppongi001.jpg",
gallery:   "roppongi002.jpg roppongi003.jpg roppongi004.jpg roppongi005.jpg",
style:     "tokyo"
)

Theme.create(
name:      'Foodies',
descr:     "Amoureux de nourritures et de boissons, découvrons la gastronomie japonaise en visitant la ville.",
image:     "food12.jpg",
gallery:   "food01.jpg food02.jpg food03.jpg food4.jpg",
style:     "theme"
)
Theme.create(
name:      'Otaku',
descr:     "Manga, anime cinema et musique. Visitez la ville sous son angle le plus Pop.",
image:     "anime001.jpg",
gallery:   "anime002.jpg anime003.jpg",
style:     "theme"
)
Theme.create(
name:      'Tradition & Culture',
descr:     "Artisanat, traditions ancéstrales et passé historique glorieux font de Tokyo une ville riche à découvrir.",
image:     "tradi001.jpg",
gallery:   "tradi002.jpg tradi003.jpg tradi004.jpg tradi005.jpg",
style:     "theme"
)

Theme.create(
name:      'Hakone',
descr:     "Station balnéaire célèbre pour ses onsens à deux pas de Tokyo, Hakone est une charmante région montagneuse parsemée de lacs et de volcans.",
image:     "hakone001.jpg",
gallery:   "hakone001.jpg",
style:     "around"
)
Theme.create(
name:      'Kamakura',
descr:     "Ancienne capitale, Kamakura abrite de nombreux temples et monastère magnifique. Une magnifique journée pour se reposer de la folie Tokyoite.",
image:     "kamakura001.jpg",
gallery:   "kamakura002.jpg kamajura003.jpg kamakura 004.jpg kamakura 005.jpg",
style:     "around"
)
Theme.create(
name:      'Yokohama',
descr:     "Cette ville portuaire proche de Tokyo abrite le vibrant et délicieux quartier chinois.",
image:     "yokohama001.jpg",
gallery:   "yokohama002.jpg yokohama003.jpg yokohama004.jpg yokohama005.jpg",
style:     "around"
)
Theme.create(
name:      'Nikko',
descr:     "bldsqdkone est une charmante région montagneuse parsemée de lacs et de volcans.",
image:     "nikko001.jpg",
gallery:   "nikko001.jpg",
style:     "around"
)
Theme.create(
name:      'Mont Fuji',
descr:     "Station dqsdqsdte région montagneuse parsemée de lacs et de volcans.",
image:     "fuji001.jpg",
gallery:   "fuji001.jpg",
style:     "around"
)
