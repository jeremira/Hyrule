# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

#Theme by Theme

Theme.create(
name:      'Gastronomes',
descr:     "Goutez à toute la richesse de la gastronomie japonaise",
image:     "food.jpg",
gallery:   "food001.jpg food002.jpg food003.jpg food004.jpg",
style:     "theme"
)
Theme.create(
name:      'Otaku',
descr:     "Plongez dans l'univers des mangas et des animes.",
image:     "anime.jpg",
gallery:   "anime002.jpg anime003.jpg",
style:     "theme"
)
Theme.create(
name:      'Tradition',
descr:     "Laissez vous envahir par l'harmonie de la culture et des traditions du japon.",
image:     "tradi.jpg",
gallery:   "tradi002.jpg tradi003.jpg tradi004.jpg tradi005.jpg",
style:     "theme"
)
Theme.create(
name:      'Hipster',
descr:     "Découvrez un Tokyo vivant, tendance et contemporain."
image:     "tradi.jpg",
gallery:   "tradi002.jpg tradi003.jpg tradi004.jpg tradi005.jpg",
style:     "theme"
)

#Theme Out of Tokyo

Theme.create(
name:      'Hakone',
descr:     "Volcans et Onsen dans un cadre naturel magnifique.",
image:     "hakone.jpg",
gallery:   "hakone001.jpg",
style:     "around"
)
Theme.create(
name:      'Kamakura',
descr:     "Des temples majestueux ornent une ville en bord de mer.",
image:     "kamakura.jpg",
gallery:   "kamakura001.jpg kamakura002.jpg kamakura003.jpg kamakura004.jpg",
style:     "around"
)
Theme.create(
name:      'Nikko',
descr:     "Au coeur d'une foret sacré, un ancien complexe impérial et religieux extraordinaire.",
image:     "nikko.jpg",
gallery:   "nikko001.jpg",
style:     "around"
)
Theme.create(
name:      'Mont Fuji',
descr:     "Admirez le mont Fuji depuis la région des lacs.",
image:     "fuji.jpg",
gallery:   "fuji001.jpg",
style:     "around"
)





__END__
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
