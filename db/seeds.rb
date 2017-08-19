# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Theme.create(
name:      'Shibuya',
descr:     "Le coeur de la jeunesse Tokyoïte.",
image:     "shibuya.jpg",
gallery:   "shibuya000.jpg shibuya001.jpg shibuya002.jpg shibuya003.jpg shibuya004.jpg shibuya005.jpg shibuya006.jpg shibuya007.jpg shibuya008.jpg",
style:     "tokyo"
)
Theme.create(
name:      'Shinjuku',
descr:     "La ville nocturne.",
image:     "shinjuku.jpg",
gallery:   "shinjuku002.jpg shinjuku003.jpg shinjuku004.jpg shinjuku005.jpg",
style:     "tokyo"
)
Theme.create(
name:      'Asakusa',
descr:     "Tradition et modernité.",
image:     "asakusa.jpg",
gallery:   "asakusa002.jpg asakusa003.jpg asakusa004.jpg asakusa005.jpg",
style:     "tokyo"
)
Theme.create(
name:      'Chiyoda',
descr:     "Shopping impérial",
image:     "kanda.jpg",
gallery:   "kanda002.jpg kanda003.jpg kanda004.jpg kanda005.jpg",
style:     "tokyo"
)
Theme.create(
name:      'Ueno',
descr:     "Parc et pandas.",
image:     "ueno.jpg",
gallery:   "ueno002.jpg ueno003.jpg",
style:     "tokyo"
)
Theme.create(
name:      'Roppongi',
descr:     "Vie nocturne.",
image:     "roppongi.jpg",
gallery:   "roppongi002.jpg roppongi003.jpg roppongi004.jpg roppongi005.jpg",
style:     "tokyo"
)

Theme.create(
name:      'Foodies',
descr:     "Tour pour gastronomes",
image:     "food.jpg",
gallery:   "food001.jpg food002.jpg food003.jpg food004.jpg",
style:     "theme"
)
Theme.create(
name:      'Otaku',
descr:     "Le tour manga de Tokyo.",
image:     "anime.jpg",
gallery:   "anime002.jpg anime003.jpg",
style:     "theme"
)
Theme.create(
name:      'Tradition',
descr:     "Artisanat, culture, histoire & tradition .",
image:     "tradi.jpg",
gallery:   "tradi002.jpg tradi003.jpg tradi004.jpg tradi005.jpg",
style:     "theme"
)

Theme.create(
name:      'Hakone',
descr:     "Onsens et volcans.",
image:     "hakone.jpg",
gallery:   "hakone001.jpg",
style:     "around"
)
Theme.create(
name:      'Kamakura',
descr:     "Temple et nature.",
image:     "kamakura.jpg",
gallery:   "kamakura001.jpg kamakura002.jpg kamakura003.jpg kamakura004.jpg",
style:     "around"
)
Theme.create(
name:      'Yokohama',
descr:     "Ville portuaire.",
image:     "yokohama.jpg",
gallery:   "yokohama002.jpg yokohama003.jpg yokohama004.jpg yokohama005.jpg",
style:     "around"
)
Theme.create(
name:      'Nikko',
descr:     "Temples merveilleux.",
image:     "nikko.jpg",
gallery:   "nikko001.jpg",
style:     "around"
)
Theme.create(
name:      'Mont Fuji',
descr:     "Le volcan mythique.",
image:     "fuji.jpg",
gallery:   "fuji001.jpg",
style:     "around"
)
